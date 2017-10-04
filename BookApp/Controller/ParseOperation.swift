//
//  ParseOperation.swift
//  BookApp
//
//  Created by Jayaprakash Manchu on 30/09/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import Foundation

class ParseOperation : Operation {
    
    // BooksModel containing instances for each Book parsed
    // from the input data.
    // Only meaningful after the operation has completed.

    var booksModel : BooksModel?
    var errorHandler : ((_ error: Error) -> ())?
    
    private var dataToParse : Data?
    
    convenience init(data: Data) {
        self.init()
        dataToParse = data
    }
    
    override func main() {

        do {
            let jsonObject = try JSONSerialization.jsonObject(with: dataToParse!, options: .allowFragments)
            booksModel = BooksModel(json: jsonObject as! [String: Any])
            
        } catch let error {
            //print("Error in parsing JSON : \(error)")
            errorHandler?(error)
        }
        
    }
}
