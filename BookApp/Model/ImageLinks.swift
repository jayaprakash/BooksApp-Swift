//
//  ImageLinks.swift
//  BookApp
//
//  Created by Jayaprakash Manchu on 29/09/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

struct ImageLinks {
    
    //MARK: - Properties
    var smallThumbnail : String?
    var thumbnail : String?
    var smallThumbnailIcon : UIImage?
    var thumbnailIcon : UIImage?
    
    init(json: [String: Any]) {
        if let value = json["smallThumbnail"] as? String {
            smallThumbnail = value
            smallThumbnailIcon = getImageFromFileNamed(url: smallThumbnail!)
        }
        
        if let value = json["thumbnail"] as? String {
            thumbnail = value
            thumbnailIcon = getImageFromFileNamed(url: thumbnail!)
        }
    }
    
    func getImageFromFileNamed (url : String) -> UIImage? {
        var img : UIImage? = nil;
        let urlStr = NSURL(string: url)
        let idVal = urlStr!["id"]
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        if let documentsDirectory = paths.first {
            let filePath = documentsDirectory + "/" + (idVal as! String)
            
            if FileManager.default.fileExists(atPath: filePath) {
                img = UIImage(contentsOfFile: filePath)
            }
        }
        
        return img
    }


}
