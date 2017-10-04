//
//  IndustryIdentifiers.swift
//  BookApp
//
//  Created by Jayaprakash Manchu on 29/09/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import Foundation

struct IndustryIdentifiers {
    
    //MARK: - Properties
    var type : String?
    var identifier : String?
    
    //MARK: - Methods
    init(json: [String: Any]) {
        if let value = json["type"] as? String {
            type = value
        }
        
        if let value = json["identifier"] as? String {
            identifier = value
        }
    }

}
