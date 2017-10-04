//
//  SearchInfo.swift
//  BookApp
//
//  Created by Jayaprakash Manchu on 29/09/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import Foundation

struct SearchInfo {

    //MARK: - Properties
    var textSnippet : String?
    
    //MARK: - Methods
    init(json: [String: Any]) {
        if let value = json["textSnippet"] as? String {
            textSnippet = value
        }        
    }

}

