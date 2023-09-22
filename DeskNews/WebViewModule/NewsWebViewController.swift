//
//  NewsWebViewController.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 13/09/23.
//

import UIKit
import WebKit

class NewsWebViewController: UIViewController {
    
    @IBOutlet weak var newsWebView: WKWebView!
    
    var pageUrl: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPage()
    }
    
    @IBAction func backToFeedTab(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func loadPage() {
        if pageUrl != "" {
            newsWebView.load(URLRequest(url: URL(string: pageUrl)!))
        }
    }
}
