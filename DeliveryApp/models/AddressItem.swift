//
//  AddressItem.swift
//  DeliveryApp
//
//  Created by Star on 10/13/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import Foundation

class AddressItem {
   
    private var addressType: String!
    private var address: String!
        
    init(type: String, address: String) {
        self.addressType = type
        self.address = address
    }
    
    public func getType() -> String {
        return self.addressType
    }
    
    public func getAddress() -> String {
        return self.address
    }

}
