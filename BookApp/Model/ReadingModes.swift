//
//  ReadingModes.swift
//  BookApp
//
//  Created by Jayaprakash Manchu on 29/09/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import Foundation

struct ReadingModes {
    
    //MARK: - Properties
    var text : String?
    var image : String?
    
    //MARK: - Methods
    init(json: [String: Any]) {
        if let value = json["text"] as? String {
            text = value
        }
        
        if let value = json["image"] as? String {
            image = value
        }        
    }
}
