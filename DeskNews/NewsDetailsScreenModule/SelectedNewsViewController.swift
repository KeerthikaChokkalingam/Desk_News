//
//  SelectedNewsViewController.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 13/09/23.
//

import UIKit

class SelectedNewsViewController: UIViewController {
    
    @IBOutlet weak var chanelName: UILabel!
    @IBOutlet weak var newFeedImageView: CustomImageView!
    @IBOutlet weak var newDescriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    
    var selectedNewsData = ArticalSet()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
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
        newFeedImageView.loadImage(urlString: selectedNewsData.urlToImage ?? "")
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
}
