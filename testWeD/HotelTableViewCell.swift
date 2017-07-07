//
//  HotelTableViewCell.swift
//  testWeD
//
//  Created by Maxence de Cussac on 07/07/2017.
//  Copyright © 2017 Maxence de Cussac. All rights reserved.
//

import Foundation
import UIKit

class HotelTableViewCell: UITableViewCell {
    
    @IBOutlet weak var hotelLabel: UILabel!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var reviewMoyenne: UILabel!
    
    var currentHotel: WDHotel! {
        didSet {
            self.hotelLabel.text = currentHotel.label
            self.position.text = currentHotel.position.address
            self.reviewMoyenne.text = "\(currentHotel.reviewMoyenne)"
            self.layoutIfNeeded()
        }
    }
    
    init(withHotel hotel: WDHotel) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: hotelCellIdentifier)
        
        currentHotel = hotel
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
