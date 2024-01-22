//
//  OffersDiscountsItem.swift
//  DeliveryApp
//
//  Created by jonh on 8/12/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import Foundation

class OffersDiscountsItem {
    private var title: String!
    private var description: String!
    private var actionTitle: String!
    
    init(_ title: String, desc: String, actionTitle: String) {
        self.title = title
        self.description = desc
        self.actionTitle = actionTitle
    }
    
    public func getTtile() -> String {
        return self.title
    }
    
    public func getDescription() -> String {
        return self.description
    }
    
    public func getActionTitle() -> String {
        return self.actionTitle
    }
}
