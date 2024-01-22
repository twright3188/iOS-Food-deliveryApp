//
//  FavouriteListCell.swift
//  DeliveryApp
//
//  Created by jonh on 8/12/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit

class FavouriteListCell: UITableViewCell {
    
    @IBOutlet weak var txtProductName: UILabel!
    @IBOutlet weak var txtDescription: UILabel!
    @IBOutlet weak var txtPrice: UILabel!
    @IBOutlet weak var btnAddToCart: UIButton!    
    @IBOutlet weak var btnViewCard: UIButton!
    @IBOutlet weak var typeViewHeightConstraint: NSLayoutConstraint!
    
    public func setItemData(data: ProductItem) {
        txtProductName.text = data.getProductName()
        txtDescription.text = data.getDescription()
        txtPrice.text = "$\(data.getPrice())"
        if(data.oneType()) {
            typeViewHeightConstraint.constant = 0
        }
        typeViewHeightConstraint.constant = 0
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
