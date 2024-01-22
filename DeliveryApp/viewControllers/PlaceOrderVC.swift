//
//  ViewController.swift
//  DeliveryApp
//
//  Created by dbug-mac on 08/08/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit
import iOSDropDown

class PlaceOrderVC: UIViewController ,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    
//    @IBOutlet weak var selectCollectionlbl: UILabel!
//    @IBOutlet weak var selectDeliveryLabel: UILabel!
    
    @IBOutlet weak var btnDeliveryTime: UIButton!
    @IBOutlet weak var btnCollectionTim: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var btnDeliverySel: UIButton!
    @IBOutlet weak var btnCollectionSel: UIButton!
    @IBOutlet weak var homeAddressView: UIView!
    @IBOutlet weak var officeAddressView: UIView!
    @IBOutlet weak var HomeContainer: UIView!
    @IBOutlet weak var OfficeContainer: UIView!
   
    @IBOutlet weak var deliTimeDropdown: DropDown!
    @IBOutlet weak var collTimeDropdown: DropDown!
    
    
    @IBOutlet weak var btnDeliverySelView: UIView!
    @IBOutlet weak var btnCollectoinSelView: UIView!
    @IBOutlet weak var btnCollectionSelLeftLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnDeliverySelLeftLayoutConstraint: NSLayoutConstraint!

    @IBOutlet weak var labelWhereTo: UILabel!
    @IBOutlet weak var buttonAddAddress: UIButton!
    
    var isCollectionTV: Bool = false
    
    
    var textColl:String = "ASAP"
    var textDeli: String = "ASAP"
    
    var goNextEnable : Bool = true
    var isAddedAddress: Bool = false
    
//    @IBOutlet weak var timeIntervalPicker: LETimeIntervalPicker! {
//        didSet {
//            timeIntervalPicker.set(numberOfRows: 60, for: .minutes)
//            timeIntervalPicker.set(numberOfRows: 4, for: .hours)
//            timeIntervalPicker.components = [.hours, .minutes]
//        }
//    }
    var delivery_timer_clicked = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = true
   
        self.displayDropdown()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        deliTimeDropdown.inputView = UIView()
        collTimeDropdown.inputView = UIView()
