//
//  BookModel.swift
//  BookApp
//
//  Created by Jayaprakash Manchu on 29/09/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import Foundation

struct BooksModel {
   
    //MARK: - Properties
    var kind : String?
    var totalItems : String?
    var items : [Item]?
    
    //MARK: - Methods
    
    init(json: [String: Any]) {
        
        if let value = json["kind"] as? String {
            kind = value
        }
        
        if let value = json["totalItems"] as? String {
            totalItems = value
        }
        
        if let value = json["items"] as? [[String:Any]] {
            var items = [Item]()
            for item in value {
                let itemObject = Item(json: item)
                items.append(itemObject)
            }
            self.items = items
        }
    }
    
}

