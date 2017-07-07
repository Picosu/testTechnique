//
//  NetworkManager.swift
//  testWeD
//
//  Created by Maxence de Cussac on 07/07/2017.
//  Copyright © 2017 Maxence de Cussac. All rights reserved.
//

import UIKit

/// Alias pour les Json
typealias GenericJson = [String:AnyObject]

/// URL de l'api
public let apiUrl = "http://api.weekendesk.com/api/weekends.json?orderBy=priceQuality&locale=fr_FR&limit=50&page=0"

class NetworkManager: NSObject {
    
    class func retrieveDataFromUrl(fromUrl url:URL, callBack: @escaping (UIImage) -> ()) {
        
        let req = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            if let data = data {
                // Enregistrement des informations en vue d'un mode offline basique.
                let defaults = UserDefaults.standard
                defaults.set(data, forKey: "jsonData")
                if let image = UIImage(data: data) {
                    callBack(image)
                }
            } else {
                print("problème de récupération des données d'artiste")
            }
        }
        
        task.resume()
    }
    // MARK :- Public methods
    
    class func retrieveDataFromApi(callBack: @escaping ([WDHotel]) -> ()) {
        guard let url = URL(string: apiUrl) else {
            return;
        }
        
        let req = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            if let data = data {
                // Enregistrement des informations en vue d'un mode offline basique.
                let defaults = UserDefaults.standard
                defaults.set(data, forKey: "jsonData")
                
                callBack(DataParser.parse(hotelData: data))
            } else {
                print("problème de récupération des données d'artiste")
            }
        }
        
        task.resume()
    }
}
