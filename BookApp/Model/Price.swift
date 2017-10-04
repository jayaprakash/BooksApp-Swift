//
//  Price.swift
//  BookApp
//
//  Created by Jayaprakash Manchu on 29/09/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import Foundation

struct Price {
    var amount : String?
    var amountInMicros : String?
    var currencyCode : String?
    
    init(json: [String: Any]) {
        if let value = json["amount"] as? String {
            amount = value
        }
        
        if let value = json["amountInMicros"] as? String {
            amountInMicros = value
        }
        
        if let value = json["currencyCode"] as? String {
            currencyCode = value
        }
    }

}
