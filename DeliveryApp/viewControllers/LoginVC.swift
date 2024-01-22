//
//  LoginVC.swift
//  DeliveryApp
//
//  Created by Star on 10/11/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var passBorder: UILabel!
    @IBOutlet weak var loginBorder: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.hideKeyBoard()
    }
    @IBAction func btnLoginPressed(_ sender: Any) {
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.menuVC()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        passBorder.backgroundColor = .gray
            loginBorder.backgroundColor = .gray
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            passBorder.backgroundColor = UIColor(red: 0, green: 174, blue: 239)
            
        } else {
            loginBorder.backgroundColor = UIColor(red: 0, green: 174, blue: 239)
        }
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
