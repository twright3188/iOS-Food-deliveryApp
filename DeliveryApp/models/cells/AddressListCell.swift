//
//  AddressListCell.swift
//  DeliveryApp
//
//  Created by Star on 10/13/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit

class AddressListCell: UITableViewCell {

    @IBOutlet weak var txtType: UILabel!
    @IBOutlet weak var txtAddress: UILabel!
    @IBOutlet weak var btnRemove: UIButton!
    
    public func setAddressData(data: AddressItem) {
        
        txtType.text = data.getType()
        txtAddress.text = data.getAddress()

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
