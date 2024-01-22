//
//  ForgotPassVC.swift
//  DeliveryApp
//
//  Created by Star on 10/14/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit

class ForgotPassVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var forgotBorder: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyBoard()
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        forgotBorder.backgroundColor = UIColor(red: 0, green: 174, blue: 239)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        forgotBorder.backgroundColor = .gray
    }

    @IBAction func onLoginPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
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
