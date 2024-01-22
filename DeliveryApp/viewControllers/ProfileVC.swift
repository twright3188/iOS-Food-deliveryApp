//
//  ProfileVC.swift
//  DeliveryApp
//
//  Created by kh on 8/13/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var emailBorder: UILabel!
    @IBOutlet weak var fullBorder: UILabel!
    @IBOutlet weak var phnNumerBorder: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyBoard()
        loadData()
        
        let logo = UIImage(named: "ic_logo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        // Do any additional setup after loading the view.
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        emailBorder.backgroundColor = .gray
        fullBorder.backgroundColor = .gray
        phnNumerBorder.backgroundColor = .gray
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 0 {
            phnNumerBorder.backgroundColor = UIColor(red: 0, green: 174, blue: 239)
        }else if  textField.tag == 1 {
            fullBorder.backgroundColor = UIColor(red: 0, green: 174, blue: 239)
        } else {
            emailBorder.backgroundColor = UIColor(red: 0, green: 174, blue: 239)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func contactVc(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "contactVC") as! ContactVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppConstants.addressList.count
    }
    
    @IBAction func onLogout(_ sender: Any) {
        
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to logout?", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "Logout", style: .default, handler: { (action) -> Void in
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.goToLoginView()
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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressListCell", for: indexPath) as! AddressListCell
        
        cell.setAddressData(data: AppConstants.addressList[indexPath.row])
        cell.selectionStyle = .none
        cell.btnRemove.tag = indexPath.row
        cell.btnRemove.addTarget(self, action: #selector(deleteFromAddresses), for: .touchUpInside)
        
        return cell
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
    
    @IBAction func onBackPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool){
        self.navigationController?.navigationBar.isHidden = false
        self.tableView.reloadData()
        
    }
    
    @IBAction func changePasswordPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Password Changed", message:
                        "", preferredStyle: .alert)
        
        alertController.addTextField { (textField: UITextField) in
            let heightConstraint = NSLayoutConstraint(item: textField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 28)
            textField.addConstraint(heightConstraint)
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.placeholder = "Type old password"
            textField.isSecureTextEntry = true
            textField.font = UIFont(name: "", size: 14)
        }
        
        alertController.addTextField { (textField: UITextField) in
            let heightConstraint = NSLayoutConstraint(item: textField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 28)
            textField.addConstraint(heightConstraint)
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.placeholder = "Type new password"
            textField.isSecureTextEntry = true
            textField.font = UIFont(name: "", size: 14)
        }
        
        alertController.addTextField { (textField: UITextField) in
            let heightConstraint = NSLayoutConstraint(item: textField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 28)
            textField.addConstraint(heightConstraint)
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.placeholder = "Retype new password"
            textField.isSecureTextEntry = true
            textField.font = UIFont(name: "", size: 14)
        }
        
        alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in
            self.showToast(message: "Password Change")
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in }))
        
        //alertController.view.tintColor = UIColor.green
        alertController.view.layer.cornerRadius = 20

        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func addNewPressed(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddAddressVC")as! AddAddressVC
       self.navigationController?.pushViewController(vc, animated: true)
    }
    

    
    func loadData() {
        //AppConstants.addressList.append(AddressItem(type: "Home", address: "1011 US Hwy 72 East, Athens AL 35611. 1717 South College Street, Auburn AL 36830. 701 Mcmeans Ave"))
       // AppConstants.addressList.append(AddressItem(type: "Home", address: "1011 US Hwy 72 East, Athens AL 35611. 1717 South College Street, Auburn AL 36830. 701 Mcmeans Ave"))
        self.tableView.reloadData()
    }
}
