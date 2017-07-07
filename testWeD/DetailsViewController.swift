//
//  DetailsViewController.swift
//  testWeD
//
//  Created by Maxence de Cussac on 07/07/2017.
//  Copyright © 2017 Maxence de Cussac. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    // Outlets
    @IBOutlet weak var weekendImageView: UIImageView!
    @IBOutlet weak var prixReferenceLabel: UILabel!
    @IBOutlet weak var pourcentageReductionLabel: UILabel!
    @IBOutlet weak var prixVenteLabel: UILabel!
    @IBOutlet weak var imageActivityndicator: UIActivityIndicatorView!

    // Attributs
    var currentWeekend: WDWeekend! {
        didSet {
            self.navigationItem.title = currentWeekend.label
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Cas où l'image n'a pas été téléchargée
        if currentWeekend.image == nil {
            currentWeekend.callBackImage = { image in
                self.imageActivityndicator.stopAnimating()
                self.weekendImageView.image = image
            }
        } else {
            weekendImageView.image = currentWeekend.image
        }
        
        // Prix de vente > prix de référence. C'est étrange, mais peut-être un problème d'API.
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: String(currentWeekend.prixReference))
        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: NSMakeRange(0, attributeString.length))
        self.prixReferenceLabel.attributedText = attributeString
        
        self.pourcentageReductionLabel.text = "Réduction de \(currentWeekend.pourcentageReduction) %"
        
        // Prix de vente > prix de référence. C'est étrange, mais peut-être un problème d'API.
        self.prixVenteLabel.text = "Coût total : \(currentWeekend.prixVente) €"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
