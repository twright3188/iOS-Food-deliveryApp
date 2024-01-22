//
//  MenuVC.swift
//  DeliveryApp
//
//  Created by kh on 8/13/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit
import SideMenu

class MenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var menuViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var navMenuView: UIView!
    @IBOutlet weak var maskView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var childVC: UIViewController?
    
    var gestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(onMaskViewTap))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        maskView.addGestureRecognizer(gestureRecognizer)
        maskView.isUserInteractionEnabled = true
        setContainer(identifier: "foodListVC")
        lblTitle.text = "Explore Menu"
        
        if MenuSelIndex == 7 {
            setContainer(identifier: "myOrdersVC")
            lblTitle.text = "My Orders"
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(selectedMenuItem(notification:)), name: Notification.Name("selected_menu"), object: nil)

        SideMenuManager.default.leftMenuNavigationController = storyboard?.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController

        SideMenuManager.default.addPanGestureToPresent(toView: navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view)
    }
    
    @objc func selectedMenuItem(notification: NSNotification) {
        let data = MenuListData[MenuSelIndex]
        let identifier = data.getVCIdentifier()
        if(identifier == "") {
            return
        }
        setContainer(identifier: identifier)
        lblTitle.text = data.getTitle()
    }
    
    func setContainer(identifier: String) {
        
        self.childVC?.view.removeFromSuperview()
        self.childVC?.removeFromParent()
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: identifier)
        childVC = vc!
        self.childVC!.view.frame = CGRect(x: 0, y: 0, width: mainView.frame.width, height: mainView.frame.height)
        addChild(childVC!)
        self.mainView.addSubview(childVC!.view)
        
        hideMenu()
    }
    
    func showMenu() {
        UIView.animate(withDuration: 0.5, animations: {
            self.maskView.isHidden = false
            self.menuViewLeadingConstraint.constant = 0
        }, completion: { (_) in
            
        })
    }
    
    func hideMenu() {
        UIView.animate(withDuration: 1, animations: {
            self.menuViewLeadingConstraint.constant = -270
        }, completion: { (_) in
            self.maskView.isHidden = true
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = MenuListData[indexPath.row]
        
        switch data.getCellIdentifier() {
        case KEY_CELLID_MENUCELL1:
            let cell = tableView.dequeueReusableCell(withIdentifier: data.getCellIdentifier(), for: indexPath) as! MenuTableCell1
            return cell
            
        case KEY_CELLID_MENUCELL0:
            let cell = tableView.dequeueReusableCell(withIdentifier: data.getCellIdentifier(), for: indexPath) as! MenuTableCell0
            cell.setData(data: data)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: data.getCellIdentifier(), for: indexPath) as! MenuTableCell
            cell.setData(data: data)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = MenuListData[indexPath.row]
        switch data.getCellIdentifier() {
        
        case KEY_CELLID_MENUCELL0:
            return 30
        case KEY_CELLID_MENUCELL1:
            return 120
        default:
            return 48
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = MenuListData[indexPath.row]
        switch data.getCellIdentifier() {
        case KEY_CELLID_MENUCELL:
            let identifier = data.getVCIdentifier()
            if(identifier == "") {
                break
            }
            setContainer(identifier: identifier)
            lblTitle.text = data.getTitle()
            break
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func onMenuBtnPressed(_ sender: Any) {
//        showMenu()
    }
    
    @objc func onMaskViewTap() {
        
    }
}
