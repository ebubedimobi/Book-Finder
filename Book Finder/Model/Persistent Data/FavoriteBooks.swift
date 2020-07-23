//
//  FavoriteBooks.swift
//  Book Finder
//
//  Created by Ebubechukwu Dimobi on 23.07.2020.
//  Copyright © 2020 Ebubechukwu Dimobi. All rights reserved.
//

import Foundation
import RealmSwift


class FavoriteBooks : Object{
    
     @objc dynamic var bookName: String = ""
     @objc dynamic var author: String = ""
     @objc dynamic var publisher: String = ""
     @objc dynamic var publishedDate: String = ""
     @objc dynamic var numPages: Int = 0
     @objc dynamic var averageRating: Double = 0
     @objc dynamic var link: String = ""
     @objc dynamic var imageURL: String = ""
    
 
    
}
