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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.bookInfo != nil {
            tableview.dataSource = self
            
            tableview.register(UINib(nibName: "BookHolder", bundle: nil), forCellReuseIdentifier: "ReuseableCell")
            
            tableview.reloadData()
        }else {
            
            infoLabel.text = "No result Found!"
        }
    }
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
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
        
        
        return cell
        
        
    }
    
    
    
}
