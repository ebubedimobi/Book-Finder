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
    @IBOutlet weak var readBookLabel: UIButton!
    
    @IBOutlet weak var infoHolderView: UIView!
    
    var viewController = ViewController()
    
    var bookInfo: BookModel?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoHolderView.layer.cornerRadius = infoHolderView.frame.size.height / 12
        readBookLabel.layer.cornerRadius = readBookLabel.frame.size.height / 3.5
        
        if bookInfo != nil {
            
            
            
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
            
            
            
            if bookInfo?.link != nil{
                readBookLabel.isHidden = false
            }else {
                
                readBookLabel.isHidden = true
            }
        }
        
        
    }
    
    
    
    @IBAction func returnButtonPressed(_ sender: UIButton) {
        
        //automatically goes to link view
        
    }
    
    //we send link
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToWebView"{
            
            let WebViewController = segue.destination as! WebViewViewController
            if let url = self.bookInfo?.link{
                
                // add an s to make it https
                
                var newURL = url
                newURL.insert("s", at: newURL.index(newURL.startIndex, offsetBy: 4))
                
                WebViewController.urlstring = newURL
                
                
            }
            
        }
    }
    
    
}





