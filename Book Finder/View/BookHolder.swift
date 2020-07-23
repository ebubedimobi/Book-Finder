//
//  BookHolder.swift
//  Book Finder
//
//  Created by Ebubechukwu Dimobi on 17.07.2020.
//  Copyright © 2020 Ebubechukwu Dimobi. All rights reserved.
//

import UIKit

class BookHolder: UITableViewCell {
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookViewHolder: UIView!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bookViewHolder.layer.cornerRadius = bookViewHolder.frame.size.height / 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
