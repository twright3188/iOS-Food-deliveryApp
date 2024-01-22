//
//  OrderProductListCell.swift
//  DeliveryApp
//
//  Created by Star on 10/13/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit

protocol MyCellDelegate: AnyObject {
    func btnCloseTapped(cell: UIView)
}

class OrderProductListCell: UITableViewCell {

    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtFeature: UILabel!
    @IBOutlet weak var txtDescription: UILabel!
    @IBOutlet weak var txtPrice: UILabel!
    @IBOutlet weak var txtCount: UILabel!
    @IBOutlet weak var btnIncrease: UIButton!
    @IBOutlet weak var btnDecrease: UIButton!
    
    var selectCrust = ["Cheesy", "Normal", "Saussage","Italian"]
    var selectTopics = ["Tomato", "Corn", "Jalapenos", "Pineapple", "Pepperoni"]
    
    public func setOrderProductData(data: OrderedProductItem) {
        
        var featureString = "Size: "
        
        switch data.size {
        case 0:
            featureString = featureString + "Small".uppercased()
            break
        case 1:
            featureString = featureString + "Medium".uppercased()
            break
        case 2:
            featureString = featureString + "Large".uppercased()
            break
        default:
            break
        }
        
        var topic = ""
        for i in 0..<data.topic.count {
            if data.topic[i] != 0 {
                if topic == "" {
                    topic = topic + selectTopics[i].uppercased() + "(X\(data.topic[i]))"
                } else {
                    topic = topic + ", " + selectTopics[i].uppercased() + "(X\(data.topic[i]))"
                }
            }
        }
        
        featureString = featureString + " | Crust: " + selectCrust[data.crust].uppercased() + " | Topic: " + topic
        
        txtTitle.text = data.getTitle()
        txtFeature.text = featureString
        txtDescription.text = data.getDescription()
        txtCount.text = "\(data.getCount())"
        txtPrice.text = "$" + String(format: "%.2f", data.getPrice()*Float(data.getCount()))
    }
    weak var delegate: MyCellDelegate?
    var indexPath = 0

    //3. assign this action to close button
    @IBAction func btnCloseTapped(sender: AnyObject) {
        //4. call delegate method
        //check delegate is not nil with `?`
        delegate?.btnCloseTapped(cell: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
