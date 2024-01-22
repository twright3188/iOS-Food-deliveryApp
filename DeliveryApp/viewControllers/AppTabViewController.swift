//
//  AppTabViewController.swift
//  DeliveryApp
//
//  Created by SilverGold on 10/31/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit

class AppTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
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
        // Do any additional setup after loading the view.
    }
   
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        var kBarHeight : CGFloat = tabBar.frame.size.height
        tabBar.frame.size.height = kBarHeight + 10
        tabBar.frame.origin.y = view.frame.height - kBarHeight - 10
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
