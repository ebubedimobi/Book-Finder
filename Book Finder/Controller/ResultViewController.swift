//
//  ResultViewController.swift
//  Book Finder
//
//  Created by Ebubechukwu Dimobi on 11.07.2020.
//  Copyright © 2020 Ebubechukwu Dimobi. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var averageRatingLabel: UILabel!
    @IBOutlet weak var publishDateLabel: UILabel!
    @IBOutlet weak var numOfPagesLabes: UILabel!
    @IBOutlet weak var booksFoundLabel: UILabel!
    @IBOutlet weak var linkLabel: UITextView!
    
    
    var viewController = ViewController()
    
    var bookInfo: BookModel?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        bookNameLabel.text = bookInfo?.bookName ?? "Couldn't find book, try researching or using an ISBN code"
        authorLabel.text = bookInfo?.author ?? "|"
        publisherLabel.text = bookInfo?.publisher ?? "|"
        publishDateLabel.text = bookInfo?.publishedDate ?? "|"
        
        if let rating = bookInfo?.averageRating{
            averageRatingLabel.text = String(rating)
            
        }else {
            averageRatingLabel.text = "|"
        }
        
        
        if let pageNum = bookInfo?.numPages{
            numOfPagesLabes.text = String(pageNum)
        }else{
            numOfPagesLabes.text = "|"
        }
        
        
        if let booksFound = bookInfo?.numBooksFound{
            booksFoundLabel.text = String(booksFound)
            
        }else{
            booksFoundLabel.text = "|"
        }
        
        if bookInfo?.link != nil{
            linkLabel.text = "Read Book here"
            updateTextLink()
            
        }else {
            
            linkLabel.isHidden = true
        }
        
        
    }
    
    func updateTextLink(){
        
        let font = linkLabel.font
        let color = linkLabel.textColor
        
        let path = bookInfo?.link ?? ""
        let text = linkLabel.text ?? ""
        let attributedString = NSAttributedString.makeHyperlink(for: path, in: text, as: "here")
        linkLabel.attributedText = attributedString
        
        linkLabel.font = font
        linkLabel.textColor = color
        
        
    }
    
    @IBAction func returnButtonPressed(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        linkLabel.isHidden = false
        
    }
    
    
}





