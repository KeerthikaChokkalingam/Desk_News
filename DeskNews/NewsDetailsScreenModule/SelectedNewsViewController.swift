//
//  SelectedNewsViewController.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 13/09/23.
//

import UIKit

class SelectedNewsViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var noPreviewImageButton: UIButton!
    @IBOutlet weak var chanelName: UILabel!
    @IBOutlet weak var newFeedImageView: CustomImageView!
    @IBOutlet weak var newDescriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    
    var selectedNewsData = ArticalSet()
    var searchModelBase: SearchTabViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        handleAppMode()
    }
    
    @IBAction func backToNewsTab(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func goToNewsUrl(_ sender: UIButton) {
        guard let webVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsWebViewController") as? NewsWebViewController else {return}
        webVc.pageUrl = selectedNewsData.url ?? ""
        self.navigationController?.pushViewController(webVc, animated: true)
    }
}

extension SelectedNewsViewController {
    func setUpUI() {
        newFeedImageView.layer.cornerRadius = 15
        noPreviewImageButton.layer.cornerRadius = 15
        if selectedNewsData.urlToImage != nil && selectedNewsData.urlToImage != "" {
            noPreviewImageButton.isHidden = true
            newFeedImageView.loadImage(urlString: selectedNewsData.urlToImage ?? "") { success, error  in
                if success == "success" && error == 0 {
                    self.searchModelBase = SearchTabViewModel()
                    self.backButton.tintColor = self.searchModelBase.setButtonTextColor(fromImage: self.newFeedImageView.image ?? UIImage())
                }
            }
        } else {
            newFeedImageView.isHidden = true
            noPreviewImageButton.isHidden = false
        }
        newsTitle.text = selectedNewsData.title
        chanelName.text = selectedNewsData.source?.name
        let content = selectedNewsData.content?.split(separator: "[")
        newDescriptionLabel.text = (selectedNewsData.description ?? "") + " /n" + (String(content?[0] ?? "") )
        let dateString = Utils().dateFromISO8601String(selectedNewsData.publishedAt ?? "")
        let startDate = dateString ?? Date()
        let endDate = Date.now
        let timeInterval = endDate.timeIntervalSince(startDate)
        let someDate = Date(timeIntervalSinceNow: TimeInterval(-(timeInterval)))
        let timeAgoString = Utils().timeAgoSinceDate(someDate)
        if timeAgoString != "Just now" {
            dateLabel.text = timeAgoString + " ago"
        } else {
            dateLabel.text = timeAgoString
        }
    }
    func handleAppMode() {
        if let retrievedString = UserDefaults.standard.string(forKey: "appMode") {
            if retrievedString == "LightMode" {
                print("light Mode")
            } else {
                print("dark mode")
            }
        }
    }
}
