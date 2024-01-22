//
//  ProductItem.swift
//  DeliveryApp
//
//  Created by jonh on 8/12/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import Foundation

class ProductItem {
    var itemID: Int
    var isOneType: Bool!
    var productName: String!
    var description: String!
    var price: Float!
    var count: Int
    var size: Int
    var crust: Int
    var topic: [Int]
    var date: String!

    init(id: Int, name: String, desc: String, price: Float, oneType: Bool, count: Int) {
        self.itemID = id
        self.isOneType = oneType
        self.productName = name
        self.description = desc
        self.price = price
        self.count = count
        self.size = 1
        self.crust = -1
        self.topic = [0, 0, 0, 0, 0]
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy, HH:mm:ss a"
        self.date = formatter.string(from: Date())
    }
    
    init(_ json: [String: Any]) {
        itemID = (json["itemID"] as? Int)!
        price = Float("\(json["price"]!)")
        isOneType = (json["oneType"] as? Bool)!
        productName  = (json["name"] as? String)!
        description = (json["desc"] as? String)!
        count = (json["count"] as? Int)!
        size = (json["size"] as? Int)!
        crust = (json["crust"] as? Int)!
        topic = (json["topic"] as? [Int])!
        date = (json["date"] as? String)!
    }
    
    func toDictionary() -> [String: Any] {
        var dict = [String: Any]()
        dict["itemID"] = itemID
        dict["price"] = price
        dict["oneType"] = isOneType
        dict["name"] = productName
        dict["desc"] = description
        dict["count"] = count
        dict["size"] = size
        dict["crust"] = crust
        dict["topic"] = topic
        dict["date"] = date
        return dict
    }
    
    public func getProductName() -> String {
        return self.productName
    }
    
    public func getDescription() -> String {
        return self.description
    }
    
    public func oneType() -> Bool {
        return self.isOneType
    }
    
    public func getPrice() -> Float {
        return self.price
    }
    
    public func setPrice(price: Float) {
        self.price = price
    }
    
    public func getCount() -> Int {
        return self.count
    }
    
    public func setCount(count: Int) {
        self.count = count
    }
    
    public func getDate() -> String {
        return self.date
    }
    
    public func setDate(date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy, HH:mm:ss a"
        self.date = formatter.string(from: date)
    }
    
}
