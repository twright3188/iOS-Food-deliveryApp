//
//  MenuItem.swift
//  DeliveryApp
//
//  Created by kh on 8/13/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import Foundation

class MenuItem {
    private var icon: String?
    private var title: String?
    private var vcIdentifier: String?
    private var id: String?
    private var cellIdentifier: String?
    
    init(_ title: String, icon: String, vcIdentifier: String, id: String, cellIdentifier: String) {
        self.title = title
        self.icon = icon
        self.vcIdentifier = vcIdentifier
        self.id = id
        self.cellIdentifier = cellIdentifier
    }
    
    public func getCellIdentifier() -> String {
        return self.cellIdentifier ?? ""
    }
    
    public func getTitle() -> String {
        return self.title ?? ""
    }
    
    public func getIcon() -> String {
        return self.icon ?? ""
    }
    
    public func getVCIdentifier() -> String {
        return self.vcIdentifier ?? ""
    }
    
    public func getId() -> String {
        return self.id ?? ""
    }
}
