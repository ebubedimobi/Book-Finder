//
//  WebViewViewController.swift
//  Book Finder
//
//  Created by Ebubechukwu Dimobi on 18.07.2020.
//  Copyright © 2020 Ebubechukwu Dimobi. All rights reserved.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {
    

    @IBOutlet weak var webView: WKWebView!
    
    var urlstring: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let safeString = urlstring{
            print(safeString)
            if let url = URL(string: safeString){
                let request = URLRequest(url: url)
                webView.load(request)
            }else {
                print("error creating session")
            }
        }else {
            print("error with safeString")
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
