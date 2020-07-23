//
//  BookManager.swift
//  Book Finder
//
//  Created by Ebubechukwu Dimobi on 12.07.2020.
//  Copyright © 2020 Ebubechukwu Dimobi. All rights reserved.
//

import Foundation

protocol BookManagerDelegate {
    func didUpdateBooks(_ bookManager: BookManager, bookModel: [BookModel])
    func didFailWithError(send errorMessage:String )
}

struct BookManager {
    let baseBookURL = "https://www.googleapis.com/books/v1/volumes?q="
    
    
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
            
            //Key.apiKey is your api key with "&" behind it
            bookURL = "\(bookURL)\(Key.apiKey)"
            performRequest(with: bookURL)
            
        }else {
            let bookURL = "\(baseBookURL)\(name)\(Key.apiKey)"
            performRequest(with : bookURL )
            
        }
        
        
    }
    
    func fetchBookWithISBN(with ISBN: String){
        
        let bookURL = "\(baseBookURL)isbn:\(ISBN)\(Key.apiKey)"
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
                        
                        print(bookModel[0].bookName ?? "error line 74")
                        
                        DispatchQueue.main.async {
                            self.delegate?.didUpdateBooks(self, bookModel: bookModel)
                        }
                        
                    }
                }
                else {
                    print("error line 80")
                }
            }
            task.resume()
        }
    }
    
    
    func parseJSON(with bookData: Data) -> [BookModel]? {
        
        let decoder = JSONDecoder()
        var bookArray = [BookModel]()
        
        do{
            let decodedData = try decoder.decode(BookData.self, from: bookData)
            
            
            
            for index in 0..<decodedData.items.count{
                
                
                let bookName = decodedData.items[index].volumeInfo.title
                let author = decodedData.items[index].volumeInfo.authors?[0] ?? nil
                let publisher = decodedData.items[index].volumeInfo.publisher
                let publishedDate = decodedData.items[index].volumeInfo.publishedDate
                let numPages = decodedData.items[index].volumeInfo.pageCount
                let averageRating = decodedData.items[index].volumeInfo.averageRating
                let link = decodedData.items[index].volumeInfo.infoLink ?? nil
                let imageURL = decodedData.items[index].volumeInfo.imageLinks.thumbnail ?? nil
                
                bookArray.append(BookModel(bookName: bookName ?? nil, author: author ?? nil, publisher: publisher ?? nil, publishedDate: publishedDate ?? nil, numPages: numPages ?? nil, averageRating: averageRating ?? nil, link: link ?? nil, imageURL: imageURL))
            }
            return bookArray
            
        }catch{
            let errorMessage = "No data found. Try searching for something else"
            self.delegate?.didFailWithError(send: errorMessage)
            return nil
        }
        
    }
}
