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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bookViewHolder.layer.cornerRadius = bookViewHolder.frame.size.height / 6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
