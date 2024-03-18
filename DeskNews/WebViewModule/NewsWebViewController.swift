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
    @IBOutlet weak var backBtn: UIButton!
    
    var pageUrl: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPage()
    }
    override func viewWillAppear(_ animated: Bool) {
        Thememanager.shared.switchTheme()
        backBtn.tintColor = Thememanager.shared.tabBarTintColor
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
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
