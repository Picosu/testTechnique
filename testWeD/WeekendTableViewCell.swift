//
//  WeekendTableViewCell.swift
//  testWeD
//
//  Created by Maxence de Cussac on 07/07/2017.
//  Copyright © 2017 Maxence de Cussac. All rights reserved.
//

import Foundation
import UIKit

class WeekendTableViewCell: UITableViewCell {
    
    @IBOutlet weak var weekendImageView: UIImageView!
    @IBOutlet weak var weekendLabel: UILabel!
    @IBOutlet weak var themesLabel: UILabel!
    @IBOutlet weak var weekendImageActivityIndicator: UIActivityIndicatorView!
    
    var currentWeekend: WDWeekend! {
        didSet {
            currentWeekend.callBackImage = { (imageResult) in
                self.weekendImageActivityIndicator.stopAnimating()
                self.weekendImageView.image = imageResult
            }
            self.weekendImageView.image = currentWeekend.image
            self.weekendLabel.text = currentWeekend.label
            for theme in currentWeekend.themes {
                self.themesLabel.text?.append(theme)
            }
            self.layoutIfNeeded()
        }
    }
    init(withWeekend weekend: WDWeekend) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: weekendCellIdentifier)
        
        self.currentWeekend = weekend
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
