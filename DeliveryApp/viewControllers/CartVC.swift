//
//  CartVC.swift
//  DeliveryApp
//
//  Created by kh on 8/14/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit

extension UIViewController {
    
    
    func hideKeyBoard() {
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyBoard() {
        view.endEditing(true)
    }
}

class CartVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate , MyCellDelegate {
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var searchBorder: UILabel!
    @IBOutlet weak var searchTextF: UITextField!
    
    func btnCloseTapped(cell: UIView) {
        let indexPath = self.tableView.indexPath(for: cell as! UITableViewCell)
        self.indexPath = indexPath!.row
        
    }
    

    @IBOutlet weak var coupenBorder: UILabel!
    @IBOutlet weak var noteBorder: UILabel!
    @IBOutlet weak var continueToPaymentView: UIView!
    @IBOutlet weak var couponView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var continuePaymentValue: UILabel!
    
    
    @IBOutlet weak var chargeView: UIView!
    @IBOutlet weak var chargeViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var toPaymentViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var couponViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var labelSubtotal: UILabel!
    @IBOutlet weak var labelDeliveryCharge: UILabel!
    @IBOutlet weak var labelTotal: UILabel!
    
    
    
    
    weak var delegate: ProductListVCDelegate?
    var cartItem = [ProductItem]()
    var indexPath = 0
    var count : Int = 1
   
