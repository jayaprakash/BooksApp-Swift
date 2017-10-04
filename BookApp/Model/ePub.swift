//
//  ePub.swift
//  BookApp
//
//  Created by Jayaprakash Manchu on 29/09/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import Foundation

struct ePub {
    var isAvailable : Bool?
    var downloadLink : String?
    var acsTokenLink : String?

    init(json: [String: Any]) {
        if let value = json["isAvailable"] as? Bool {
            isAvailable = value
        }
        
        if let value = json["downloadLink"] as? String {
            downloadLink = value
        }
        
        if let value = json["acsTokenLink"] as? String {
            acsTokenLink = value
        }
    }
}
