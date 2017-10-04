//
//  BookTableViewCell.swift
//  BookApp
//
//  Created by Jayaprakash Manchu on 01/10/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookSubTitleLabel: UILabel!
    @IBOutlet weak var pendingOrReadButton: UIButton!
    
    override func awakeFromNib() {
        bookTitleLabel.numberOfLines = 0
        bookSubTitleLabel.numberOfLines = 0
    }
}
