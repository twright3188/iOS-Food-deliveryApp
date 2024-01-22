//
//  ProductListVC.swift
//  DeliveryApp
//
//  Created by kh on 8/12/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit

class ProductListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: ProductListVCDelegate?
   
    @IBOutlet weak var tableView: UITableView!
    var selectedProduct: ProductItem!
    var productList: [ProductItem] = []
    var cartItems = [ProductItem]()
    
    var isKeyboardShown: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.backgroundColor = UIColor.clear
        loadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc func keyboardDidShow(_ notification: Notification) {
        isKeyboardShown = true
    }
    
    @objc func keyboardDidHide(_ notification: Notification) {
        isKeyboardShown = false
    }
    
    @objc func viewItem(sender: UIButton!) {
        if isKeyboardShown {
            delegate?.shouldHideKeyboard()
        } else {
            selectedProduct = productList[sender.tag]
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "orderPlacingVC") as! OrderPlacingVC
            vc.selectedProduct = self.selectedProduct
            if #available(iOS 11.0, *) {
                FoodListVC.__shared?.navigationController?.pushViewController(vc, animated: true)
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    @objc func addToCart(sender: UIButton!) {
        selectedProduct = productList[sender.tag]

        selectedProduct.size = 2
        selectedProduct.topic = [0, 2, 0, 1, 0]
        selectedProduct.crust = 1

        cartItems = AppConstants.getCartItems()
        cartItems.append(selectedProduct)
        var jsonDict = [[String: Any]]()
        for child in cartItems {
            jsonDict.append(child.toDictionary())
        }
        showToast(message: "Added to cart")
        LocalStorage[SAVED_CARTS] = jsonDict
        delegate?.setUpCartItems()
    }
    
    @objc func deleteFromFavorites(sender: UIButton!) {
        productList.remove(at: sender.tag)
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favouriteTableCell", for: indexPath) as! FavouriteListCell
        cell.setItemData(data: productList[indexPath.row])
        cell.selectionStyle = .none
        cell.btnAddToCart.tag = indexPath.row
        
        if indexPath.row % 2 == 1 {
            cell.btnAddToCart.setTitle("ADD TO CART", for: .normal)
            cell.btnAddToCart.tag = indexPath.row
            cell.btnAddToCart.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
            cell.btnViewCard.isHidden = true
        } else {
            cell.btnAddToCart.backgroundColor = UIColor(netHex: 0xB3B3B3)
            cell.btnAddToCart.setTitle("VIEW ITEM", for: .normal)
            cell.btnAddToCart.tag = indexPath.row
            cell.btnViewCard.addTarget(self, action: #selector(viewItem), for: .touchUpInside)
            cell.btnViewCard.isHidden = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = productList[indexPath.row]
        if(data.oneType()) {
            return 230 - 40
        } else {
            return 230 - 40
        }
    }
    
    func loadData() {
        productList.append(ProductItem(id: 1, name: "FARM HOUSE", desc: "A pizza that goes ballistic on veggies! Check out this mouth watering overload of crunchy, crisp capsicum, succulent, etc.ballistic on veggies! Check out this mouth watering overload of ", price: 5.99, oneType: true, count: 1))
        productList.append(ProductItem(id: 2, name: "FARM HOUSE 1", desc: "A pizza that goes ballistic on veggies! Check out this mouth watering overload of crunchy, crisp capsicum, succulent, etc. ballistic on veggies! Check out this mouth watering overload of", price: 5.99, oneType: false, count : 1))
        productList.append(ProductItem(id: 3, name: "FARM HOUSE 2", desc: "A pizza that goes ballistic on veggies! Check out this mouth watering overload of crunchy, crisp capsicum, succulent, etc.ballistic on veggies! Check out this mouth watering overload of ", price: 5.99, oneType: true, count: 1))
        productList.append(ProductItem(id: 4, name: "FARM HOUSE 3", desc: "A pizza that goes ballistic on veggies! Check out this mouth watering overload of crunchy, crisp capsicum, succulent, etc. ballistic on veggies! Check out this mouth watering overload of", price: 5.99, oneType: false, count : 1))
        productList.append(ProductItem(id: 5, name: "FARM HOUSE 4", desc: "A pizza that goes ballistic on veggies! Check out this mouth watering overload of crunchy, crisp capsicum, succulent, etc.ballistic on veggies! Check out this mouth watering overload of ", price: 5.99, oneType: true, count: 1))
        self.tableView.reloadData()
    }
}

protocol ProductListVCDelegate: class {
    func setUpCartItems()
    func shouldHideKeyboard()

}
