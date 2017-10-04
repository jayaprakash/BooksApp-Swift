//
//  Offers.swift
//  BookApp
//
//  Created by Jayaprakash Manchu on 29/09/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import Foundation

struct Offers {
    var finskyOfferType : Int?
    var listPrice : Price?
    var retailPrice : Price?
    
    init(json: [String: Any]) {
        if let value = json["finskyOfferType"] as? Int {
            finskyOfferType = value
        }
        
        if let value = json["amountInMicros"] as? [String: Any] {
            listPrice = Price(json: value)
        }
        
        if let value = json["currencyCode"] as? [String: Any] {
            retailPrice = Price(json: value)
        }
    }

}
