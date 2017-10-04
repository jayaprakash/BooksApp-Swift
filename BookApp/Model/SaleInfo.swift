//
//  SaleInfo.swift
//  BookApp
//
//  Created by Jayaprakash Manchu on 29/09/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import Foundation

struct SaleInfo {
    
    //MARK: - Properties
    var country : String?
    var saleability : String?
    var buyLink : String?
    var listPrice : Price?
    var retailPrice : Price?
    var isEbook : Bool?
    var offers : [String]?
    
    //MARK: - Methods
    init(json: [String: Any]) {
        if let value = json["country"] as? String {
            country = value
        }

        if let value = json["saleability"] as? String {
            saleability = value
        }

        if let value = json["buyLink"] as? String {
            buyLink = value
        }

        if let value = json["listPrice"] as? [String : Any] {
            listPrice = Price(json: value)
        }

        if let value = json["retailPrice"] as? [String: Any] {
            retailPrice = Price(json: value)
        }

        if let value = json["isEbook"] as? Bool {
            isEbook = value
        }

        if let value = json["offers"] as? [String] {
            offers = value
        }
    }
}
