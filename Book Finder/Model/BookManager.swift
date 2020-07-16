//
//  BookManager.swift
//  Book Finder
//
//  Created by Ebubechukwu Dimobi on 12.07.2020.
//  Copyright © 2020 Ebubechukwu Dimobi. All rights reserved.
//

import Foundation

protocol BookManagerDelegate {
    func didUpdateBooks(_ bookManager: BookManager, bookModel: BookModel)
    func didFailWithError(send errorMessage:String )
}

struct BookManager {
    let baseBookURL = "https://www.googleapis.com/books/v1/volumes?q="
    let apiKey = "&key=AIzaSyD_U07gUOT90r1nmkZoSKZjRYJgxRxa94g"
    
    var delegate: BookManagerDelegate?
    
    func fetchBookWithName(with name: String){
        
        if name.contains(" "){
            let array = name.components(separatedBy: " ")
            var bookURL = baseBookURL

            for x in 0..<array.count{
                if x != array.count-1{
                   bookURL = "\(bookURL)\(array[x])%20"
                }else {
                    bookURL = "\(bookURL)\(array[x])"
                }
                
            }
            
            bookURL = "\(bookURL)\(apiKey)"
            performRequest(with: bookURL)
            
        }else {
            let bookURL = "\(baseBookURL)\(name)\(apiKey)"
            performRequest(with : bookURL )

        }

        
    }
    
    func fetchBookWithISBN(with ISBN: String){
        
       let bookURL = "\(baseBookURL)isbn:\(ISBN)\(apiKey)"
        performRequest(with : bookURL )
        
    }
    
    func performRequest(with bookURL: String){
        
        if let url = URL(string: bookURL){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil{
                    let errorMessage = "Network Problem, please Try again"
                    self.delegate?.didFailWithError(send: errorMessage)
                    return
                }
                
                if let safeData = data{
                    
                    if let bookModel = self.parseJSON(with: safeData){
                        
                        
                        
                        self.delegate?.didUpdateBooks(self, bookModel: bookModel)
                    }
                }
            }
            task.resume()
        }
    }
    
    
    func parseJSON(with bookData: Data) -> BookModel?{
        
        let decoder = JSONDecoder()
        
        do{
            let decodedData = try decoder.decode(BookData.self, from: bookData)
            
            
            
            let bookName = decodedData.items[0].volumeInfo.title
            let author = decodedData.items[0].volumeInfo.authors?[0] ?? nil
            let publisher = decodedData.items[0].volumeInfo.publisher
            let publishedDate = decodedData.items[0].volumeInfo.publishedDate
            let numPages = decodedData.items[0].volumeInfo.pageCount
            let averageRating = decodedData.items[0].volumeInfo.averageRating
            let numBooksFound = decodedData.totalItems
            let link = decodedData.items[0].volumeInfo.infoLink ?? nil
            
            
            let bookModel = BookModel(bookName: bookName ?? nil, author: author ?? nil, publisher: publisher ?? nil, publishedDate: publishedDate ?? nil, numPages: numPages ?? nil, averageRating: averageRating ?? nil , numBooksFound: numBooksFound , link: link ?? nil)
            return bookModel
            
        }catch{
            let errorMessage = "No data found. Try searching for something else"
            self.delegate?.didFailWithError(send: errorMessage)
            return nil
        }
        
    }
}
