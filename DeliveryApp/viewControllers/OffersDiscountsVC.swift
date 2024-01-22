//
//  OffersDiscountsVC.swift
//  DeliveryApp
//
//  Created by kh on 8/12/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit

class OffersDiscountsVC: UIViewController, UITableViewDelegate, UITableViewDataSource ,UITextFieldDelegate {
    @IBOutlet weak var searchView: UIView!
      @IBOutlet weak var searchImage: UIImageView!
      @IBOutlet weak var searchBorder: UILabel!
    @IBOutlet weak var searchTextF: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    var offersDiscountsData: [OffersDiscountsItem] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offersDiscountsData.count
    }
    
    @IBAction func onSearch(_ sender: Any) {
       searchView.isHidden = false
    }
    @IBAction func contactVc(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "contactVC") as! ContactVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func hidekeyBoard() {
        view.endEditing(true)
    }
    @IBAction func searchDisable(_ sender: Any) {
        searchView.isHidden = true
        view.endEditing(true)
        searchImage.isHidden = false
        searchTextF.text = nil
        
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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "offersDiscountsCell", for: indexPath) as! OffersDiscountsCell
        cell.setData(offersDiscountsData[indexPath.row])
        cell.cellView.tag = indexPath.row
    
            cell.cellView.addTarget(self, action: #selector(copiedCode), for: .touchUpInside)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.tableView.estimatedRowHeight = 150
//        self.tableView.rowHeight = UITableView.automaticDimension
        let logo = UIImage(named: "ic_logo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        self.tableView.backgroundColor = UIColor.clear
        loadData()
        self.searchView.isHidden = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hidekeyBoard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func copiedCode(sender: UIButton!) {
        UIPasteboard.general.string = offersDiscountsData[sender.tag].getActionTitle()
       
        let actionTitle : String = "Copied to Keyboard"
        
        showToast(message: actionTitle)
    }
    
    func loadData() {
        offersDiscountsData.append(OffersDiscountsItem.init("New User? First Pizza Free!!", desc: "Oh! You're new User? Order your first pizza now for Free & just pay for delivery charges. Terms & Conditions apply.",actionTitle: "NEW4FREE"))
            
        offersDiscountsData.append(OffersDiscountsItem.init("Buy 2 Large Pizza & Get 1 Large for free", desc: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore.",actionTitle: "BUY2GET1"))
                
        offersDiscountsData.append(OffersDiscountsItem.init("Combo Bonanza 50% Off", desc: "Lorem ipsum dolor sit amet, consectetur adipidisicing elit, sed do eiusmod tempor incididunt ut labore et dolore", actionTitle: "COMBO50"))
                
        offersDiscountsData.append(OffersDiscountsItem.init("Buy 3 Medium & Get 2 Small Pizza for free", desc: "Oh! You're new User? Order your first pizza now for Free & just pay for delivery charges. Terms & Condition apply", actionTitle: "BUY3GET2"))
        self.tableView.reloadData()
    }

    @IBAction func onBackPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool){
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
}
