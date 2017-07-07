//
//  WDHotel.swift
//  testWeD
//
//  Created by Maxence de Cussac on 07/07/2017.
//  Copyright © 2017 Maxence de Cussac. All rights reserved.
//

import UIKit

typealias Position = (lat:Double, lng:Double, address: String)

class WDHotel: NSObject {
    
    // Attributs
    var label: String = ""
    var position = (lat: 0.0, lng: 0.0, address: "")
    var reviewMoyenne = 0.0
    
    var weekends = [WDWeekend]()
    
    init(withDictionary dict:GenericJson) {
        super.init()

        if let labelFromDict = dict["label"] as? String {
            label = labelFromDict
        } else {
            print("erreur sur la récupération du label")
        }
        
        if let locationDict = dict["location"] as? NSDictionary {
            if let lat = locationDict["lat"] as? Double, let lng = locationDict["lng"] as? Double, let address = locationDict["address"] as? String {
                position = Position(lat, lng, address)
            } else {
                print("erreur sur la récupération des informations liées à la location")
            }
        } else {
            print("erreur sur la récupération de la location")

        }
        
        if let review = dict["review"] as? NSDictionary, let average = review["average"] as? Double {
            reviewMoyenne = average
        } else {
            print("erreur sur la récupération des informations liées à la location")
        }
        
        if let currentWeekends = dict["weekend"] as? [GenericJson] {
            for weekend in currentWeekends {
                weekends.append(WDWeekend(withDictionary: weekend as NSDictionary))
            }
        } else {
            print("erreur sur la récupération des weekends")
        }
    }
    
    override var description: String {
        return "Label : \(label) \nposition: \(position)\nreviewMoyenne : \(reviewMoyenne)\nweekends : \(weekends)"
    }
}
