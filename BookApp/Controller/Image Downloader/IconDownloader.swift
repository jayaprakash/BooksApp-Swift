//
//  IconDownloader.swift
//  BookApp
//
//  Created by Jayaprakash Manchu on 01/10/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import Foundation

class IconDownloader {
    private var itemvalue : Item?
    private let kAppIconWidth : CGFloat = 128.0
    private let kAppIconHeight : CGFloat = 215.0
    private var sessionTask : URLSessionTask?
    
    convenience init(item: Item) {
        self.init()
        itemvalue = item
    }
    
    func startDownload(completionHandler: () -> () ) {
        guard let urlString = itemvalue?.volumeInfo?.imageLinks?.smallThumbnail, let url = URL(string: urlString) else {
            return
        }
        
        let request = URLRequest(url: url)
        sessionTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            if let error = error, (error as NSError).code == NSURLErrorAppTransportSecurityRequiresSecureConnection {
                // if you get error NSURLErrorAppTransportSecurityRequiresSecureConnection (-1022),
                // then your Info.plist has not been properly configured to match the target server.
                //
                abort()
            } else {
                OperationQueue.main.addOperation({ [weak self] in
                    if let data = data {
                        if let image = UIImage(data: data), (image.size.width != self?.kAppIconWidth || image.size.height != self?.kAppIconHeight) {
                            let itemSize = CGSize(width: (self?.kAppIconWidth)!, height: (self?.kAppIconHeight)!)
                            UIGraphicsBeginImageContextWithOptions(itemSize, false, 0.0)
                            let imageRect = CGRect(x: 0, y: 0, width: itemSize.width, height: itemSize.height)
                            image.draw(in: imageRect)
                            self?.itemvalue?.volumeInfo?.imageLinks?.smallThumbnailIcon = UIGraphicsGetImageFromCurrentImageContext()
                            
                            UIGraphicsEndImageContext();
                            
                            //Save Image to Disk
                            if let imageData = UIImagePNGRepresentation((self?.itemvalue?.volumeInfo?.imageLinks?.smallThumbnailIcon)!), let basePath = self?.getBasePath() {
                                let imageNSData = imageData as NSData
                                let filePath = basePath + "/" + (self?.itemvalue?.idValue)!
                                imageNSData.write(toFile: filePath, atomically: true)
                            }

                        }
                        
                    }
                    
                })
            }
            
        })
        sessionTask?.resume()
    }
    
    func cancelDownload() {
        sessionTask?.cancel()
        sessionTask = nil
    }
    
    func getBasePath() -> String?{
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true);
        if let basePath = paths.first {
            return basePath
        }
        return nil;

    }
    
}
