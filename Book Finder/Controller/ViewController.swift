//
//  ViewController.swift
//  Book Finder
//
//  Created by Ebubechukwu Dimobi on 11.07.2020.
//  Copyright © 2020 Ebubechukwu Dimobi. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var searchBookNameLabel: UITextField!
    
    @IBOutlet weak var searchISBNLabel: UITextField!
    
    @IBOutlet weak var searchingInfoLabel: UILabel!
    @IBOutlet weak var moreInfoLabel: UITextView!
    
    var bookmanager = BookManager()
    
    var bookInfo: [BookModel]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookmanager.delegate = self
        searchBookNameLabel.delegate = self
        searchISBNLabel.delegate = self
        updateTextLinkToLink()
        
    }
    
    func updateTextLinkToLink(){
        
        let font = moreInfoLabel.font
        let color = moreInfoLabel.textColor
        let alignment = moreInfoLabel.textAlignment
        
        let path =  "https://www.isbn-international.org/content/what-isbn"
        let text = moreInfoLabel.text ?? ""
        let attributedString = NSAttributedString.makeHyperlink(for: path, in: text, as: "here")
        moreInfoLabel.attributedText = attributedString
        
        moreInfoLabel.font = font
        moreInfoLabel.textColor = color
        moreInfoLabel.textAlignment = alignment
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
  
            
        if segue.identifier == "goToSearchResults"{
            let searchResultViewController = segue.destination as! SearchResultViewController
            
            if let book = self.bookInfo{
                
                searchResultViewController.bookInfo = book
            }
            
        }
        
        
    }
}


//MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        
        switch sender.tag {
        case 1:
            if searchBookNameLabel.text != "" {
                searchBookNameLabel.endEditing(true)
                searchingInfoLabel.isHidden = false
                textFieldShouldEndEdintingforName(textField: searchBookNameLabel)
                
                           
                           
                           
                       
                
            }else {
                searchBookNameLabel.placeholder = "Type Something"
            }
            
        case 2:
            if searchISBNLabel.text != "" {
                searchISBNLabel.endEditing(true)
                searchingInfoLabel.isHidden = false
                textFieldShouldEndEdintingforISBN(textField: searchISBNLabel)
                
            }else {
                searchISBNLabel.placeholder = "Type Something"
            }
        default:
            print("Error")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.text != "" {
            
            textField.endEditing(true)
            searchingInfoLabel.isHidden = false
            
            textFieldShouldEndEdintingforName(textField: textField)
            return true
        }else {
            textField.placeholder = "Type Something"
            return false
        }
    }
    
    private func textFieldShouldEndEdintingforName(textField: UITextField){
        
        if let name = textField.text{
            
            textField.endEditing(true)
            searchingInfoLabel.isHidden = false
            bookmanager.fetchBookWithName(with: name)
            
        }
        
        
    }
    
    private func textFieldShouldEndEdintingforISBN(textField: UITextField){
        
        if let ISBN = textField.text{
            textField.endEditing(true)
            searchingInfoLabel.isHidden = false
            bookmanager.fetchBookWithISBN(with: ISBN)
        }
        
    }
    
}

//MARK: - BookManagerDelegate

extension ViewController: BookManagerDelegate{
    
    func didFailWithError(send errorMessage: String) {
        
        DispatchQueue.main.async{
            
            self.searchingInfoLabel.isHidden = true
            
            //self.bookInfo = BookModel(bookName: nil, author: nil, publisher: nil, publishedDate: nil, numPages: nil, averageRating: nil, numBooksFound: nil, link: nil)
            
            self.bookInfo = nil
            
            self.performSegue(withIdentifier: "goToSearchResults", sender: self)
            
        }
        
        
        
    }
    
    
    func didUpdateBooks(_ bookManager: BookManager, bookModel: [BookModel]) {
        
        DispatchQueue.main.async {
            
            self.bookInfo = bookModel
            self.searchingInfoLabel.isHidden = true
            
            self.performSegue(withIdentifier: "goToSearchResults", sender: self)
            
        }
        
        
        
    }
    
}



