//
//  DataParser.swift
//  testWeD
//
//  Created by Maxence de Cussac on 07/07/2017.
//  Copyright © 2017 Maxence de Cussac. All rights reserved.
//

import Foundation

class DataParser {
    class func parse(hotelData data: Data) -> [WDHotel] {
        do {
            let jsonReceived = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! GenericJson
            
            if let hotels = jsonReceived["exactMatch"] as? [GenericJson] {
                var hotelsParsed = [WDHotel]()
                for hotel in hotels {
                    hotelsParsed.append(WDHotel(withDictionary: hotel))
                }
                hotelsParsed.sort { $0.label < $1.label }
                return hotelsParsed
            } else {
                return [WDHotel]()
            }
        } catch {
            print("\terror parsing \(error)")
        }
        return [WDHotel]()
    }
}
