//
//  OrderedProductListVC.swift
//  DeliveryApp
//
//  Created by kh on 8/13/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit

class OrderedProductListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var orderedItemData: [OrderedProductItem] = []
    
    func loadData() {
        orderedItemData.append(OrderedProductItem(image: "1", title: "Farm House", feature: "Medium | New hand tossed", desc: "Black Olives, Onion, capsicum, tomato, grilled mushroom, golden com, Jalapeno Extra chese", price: 5.99, count: 1, date: "", size: 1, crust: 1, topic: [0, 0, 1, 0, 0]))
        orderedItemData.append(OrderedProductItem(image: "2", title: "Iced Cod", feature: "Large", desc: "No customization available", price: 1.99, count: 1, date: "", size: 1, crust: 1, topic: [0, 1, 0, 2, 0]))
        orderedItemData.append(OrderedProductItem(image: "3", title: "Farm House", feature: "Medium | New hand tossed", desc: "Black Olives, Onion, capsicum, tomato, grilled mushroom, golden com, Jalapeno Extra chese", price: 8.99, count: 1, date: "", size: 1, crust: 1, topic: [0, 1, 0, 2, 0]))
        orderedItemData.append(OrderedProductItem(image: "1", title: "Farm House", feature: "Medium | New hand tossed", desc: "Black Olives, Onion, capsicum, tomato, grilled mushroom, golden com, Jalapeno Extra chese", price: 5.99, count: 1, date: "", size: 1, crust: 1, topic: [0, 1, 0, 0, 0]))
        orderedItemData.append(OrderedProductItem(image: "2", title: "Iced Cod", feature: "Large", desc: "No customization available", price: 1.99, count: 1, date: "", size: 1, crust: 1, topic: [0, 1, 0, 0, 0]))
        orderedItemData.append(OrderedProductItem(image: "3", title: "Farm House", feature: "Medium | New hand tossed", desc: "Black Olives, Onion, capsicum, tomato, grilled mushroom, golden com, Jalapeno Extra chese", price: 8.99, count: 1, date: "", size: 1, crust: 1, topic: [0, 1, 0, 0, 0]))
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool){
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    @IBAction func onEditAddress(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddAddressVC")as! AddAddressVC
        //self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderedItemData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderedProductListCell", for: indexPath) as! OrderedProductListCell
        let data = orderedItemData[indexPath.row]
        cell.setOrderedProductData(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    @IBAction func onBackPressed(_ sender: Any) {
        
       self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.popViewController(animated: true)
    }
    
}
