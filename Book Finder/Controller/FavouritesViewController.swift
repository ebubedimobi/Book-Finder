//
//  FavouritesViewController.swift
//  Book Finder
//
//  Created by Ebubechukwu Dimobi on 23.07.2020.
//  Copyright © 2020 Ebubechukwu Dimobi. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //add custom xib TableViewCell
        tableView.register(UINib(nibName: "BookHolder", bundle: nil), forCellReuseIdentifier: "ReuseableCell")
        
        tableView.reloadData()
    }
}


