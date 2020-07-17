//
//  SearchResultViewController.swift
//  Book Finder
//
//  Created by Ebubechukwu Dimobi on 17.07.2020.
//  Copyright © 2020 Ebubechukwu Dimobi. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    var bookInfo:[BookModel]?
    var indexPath: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.bookInfo != nil {
            tableview.dataSource = self
            tableview.delegate = self
            
            //add custom xib TableViewCell
            tableview.register(UINib(nibName: "BookHolder", bundle: nil), forCellReuseIdentifier: "ReuseableCell")
            
            tableview.reloadData()
        }else {
            
            infoLabel.text = "No result Found!"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToResult"{
            let ResultViewController = segue.destination as! ResultViewController
            
            if let book = self.bookInfo{
                
                if let index = self.indexPath{
                    ResultViewController.bookInfo = book[index]
                }else {
                    infoLabel.text = "Error, try again"
                    
                }
                
            }
            
        }
        
    }
    
}

extension SearchResultViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookInfo?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReuseableCell", for: indexPath) as! BookHolder
        
        
        cell.bookImageView.image = #imageLiteral(resourceName: "isbn-back-cover-large")
        cell.bookNameLabel.text = bookInfo?[indexPath.row].bookName
        cell.authorNameLabel.text = bookInfo?[indexPath.row].author
        
        setStars(with: cell, using: bookInfo?[indexPath.row].averageRating)
        
        
        
        
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

extension SearchResultViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.indexPath = indexPath.row
        
        self.tableview.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    
}


