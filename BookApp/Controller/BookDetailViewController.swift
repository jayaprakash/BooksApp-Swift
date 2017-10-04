//
//  BookDetailViewController.swift
//  BookApp
//
//  Created by Jayaprakash Manchu on 29/09/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    //MARK: - Property
    var selectedItem : Item?

    //MARK: - Outlet Properties
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var snippetTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
//        self.title = [[_selectedItem volumeInfo] title];
//        // Do any additional setup after loading the view.
        
        title = selectedItem?.volumeInfo?.title
        if let icon = selectedItem?.volumeInfo?.imageLinks?.smallThumbnailIcon {
            imageView.image = icon
        } else {
            imageView.image = UIImage(named: "Placeholder.png")
        }
       
        titleLabel.text = selectedItem?.volumeInfo?.title
        authorsLabel.text = selectedItem?.volumeInfo?.authors?[0]
        subTitleLabel.text = selectedItem?.volumeInfo?.subTitle
        descriptionTextView.text = selectedItem?.volumeInfo?.descriptionVal
        if let rating = selectedItem?.volumeInfo?.averageRating {
            ratingLabel.text = "Average Rating: \(rating)"
        } else {
            ratingLabel.text = "Average Rating: 0.0"
        }
        snippetTextView.text = selectedItem?.searchInfo?.textSnippet
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

    

}
