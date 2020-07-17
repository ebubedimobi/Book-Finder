//
//  BookData.swift
//  Book Finder
//
//  Created by Ebubechukwu Dimobi on 12.07.2020.
//  Copyright © 2020 Ebubechukwu Dimobi. All rights reserved.
//

import Foundation

struct BookData : Codable {
 
    let items: [Items]
    
}

struct Items: Codable {
    let volumeInfo: VolumeInfo
}

struct VolumeInfo: Codable {
    let title: String?
    let authors: [String]?
    let publisher: String?
    let publishedDate: String?
    let pageCount: Int?
    let infoLink: String?
    let averageRating: Double?
    
}
