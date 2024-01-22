
//
//  TableViewCell.swift
//  DeliveryApp
//
//  Created by Apple Guru on 6/12/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var contentView2: UIView!
    @IBOutlet weak var txtType: UILabel!
       @IBOutlet weak var txtAddress: UILabel!
       @IBOutlet weak var btnRemove: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    public func setAddressData(data: AddressItem) {
           
           txtType.text = data.getType()
           txtAddress.text = data.getAddress()

       }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
