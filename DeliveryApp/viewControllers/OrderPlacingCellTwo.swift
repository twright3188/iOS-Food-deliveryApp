//
//  OrderPlacingCellTwo.swift
//  DeliveryApp
//
//  Created by Apple Guru on 2/12/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit

class OrderPlacingCellTwo: UICollectionViewCell {
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cellTextLabel: UILabel!
    
    @IBOutlet weak var cellRateLabel: UILabel!
    @IBOutlet weak var cellXLabel: UILabel!
    
    @IBOutlet weak var cellWidthConstraintLayout: NSLayoutConstraint!
    
    func resetCell() {
        cellView.backgroundColor = .white
        cellRateLabel.textColor = UIColor.init(red: 38, green: 181, blue: 15)
        cellTextLabel.textColor = .black
        cellXLabel.isHidden = true
    }

}
