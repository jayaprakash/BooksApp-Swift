//
//  VolumeInfo.swift
//  BookApp
//
//  Created by Jayaprakash Manchu on 29/09/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import Foundation

struct VolumeInfo {
    //MARK: - Properties
    var title : String?
    var subTitle : String?
    var authors  : [String]?
    var publishedDate : String?
    var industryIdentifiers : [IndustryIdentifiers]?
    var readingModes : ReadingModes?
    var pageCount : Int?
    var printType : String?
    var categories : [String]?
    var averageRating : Double?
    var ratingsCount : Int?
    var maturityRating : String?
    var allowAnonLogging : Bool?
    var contentVersion : String?
    var imageLinks : ImageLinks?
    var language : String?
    var previewLink : String?
    var infoLink : String?
    var canonicalVolumeLink : String?
    var descriptionVal : String?

    //MARK: - Methods
    init(json: [String: Any]) {
        if let value = json["title"] as? String {
            title = value
        }
        
        if let value = json["subtitle"] as? String {
            subTitle = value
        }
        
        if let value = json["authors"] as? [String] {
            authors = value
        }
        
        if let value = json["publishedDate"] as? String {
            publishedDate = value
        }
        
        if let value = json["industryIdentifiers"] as? [[String: Any]] {
            var items = [IndustryIdentifiers]()
            for item in value {
                let industryId = IndustryIdentifiers(json: item)
                items.append(industryId)
            }
            industryIdentifiers = items
        }
        
        if let value = json["readingModes"] as? [String: Any] {
            readingModes = ReadingModes(json: value)
        }
        
        if let value = json["pageCount"] as? Int {
            pageCount = value
        }
        
        if let value = json["printType"] as? String {
            printType = value
        }

        if let value = json["categories"] as? [String] {
            categories = value
        }

        if let value = json["averageRating"] as? Double {
            averageRating = value
        }

        if let value = json["ratingsCount"] as? Int {
            ratingsCount = value
        }

        if let value = json["maturityRating"] as? String {
            maturityRating = value
        }

        if let value = json["allowAnonLogging"] as? Bool {
            allowAnonLogging = value
        }

        if let value = json["contentVersion"] as? String {
            contentVersion = value
        }

        if let value = json["imageLinks"] as? [String: Any] {
            imageLinks = ImageLinks(json: value)
        }

        if let value = json["previewLink"] as? String {
            previewLink = value
        }
        
        if let value = json["language"] as? String {
            language = value
        }

        if let value = json["infoLink"] as? String {
            infoLink = value
        }

        if let value = json["canonicalVolumeLink"] as? String {
            canonicalVolumeLink = value
        }

        if let value = json["description"] as? String {
            descriptionVal = value
        }

    }

}
