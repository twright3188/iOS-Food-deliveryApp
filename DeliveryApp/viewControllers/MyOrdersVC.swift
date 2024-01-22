//
//  MyOrdersVC.swift
//  DeliveryApp
//
//  Created by kh on 8/13/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit

class MyOrdersVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var searchBorder: UILabel!
    @IBOutlet weak var searchTextF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let logo = UIImage(named: "ic_logo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hidekeyBoard))
               view.addGestureRecognizer(tapGesture)
        self.searchView.isHidden = true
       
    }
    @IBAction func searchDisable(_ sender: Any) {
           searchView.isHidden = true
           searchTextF.text = nil
           searchImage.isHidden = false
           view.endEditing(true)
       }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchImage.isHidden = true
        searchBorder.backgroundColor = UIColor(red: 0, green: 174, blue: 239)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.endEditing(true)
        searchBorder.backgroundColor = .gray
        textField.text = nil
        searchView.isHidden = true
    }
    @objc func hidekeyBoard() {
        view.endEditing(true)
    }
    @IBAction func onBackPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSearch(_ sender: Any) {
        searchView.isHidden = false
    }

    @IBAction func contactVc(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "contactVC") as! ContactVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func pastOrderPressed(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OrderedProductListVC")as! OrderedProductListVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool){
        self.navigationController?.navigationBar.isHidden = true
        let orderItemData = AppConstants.getCartItems()
              if orderItemData.isEmpty == false {
              if let tabItems = tabBarController?.tabBar.items {
                  
                  // In this case we want to modify the badge number of the third tab:
                  let tabItem = tabItems[3]
                  tabItem.badgeValue = String(orderItemData.count)
              }
              } else {
                  if let tabItems = tabBarController?.tabBar.items {
                      
                      // In this case we want to modify the badge number of the third tab:
                      let tabItem = tabItems[3]
                      tabItem.badgeValue = nil
                  }
              }
    }
}
