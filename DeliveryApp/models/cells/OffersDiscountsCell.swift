//
//  OffersDiscountsCell.swift
//  DeliveryApp
//
//  Created by jonh on 8/12/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit

class OffersDiscountsCell: UITableViewCell {
    
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtDescription: UILabel!
    @IBOutlet weak var btnCode: UIButton!
    
    @IBOutlet weak var cellView: UIButton!
    @IBOutlet weak var btnAction: UIButton!
    
    public func setData(_ itemData: OffersDiscountsItem) {
        self.txtTitle.text = itemData.getTtile()
        self.txtDescription.text = itemData.getDescription()
        btnAction.setTitle(itemData.getActionTitle(), for: UIControl.State.normal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        btnAction.addDashedBorder()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func onClicked(_ sender: Any) {
        
    }
    
}
