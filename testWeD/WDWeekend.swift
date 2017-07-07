//
//  WDWeekend.swift
//  testWeD
//
//  Created by Maxence de Cussac on 07/07/2017.
//  Copyright © 2017 Maxence de Cussac. All rights reserved.
//

import UIKit

class WDWeekend: NSObject {
    
    //Attributs
    var label = ""
    var image: UIImage?
    var prixReference = 0.0
    var prixVente = 0.0
    var pourcentageReduction = 0
    
    var callBackImage : ((UIImage) -> Void)?

    var themes = [String]()

    init(withDictionary dict:NSDictionary) {
        super.init()
        
        if let labelFromDict = dict["label"] as? String {
            label = labelFromDict
        } else {
            print("erreur sur la récupération du label")
        }

        if let imageUrlString = dict["imageUrl"] as? String {
            if let imageUrl = URL(string: imageUrlString) {
                
                NetworkManager.retrieveDataFromUrl(fromUrl: imageUrl, callBack: { (currentImage) in
                    self.image = currentImage
                    DispatchQueue.main.async {
                        self.callBackImage?(currentImage)
                    }
                })
            } else {
                print("erreur sur la récupération de l'url de l'image")
            }
        }
        
        if let topTheme = dict["topTheme"] as? [String] {
            themes = topTheme
        } else {
            print("erreur sur la récupération des thèmes")
        }
        
        if let prixDict = dict["price"] as? GenericJson {
            prixReference = prixDict["sellPrice"] as! Double
            prixVente = prixDict["refPrice"] as! Double
            if let reduction = prixDict["promoPercentageRounded"] as? Int {
                pourcentageReduction = reduction
            }
        }
    }
    
    override var description: String {
        return "Label : \(label) \nimage: \(String(describing: image))\nthemes : \(themes)"
    }
}
