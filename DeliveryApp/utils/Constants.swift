//
//  Constants.swift
//  DeliveryApp
//
//  Created by kh on 8/13/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import Foundation

let KEY_MENU_ADDRESS = "key_menu_address"
let KEY_MENU_EXPLORE_MENU = "key_menu_explore_menu"
let KEY_MENU_OFFERSDISCOUNTS = "key_menu_offers_discounts"
let KEY_MENU_VC_IDENTIFIER = "eky_menu_vc_identifier"
let KEY_MENU_MYORDERS = "key_menu_my_orders"
let KEY_MENU_MYPROFILE = "key_menu_my_profile"
let KEY_MENU_CONTACT_US = "key_menu_contact_us"
let KEY_MENU_LOG_OUT = "key_menu_log_out"

let KEY_CELLID_MENUCELL0 = "menuTableCell0"
let KEY_CELLID_MENUCELL1 = "menuTableCell1"
let KEY_CELLID_MENUCELL = "menuTableCell"

let SAVED_CARTS = "saved_cart_items"



struct AppConstants {
    static func getCartItems() -> [ProductItem] {
        var items = [ProductItem]()
        if let json = LocalStorage[SAVED_CARTS].object as? [[String: Any]] {
            for child in json {
                items.append(ProductItem(child))
            }
        }
        return items
    }
    
    static var addressList: [AddressItem] = []
    static var orderedProductList: [OrderedProductItem] = []
}




var MenuSelIndex = 0

var MenuListData : [MenuItem] = [MenuItem("132 Cherry Street, NN3, 2HF", icon: "restaurant1", vcIdentifier: "contactVC", id: KEY_MENU_ADDRESS, cellIdentifier: KEY_CELLID_MENUCELL),
                                 MenuItem("0208 123 4567", icon: "icon_contact", vcIdentifier: "", id: "", cellIdentifier: KEY_CELLID_MENUCELL0),
                                 MenuItem("Mon-Fri 10:00 12:00", icon: "ic_clock", vcIdentifier: "", id: "", cellIdentifier: KEY_CELLID_MENUCELL),
                                 MenuItem("Sat-Sun 10:00-13:00", icon: "ic_clock", vcIdentifier: "", id: "", cellIdentifier: KEY_CELLID_MENUCELL),
                                 MenuItem("", icon: "icon_bicycle", vcIdentifier: "", id: "", cellIdentifier: KEY_CELLID_MENUCELL1),
                                 MenuItem("Explore Menu", icon: "restaurant1", vcIdentifier: "foodListVC", id: KEY_MENU_EXPLORE_MENU, cellIdentifier: KEY_CELLID_MENUCELL),
                                 MenuItem("Offers & Discounts", icon: "icon_offersdiscounts", vcIdentifier: "offersDiscountsVC", id: KEY_MENU_OFFERSDISCOUNTS, cellIdentifier: KEY_CELLID_MENUCELL),
                                 MenuItem("My Orders", icon: "icon_list", vcIdentifier: "myOrdersVC", id: KEY_MENU_MYORDERS, cellIdentifier: KEY_CELLID_MENUCELL),
                                 MenuItem("My Profile", icon: "icon_profile", vcIdentifier: "profileVC", id: KEY_MENU_MYPROFILE, cellIdentifier: KEY_CELLID_MENUCELL),
                                 MenuItem("Contact us", icon: "icon_contact", vcIdentifier: "contactVC", id: KEY_MENU_CONTACT_US, cellIdentifier: KEY_CELLID_MENUCELL),
                                 MenuItem("Log Out", icon: "ic_restaurant", vcIdentifier: "loginVC", id: KEY_MENU_LOG_OUT, cellIdentifier: KEY_CELLID_MENUCELL)]