//        selectDeliveryLabel.isHidden = true
//        selectCollectionlbl.isHidden = true
//        let min = dateFormatter.date(from: "9:00")
//        let max = dateFormatter.date(from: "12:00")
//        datePicker.minimumDate = min
//        datePicker.maximumDate = max
//        
//        var components = Calendar.current.dateComponents([.hour, .minute, .month, .year, .day], from: datePicker.date)
//        
//        if components.hour! < 7 {
//            components.hour = 7
//            components.minute = 0
//            datePicker.setDate(Calendar.current.date(from: components)!, animated: true)
//        }
//        else if components.hour! > 21 {
//            components.hour = 21
//            components.minute = 59
//            datePicker.setDate(Calendar.current.date(from: components)!, animated: true)
//        }
//        else {
//            print("Everything is fine!")
//        }
    
    }
    
    @IBAction func tapDeliverySel(_ sender: UIButton) {
        isCollectionTV = false

        btnDeliverySelView.layer.borderWidth = 1
        btnCollectoinSelView.layer.borderWidth = 0
        
        labelWhereTo.text = "Where to Deliver?"
        buttonAddAddress.isHidden = false
        isAddedAddress = false

        tableView.reloadData()
    }
    
    @IBAction func tapCollectionSel(_ sender: UIButton) {
        isCollectionTV = true
        
        btnDeliverySelView.layer.borderWidth = 0
        btnCollectoinSelView.layer.borderWidth = 1
        
        labelWhereTo.text = "Where to Collect?"
        buttonAddAddress.isHidden = true
        isAddedAddress = true

        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isCollectionTV {
            return 1
        }
        return AppConstants.addressList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressListCell", for: indexPath) as! TableViewCell
        cell.contentView2.borderWidth = 0

        if isCollectionTV {
            cell.txtType.text = "Restaurant"
            cell.txtAddress.text = "1011 US Hwy 72 East, Athens AL 35611. 1717 South College Street, Auburn AL 36830. 701 Mcmeans Ave"
            cell.btnRemove.isHidden = true
        } else {
            cell.setAddressData(data: AppConstants.addressList[indexPath.row])
            cell.btnRemove.isHidden = false
            cell.btnRemove.tag = indexPath.row
            cell.btnRemove.addTarget(self, action: #selector(deleteFromAddresses), for: .touchUpInside)
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if let cell = tableView.cellForRow(at: indexPath) as? TableViewCell {
            if !isCollectionTV {
                cell.contentView2.borderColor = UIColor(netHex: 0x32b7f6)
                cell.contentView2.borderWidth = 1
            }
            
            isAddedAddress = true
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? TableViewCell {
            cell.contentView2.borderColor = .gray
            cell.contentView2.borderWidth = 0
            isAddedAddress = false
        }
    }
    @objc func deleteFromAddresses(sender: UIButton!) {
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to remove?", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            self.showToast(message: "Address Removed")
            AppConstants.addressList.remove(at: sender.tag)
            self.tableView.reloadData()
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
        
        
    }
    @objc func keyboardWillShow(sender: Notification) {
        print("key")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool){
        self.navigationController?.navigationBar.isHidden = true
        tableView.reloadData()
        
    }

    @IBAction func actnConfirm(_ sender: Any) {
        if goNextEnable {
            
            if isAddedAddress {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "PaymentVC")as! PaymentVC
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                showToast(message: "Please select address.")
            }
            
        }else{
            showToast(message: "Please select time.")
        }
    }
    
    @IBAction func onBackPressed(_ sender: Any) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.popViewController(animated: true)
    }
   

    @IBAction func onHomeRemove(_ sender: Any) {
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to remove?", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            self.showToast(message: "Item Removed")
            self.HomeContainer.isHidden = true
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    
    @IBAction func onOfficeRemove(_ sender: Any) {
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to remove?", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            
            self.OfficeContainer.isHidden = true
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
       // textField.text = "Select"
        //textField.isHidden = true
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //textField.isHidden = false
    }
    
    @IBAction func btnChangePressed(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddAddressVC")as! AddAddressVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func deliverySelPressed(_ sender: Any) {
        let buttonImage = btnDeliverySel.image(for: .normal) == UIImage(named: "gray") ? UIImage(named: "green") : UIImage(named: "gray")
        btnDeliverySel.setImage(buttonImage, for: .normal)
    }
    
    @IBAction func collectionSelPressed(_ sender: Any) {
        let buttonImage = btnCollectionSel.image(for: .normal) == UIImage(named: "gray") ? UIImage(named: "green") : UIImage(named: "gray")
        btnCollectionSel.setImage(buttonImage, for: .normal)
    }
    
    @IBAction func homeAddressSelected(_ sender: Any) {
        officeAddressView.layer.borderWidth = 0

        homeAddressView.layer.borderWidth = 1
        homeAddressView.layer.borderColor = UIColor.gray.cgColor
        homeAddressView.layer.cornerRadius = 5
    }
    
    @IBAction func officeAddressSelected(_ sender: Any) {
        homeAddressView.layer.borderWidth = 0

        officeAddressView.layer.borderWidth = 1
        officeAddressView.layer.borderColor = UIColor.gray.cgColor
        officeAddressView.layer.cornerRadius = 5
    }
    
    @IBAction func onSelectDeliveryTime(_ sender: Any) {
        self.deliTimeDropdown.touchAction()
    }
    
    @IBAction func onSelectCollectionTime(_ sender: Any) {
        self.collTimeDropdown.touchAction()
    }
    
    func displayDropdown() {
        self.deliTimeDropdown.selectedRowColor = UIColor.white
        self.collTimeDropdown.selectedRowColor = UIColor.white
        self.deliTimeDropdown.text = "ASAP"
        self.collTimeDropdown.text = "ASAP"
        self.collTimeDropdown.textAlignment = .right
        self.deliTimeDropdown.textAlignment = .right
        self.deliTimeDropdown.listWillAppear {
            self.view.gestureRecognizers?.forEach(self.view.removeGestureRecognizer)
            self.deliTimeDropdown.text = "Select"
//            self.selectDeliveryLabel.isHidden = false
         
        }
        self.deliTimeDropdown.listWillDisappear {
            self.goNextEnable = true
            self.hideKeyBoard()
            //self.selectDeliveryLabel.isHidden = true
        }
        self.deliTimeDropdown.listDidDisappear {
//            self.selectDeliveryLabel.isHidden = true
        }
        deliTimeDropdown.optionArray = ["ASAP", "06:00", "06:30", "07:00", "07:30", "08:00", "08:30", "09:00", "09:30", "10:00", "10:30", "11:00", "11:30", "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30", "16:00", "16:30", "17:00", "17:30", "18:00", "18:30"]
        deliTimeDropdown.optionIds = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26]
        
        self.collTimeDropdown.listWillAppear {
            self.view.gestureRecognizers?.forEach(self.view.removeGestureRecognizer)
            self.collTimeDropdown.text = "Select"
//            self.selectCollectionlbl.isHidden = false
            
            
        }
        
       
        self.collTimeDropdown.listWillDisappear {
            self.hideKeyBoard()
            self.goNextEnable = true
            
            
        }
        
        self.collTimeDropdown.listDidDisappear {
//            self.selectCollectionlbl.isHidden = true
        }
        collTimeDropdown.optionArray = ["ASAP","06:00", "06:30", "07:00", "07:30", "08:00", "08:30", "09:00", "09:30", "10:00", "10:30", "11:00", "11:30", "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30", "16:00", "16:30", "17:00", "17:30", "18:00", "18:30"]
        collTimeDropdown.optionIds = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26]
    }
    
    private func showTimePicker() {
//        DatePickerPopover(title: "")
//            .setDateMode(.time)
//            .setSelectedDate(Date())
//            .setMinuteInterval(43)
//            .setDoneButton(action: { popover, selectedDate in
//                let str = DateUtils.convertDateToStr(date: selectedDate, format: "HH:mm:ss")
//            })
//            .setCancelButton(action: { _, _ in })
//            .appear(originView: btnDeliveryTime, baseViewController: self)
    }
}