    var orderItemData: [OrderedProductItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let logo = UIImage(named: "ic_logo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        self.searchView.isHidden = true
        self.hideKeyBoard()
        
 
       let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hidekeyBoard))
        view.addGestureRecognizer(tapGesture)
        
    }
    @objc func hidekeyBoard() {
        view.endEditing(true)
    }
    @IBAction func searchDisable(_ sender: Any) {
           searchView.isHidden = true
           searchImage.isHidden = false
        searchTextF.text = nil
        view.endEditing(true)
           
       }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            coupenBorder.backgroundColor = UIColor(red: 0, green: 174, blue: 239)
        } else if textField.tag == 0 {
           noteBorder.backgroundColor = UIColor(red: 0, green: 174, blue: 239)
        }
        searchImage.isHidden = true
        searchBorder.backgroundColor = UIColor(red: 0, green: 174, blue: 239)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.endEditing(true)
        coupenBorder.backgroundColor = .gray
        noteBorder.backgroundColor = .gray
        self.view.endEditing(true)
        searchBorder.backgroundColor = .gray
        textField.text = nil
        searchView.isHidden = true
    }
    
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func onSearch(_ sender: Any) {
      searchView.isHidden = false
        
    }
    
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        let cancelSearchBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelBarButtonItemClicked))
        self.navigationItem.setRightBarButton(cancelSearchBarButtonItem, animated: true)
        return true
    }
    @objc func cancelBarButtonItemClicked (searchBar: UISearchBar) {
        navigationItem.searchController = nil
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = false
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let orderItemData = AppConstants.getCartItems()
        if orderItemData.isEmpty == false {
        if let tabItems = tabBarController?.tabBar.items {
            
            var sum_count = 0
            for item in orderItemData {
                sum_count += item.getCount()
            }
            
            let tabItem = tabItems[3]
            tabItem.badgeValue = String(sum_count)
        }
        } else {
            if let tabItems = tabBarController?.tabBar.items {
                let tabItem = tabItems[3]
                tabItem.badgeValue = nil
            }
        }
            
        return AppConstants.getCartItems().count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderProductListCell", for: indexPath) as! OrderProductListCell
        cell.delegate = self
        let data = orderItemData[indexPath.row]
        cell.setOrderProductData(data: data)
        cell.selectionStyle = .none
        cell.btnIncrease.tag = indexPath.row + 1000
        cell.btnDecrease.tag = indexPath.row + 2000
        cell.txtCount.tag = indexPath.row + 3000
        cell.txtPrice.tag = indexPath.row + 4000
        
        cell.btnIncrease.addTarget(self, action: #selector(increateBtn1Tapped), for: .touchUpInside)
        cell.btnDecrease.addTarget(self, action: #selector(decreateBtn1Tapped), for: .touchUpInside)
        
        return cell
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func couponSendAction(_ sender: Any) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        self.view.endEditing(true)
    }
    @IBAction func btnContinueClicked(_ sender: Any) {
        AppConstants.orderedProductList = orderItemData
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "placeOrderVC")as! PlaceOrderVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func contactVc(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "contactVC") as! ContactVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func decreateBtn1Tapped(sender: UIButton) {
        let indexPathRow = sender.tag - 2000
        let item = orderItemData[indexPathRow]
        let itemCount: Int = item.count
        
        if itemCount > 1 {
            item.count -= 1
            orderItemData[indexPathRow] = item
            tableView.reloadData()
            
            setUpPriceLabels()
        } else {
            let alertController = UIAlertController(title: "WARNING", message:
                "Are you sure you want to remove this item?", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "No", style: .default, handler: { (action) in
                
            }))
            
            alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                self.orderItemData.remove(at: indexPathRow)
                self.cartItem = AppConstants.getCartItems()
                self.cartItem.remove(at: indexPathRow)
                
                var jsonDict = [[String: Any]]()
                for child in self.cartItem {
                    jsonDict.append(child.toDictionary())
                }
                self.showToast(message: "Item Removed ")
                LocalStorage[SAVED_CARTS] = jsonDict
                self.delegate?.setUpCartItems()
    
                self.tableView.reloadData()
                
                self.setUpPriceLabels()

                if AppConstants.getCartItems().count == 0 {
                    UIView.animate(withDuration: 1.0) {
                        self.tableView.isHidden = true
                        self.emptyView.isHidden = false
                        self.chargeView.isHidden = true
                        self.continueToPaymentView.isHidden = true
                        
                        self.chargeViewTopConstraint.constant = -60
                        self.toPaymentViewBottomConstraint.constant = 60
                    }
                }
            }))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    var price = 5.99
    @objc func increateBtn1Tapped(sender: UIButton) {
        let indexPathRow = sender.tag - 1000
        let item = orderItemData[indexPathRow]
        
        item.count += 1
        orderItemData[indexPathRow] = item
        tableView.reloadData()
        
        self.cartItem = AppConstants.getCartItems()
        let newItem = self.cartItem[indexPathRow]
        newItem.count += 1
        self.cartItem = AppConstants.getCartItems()
        self.cartItem[indexPathRow] = newItem
        
        var jsonDict = [[String: Any]]()
        for child in self.cartItem {
            jsonDict.append(child.toDictionary())
        }
        LocalStorage[SAVED_CARTS] = jsonDict
        self.delegate?.setUpCartItems()
        
        setUpPriceLabels()
    }
    
    private func setUpPriceLabels() {
        var subtotal: Float = 0
        var totalCount = 0
        
        for item in orderItemData {
            subtotal += item.getPrice()*Float(item.getCount())
            totalCount += item.getCount()
        }
        
        labelSubtotal.text = "$" + String(format: "%.2f", subtotal)
        labelTotal.text = "$" + String(format: "%.2f", subtotal+4.00)
        continuePaymentValue.text = "\(totalCount) Item : " + "$" + String(format: "%.2f", subtotal+4.00)
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        var subtotal: Float = 0
        
        for item in orderItemData {
            subtotal += item.getPrice()*Float(item.getCount())
        }
                
        DateUtils.ContinueToPaymentValue = String(format: "%.2f", subtotal+4.00)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print("notification: Keyboard will show")
            
            UIView.animate(withDuration: 0.5) {
                self.couponViewBottomConstraint.constant = (keyboardSize.height - 102 - 50)
                self.view.layoutIfNeeded()
            }
            
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
         
            UIView.animate(withDuration: 0.5) {
                self.couponViewBottomConstraint.constant = 0
                self.view.layoutIfNeeded()
            }

            self.view.endEditing(true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool){
        loadData()
        self.navigationController?.navigationBar.isHidden = true
       // tableView.reloadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func loadData() {
        orderItemData = []
        
        for item in AppConstants.getCartItems() {
            orderItemData.append(OrderedProductItem(image: "1", title: item.productName, feature: "Medium | New Hand tossed", desc: item.description, price: item.price, count: item.count, date: item.getDate(), size: item.size, crust: item.crust, topic: item.topic))
        }
        
        let isTrue = DateUtils.isTrueContinueToPayment
        if isTrue {
            DateUtils.isTrueContinueToPayment = false
        }
        
        setUpPriceLabels()
        self.tableView.reloadData()
        
        if orderItemData.count > 0 {
            
            self.tableView.isHidden = false
            self.emptyView.isHidden = true
            self.chargeView.isHidden = false
            self.continueToPaymentView.isHidden = false
            
            self.chargeViewTopConstraint.constant = 0
            self.toPaymentViewBottomConstraint.constant = 0
            
        } else {
            self.tableView.isHidden = true
            self.emptyView.isHidden = false
            self.chargeView.isHidden = true
            self.continueToPaymentView.isHidden = true
            
            self.chargeViewTopConstraint.constant = -60
            self.toPaymentViewBottomConstraint.constant = 60
        }
    }
}
