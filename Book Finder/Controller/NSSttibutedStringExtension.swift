//
//  NSSttibutedStringExtension.swift
//  Book Finder
//
//  Created by Ebubechukwu Dimobi on 12.07.2020.
//  Copyright © 2020 Ebubechukwu Dimobi. All rights reserved.
//

import Foundation

// turns text view to link

extension NSAttributedString {
    
    static func makeHyperlink( for path: String, in String: String, as substring: String) -> NSAttributedString{
        
        let nsString = NSString(string: String)
        let subStringRange =  nsString.range(of: substring)
        let attributedString = NSMutableAttributedString(string: String)
        attributedString.addAttribute(.link, value: path, range: subStringRange)
        return attributedString
        
    }
}
