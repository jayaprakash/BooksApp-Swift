//
//  Item.swift
//  BookApp
//
//  Created by Jayaprakash Manchu on 29/09/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import Foundation

struct Item {
    
    //MARK: - Properties
    var kind : String?
    var idValue : String?
    var etag : String?
    var selfLink : String?
    var volumeInfo : VolumeInfo?
    var saleInfo : SaleInfo?
    var accessInfo : AccessInfo?
    var searchInfo : SearchInfo?
    
    //MARK: - Methods
    init(json: [String: Any]) {
        if let value = json["kind"] as? String {
            kind = value
        }
        
        if let value = json["id"] as? String {
            idValue = value
        }

        if let value = json["etag"] as? String {
            etag = value
        }

        if let value = json["selfLink"] as? String {
            selfLink = value
        }

        if let value = json["volumeInfo"] as? [String: Any] {
            volumeInfo = VolumeInfo(json: value)
        }

        if let value = json["saleInfo"] as? [String: Any] {
            saleInfo = SaleInfo(json: value)
        }

        if let value = json["title"] as? [String: Any] {
            accessInfo = AccessInfo(json: value)
        }

        if let value = json["searchInfo"] as? [String: Any] {
            searchInfo = SearchInfo(json: value)
        }


    }
}
