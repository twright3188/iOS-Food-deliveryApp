//
//  OrderedProductListCell.swift
//  DeliveryApp
//
//  Created by kh on 8/13/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit

class OrderedProductListCell: UITableViewCell {

    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtFeature: UILabel!
    @IBOutlet weak var txtDescription: UILabel!
    @IBOutlet weak var txtPrice: UILabel!
    
    public func setOrderedProductData(data: OrderedProductItem) {
        imgProduct.image = UIImage(named: data.getImage()) ?? UIImage()
        txtTitle.text = data.getTitle()
        txtFeature.text = data.getFeature()
        txtDescription.text = data.getDescription()
        txtPrice.text = "$\(data.getPrice())"
        
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
