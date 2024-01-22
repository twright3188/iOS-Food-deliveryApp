//
//  OrderedProductItem.swift
//  DeliveryApp
//
//  Created by kh on 8/13/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import Foundation

class OrderedProductItem {
    var productImage: String!
    var productTitle: String!
    var productFeature: String!
    var productDescription: String!
    var productPrice: Float!
    var count: Int!
    var size: Int
    var crust: Int
    var topic: [Int]
    var dateString: String!

    init(image: String, title: String, feature: String, desc: String, price: Float, count: Int, date: String, size: Int, crust: Int, topic: [Int]) {
        self.productImage = image
        self.productTitle = title
        self.productFeature = feature
        self.productDescription = desc
        self.productPrice = price
        self.count = count
        self.size = size
        self.crust = crust
        self.topic = topic
        self.dateString = date
    }
    
    func toDictionary() -> [String: Any] {
        var dict = [String: Any]()
        dict["productImage"] = productImage
        dict["productTitle"] = productTitle
        dict["productFeature"] = productFeature
        dict["productDescription"] = productDescription
        dict["productPrice"] = productPrice
        dict["count"] = count
        dict["size"] = size
        dict["crust"] = crust
        dict["topic"] = topic
        dict["dateString"] = dateString

        return dict
    }
    
    public func getImage() -> String {
        return self.productImage
    }
    
    public func getTitle() -> String {
        return self.productTitle
    }
    
    public func getFeature() -> String {
        return self.productFeature
    }
    
    public func getDescription() -> String {
        return self.productDescription
    }
    
    public func getPrice() -> Float {
        return self.productPrice
    }
    
    public func getCount() -> Int {
        return self.count
    }
    
    public func getDateString() -> String {
        return self.dateString
    }
    
    
}
