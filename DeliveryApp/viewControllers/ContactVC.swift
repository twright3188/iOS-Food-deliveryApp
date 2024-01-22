//
//  ContactVC.swift
//  DeliveryApp
//
//  Created by kh on 8/13/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit
import MessageUI
import MapKit

class ContactVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var hoursTableView: UITableView!
    
    var weekDays: [String] = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let appleHQ = CLLocation(latitude: 53.478162, longitude: -2.244666)
        let regionRadius : CLLocationDistance = 300.0
        let region = MKCoordinateRegion(center: appleHQ.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        let placeMark = MKPointAnnotation()
        placeMark.title = "Our Office"
        placeMark.coordinate = appleHQ.coordinate
        mapView.addAnnotation(placeMark)
                
        mapView.setRegion(region, animated: true)
        let logo = UIImage(named: "ic_logo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.isHidden = false
        
    }

    @IBAction func onBackPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onReachPressed(_ sender: Any) {
        
        let appleHQ = CLLocation(latitude: 53.478162, longitude: -2.244666)
        let regionRadius : CLLocationDistance = 300.0
        let region = MKCoordinateRegion(center: appleHQ.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        let placeMark = MKPointAnnotation()
        placeMark.title = "Our Office"
        placeMark.coordinate = appleHQ.coordinate
        mapView.addAnnotation(placeMark)
                
        mapView.setRegion(region, animated: true)
        
    }
    
    @IBAction func onCallPressed(_ sender: Any) {
        
        guard let url = URL(string: "tel://" + "02081234567"), UIApplication.shared.canOpenURL(url as URL) else {
            return
        }
        UIApplication.shared.open(url as URL)
    }
    
    @IBAction func onEmailPressed(_ sender: Any) {
        
        guard MFMailComposeViewController.canSendMail() else {
            return
        }
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        mail.setToRecipients(["help@pizzamenia.com"])
        mail.setSubject("HELP!")
        mail.setMessageBody("<p>I love Orderity app, but need help!</p>", isHTML: true)

        present(mail, animated: true)
    }
    
}

extension ContactVC: MFMailComposeViewControllerDelegate, MKMapViewDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error {
            controller.dismiss(animated: true)
        }
        
        switch result {
        case .cancelled:
            print("Cancelled")
        case .failed:
            print("Failed to send")
        case .saved:
            print("Saved")
        case .sent:
            print("Email Sent")
        }
        
        controller.dismiss(animated: true)
    }
}

extension ContactVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekDays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HoursTableViewCell", for: indexPath) as! HoursTableViewCell
        cell.labelWeekday.text = weekDays[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 28
    }
    
    
    
}
