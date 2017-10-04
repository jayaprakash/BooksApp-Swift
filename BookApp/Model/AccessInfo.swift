//
//  AccessInfo.swift
//  BookApp
//
//  Created by Jayaprakash Manchu on 29/09/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import Foundation

struct AccessInfo {
    
    //MARK: - Properties
    var country : String?
    var viewability : String?
    var embeddable : Bool?
    var publicDomain : Bool?
    var textToSpeechPermission : String?
    var epub : ePub?
    var pdf : ePub?
    var webReaderLink : String?
    var accessViewStatus : String?
    var quoteSharingAllowed : Bool?
    
    //MARK: - Methods
    init(json: [String: Any]) {
        if let value = json["country"] as? String {
            country = value
        }
        
        if let value = json["viewability"] as? String {
            viewability = value
        }

        if let value = json["embeddable"] as? Bool {
            embeddable = value
        }

        if let value = json["publicDomain"] as? Bool {
            publicDomain = value
        }

        if let value = json["textToSpeechPermission"] as? String {
            textToSpeechPermission = value
        }

        if let value = json["epub"] as? [String: Any] {
            epub = ePub(json: value)
        }

        if let value = json["pdf"] as? [String: Any] {
            pdf = ePub(json: value)
        }

        if let value = json["webReaderLink"] as? String {
            webReaderLink = value
        }

        if let value = json["accessViewStatus"] as? String {
            accessViewStatus = value
        }

        if let value = json["quoteSharingAllowed"] as? Bool {
            quoteSharingAllowed = value
        }
    }

    
}
