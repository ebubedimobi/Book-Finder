//
//  FavouritesViewController.swift
//  Book Finder
//
//  Created by Ebubechukwu Dimobi on 23.07.2020.
//  Copyright © 2020 Ebubechukwu Dimobi. All rights reserved.
//

import UIKit
import RealmSwift
import Kingfisher

class FavouritesViewController: UIViewController {
    let realm = try! Realm()
    
    var favoriteBooks: Results<FavoriteBooks>?
    
    var indexPath: Int? //for tracking index path
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add custom xib TableViewCell
        tableView.register(UINib(nibName: "BookHolder", bundle: nil), forCellReuseIdentifier: "ReuseableCell")
        
        loadCategories()
        
        if self.favoriteBooks?.count == 0 {
            
            navigationItem.title = "Add a book!"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tableView.register(UINib(nibName: "BookHolder", bundle: nil), forCellReuseIdentifier: "ReuseableCell")
        loadCategories()
    }
    
    //MARK: - load data
    func loadCategories(){
        
        
        favoriteBooks = realm.objects(FavoriteBooks.self).sorted(byKeyPath: "bookName", ascending: true)
        
        tableView.reloadData()
        
        
        
    }
}

// MARK: - Table view data source

extension FavouritesViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteBooks?.count ?? 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReuseableCell", for: indexPath) as! BookHolder
        
        if favoriteBooks != nil{
            
            if  favoriteBooks![indexPath.row].imageURL != "" {
                
                var imageURL = favoriteBooks![indexPath.row].imageURL
                
                imageURL.insert("s", at: imageURL.index(imageURL.startIndex, offsetBy: 4))
                
                
                
                let url = URL(string: imageURL )
                
                let processor = DownsamplingImageProcessor(size: cell.bookImageView.bounds.size) |> RoundCornerImageProcessor(cornerRadius: 7.5)
                
                cell.bookImageView.kf.indicatorType = .activity
                
                
                cell.bookImageView.kf.setImage(
                    with: url,
                    options: [
                        .processor(processor),
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(0.5)),
                        .cacheOriginalImage
                ])
                
            }
            
            
            cell.bookNameLabel.text = favoriteBooks?[indexPath.row].bookName
            cell.authorNameLabel.text = favoriteBooks?[indexPath.row].author
            
            setStars(with: cell, using: favoriteBooks?[indexPath.row].averageRating)
            
            cell.accessoryType = .none
        }
        
        
        return cell
    }
    
    
    func setStars(with cell: BookHolder ,using averageRating: Double?){
        
        
        switch averageRating ?? 0.0 {
        case 0.0:
            cell.star1.image = UIImage(systemName: "star")
            cell.star2.image = UIImage(systemName: "star")
            cell.star3.image = UIImage(systemName: "star")
            cell.star4.image = UIImage(systemName: "star")
            cell.star5.image = UIImage(systemName: "star")
        case 0.0..<1.0 :
            cell.star1.image = UIImage(systemName: "star.lefthalf.fill")
            cell.star2.image = UIImage(systemName: "star")
            cell.star3.image = UIImage(systemName: "star")
            cell.star4.image = UIImage(systemName: "star")
            cell.star5.image = UIImage(systemName: "star")
        case 1.0 :
            cell.star1.image = UIImage(systemName: "star.fill")
            cell.star2.image = UIImage(systemName: "star")
            cell.star3.image = UIImage(systemName: "star")
            cell.star4.image = UIImage(systemName: "star")
            cell.star5.image = UIImage(systemName: "star")
        case 1.0..<2.0 :
            cell.star1.image = UIImage(systemName: "star.fill")
            cell.star2.image = UIImage(systemName: "star.lefthalf.fill")
            cell.star3.image = UIImage(systemName: "star")
            cell.star4.image = UIImage(systemName: "star")
            cell.star5.image = UIImage(systemName: "star")
        case 2.0 :
            cell.star1.image = UIImage(systemName: "star.fill")
            cell.star2.image = UIImage(systemName: "star.fill")
            cell.star3.image = UIImage(systemName: "star")
            cell.star4.image = UIImage(systemName: "star")
            cell.star5.image = UIImage(systemName: "star")
        case 2.0..<3.0 :
            cell.star1.image = UIImage(systemName: "star.fill")
            cell.star2.image = UIImage(systemName: "star.fill")
            cell.star3.image = UIImage(systemName: "star.lefthalf.fill")
            cell.star4.image = UIImage(systemName: "star")
            cell.star5.image = UIImage(systemName: "star")
        case 3.0 :
            cell.star1.image = UIImage(systemName: "star.fill")
            cell.star2.image = UIImage(systemName: "star.fill")
            cell.star3.image = UIImage(systemName: "star.fill")
            cell.star4.image = UIImage(systemName: "star")
            cell.star5.image = UIImage(systemName: "star")
        case 3.0..<4.0 :
            cell.star1.image = UIImage(systemName: "star.fill")
            cell.star2.image = UIImage(systemName: "star.fill")
            cell.star3.image = UIImage(systemName: "star.fill")
            cell.star4.image = UIImage(systemName: "star.lefthalf.fill")
            cell.star5.image = UIImage(systemName: "star")
        case 4.0 :
            cell.star1.image = UIImage(systemName: "star.fill")
            cell.star2.image = UIImage(systemName: "star.fill")
            cell.star3.image = UIImage(systemName: "star.fill")
            cell.star4.image = UIImage(systemName: "star.fill")
            cell.star5.image = UIImage(systemName: "star")
        case 4.0..<5.0 :
            cell.star1.image = UIImage(systemName: "star.fill")
            cell.star2.image = UIImage(systemName: "star.fill")
            cell.star3.image = UIImage(systemName: "star.fill")
            cell.star4.image = UIImage(systemName: "star.fill")
            cell.star5.image = UIImage(systemName: "star.lefthalf.fill")
        case 5.0 :
            cell.star1.image = UIImage(systemName: "star.fill")
            cell.star2.image = UIImage(systemName: "star.fill")
            cell.star3.image = UIImage(systemName: "star.fill")
            cell.star4.image = UIImage(systemName: "star.fill")
            cell.star5.image = UIImage(systemName: "star.fill")
        default:
            print("do nothing")
        }
    }
}

