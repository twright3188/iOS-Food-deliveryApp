//
//  MenuTableVC.swift
//  DeliveryApp
//
//  Created by macbook on 9/17/19.
//  Copyright © 2019 dbug-temac. All rights reserved.
//

import UIKit

protocol MenuViewControllerDelegate {
    func didSelectMenu(index: Int)
}

class MenuTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var childVC: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
            return 48
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
            } else if data.getVCIdentifier() == "loginVC" {
                let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
                appDelegate?.mainVC()
                break
            }
            MenuSelIndex = indexPath.row
            NotificationCenter.default.post(name: Notification.Name("selected_menu"), object: nil)
            break
        case KEY_CELLID_MENUCELL0:
            if let url = URL(string: "tel://" + "02081234567"), UIApplication.shared.canOpenURL(url as URL) {
                UIApplication.shared.open(url as URL)
            }
            break
        case KEY_CELLID_MENUCELL1:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "OrderProcessVC")as! OrderProcessVC
            self.navigationController?.pushViewController(vc, animated: true)
            break
        default:
            break
        }

        dismiss(animated: true, completion: nil)

        tableView.deselectRow(at: indexPath, animated: true)
    }
}
