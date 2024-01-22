//
//  MenuTableCell0.swift
//  DeliveryApp
//
//  Created by kh on 8/13/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit

class MenuTableCell0: UITableViewCell {

    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    public func setData(data: MenuItem) {
        imgIcon.image = UIImage(named: data.getIcon()) ?? UIImage()
        lblTitle.text = data.getTitle()
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