//MARK: - TableView Delegate Methods
extension FavouritesViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.indexPath = indexPath.row
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "goToResult2", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToResult2"{
            let ResultViewController = segue.destination as! ResultViewController
            
            if let index = indexPath {
                if let book = favoriteBooks?[index]{
                    
                    let favoriteBookInfo = BookModel(bookName: book.bookName, author: book.author, publisher: book.publisher, publishedDate: book.publishedDate, numPages: book.numPages, averageRating: book.averageRating, link: book.link, imageURL: book.imageURL)
                    
                    ResultViewController.bookInfo = favoriteBookInfo
                }
            }
        }
        
    }
    
    //MARK: - swipe action delegate methods
    
    //swipe from right
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let trash = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions:[trash])
    }
    
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction{
        
        
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            
            if let bookForDeletion = self.favoriteBooks?[indexPath.row]{
                do{
                    
                    try self.realm.write{
                        
                        self.realm.delete(bookForDeletion)
                        completion(true)
                    }
                }catch{
                    print("Error while deleting")
                    completion(false)
                }
                
                self.tableView.reloadData()
            }
            
        }
        action.image = UIImage(systemName: "trash")
        action.backgroundColor = .red
        
        return action
        
    }
    
    
    
}


//MARK: - Quering/searching from Realm

extension FavouritesViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        favoriteBooks = favoriteBooks?.filter("bookName CONTAINS[cd]  %@", searchBar.text!).sorted(byKeyPath: "bookName", ascending: true)
        
        tableView.reloadData()
        
    }
    
    //starts searching once person starts typing
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0{
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            loadCategories()
        }else {
            
            favoriteBooks = favoriteBooks?.filter("bookName CONTAINS[cd]  %@", searchBar.text!).sorted(byKeyPath: "bookName", ascending: true)
            tableView.reloadData()
        }
    }
}
