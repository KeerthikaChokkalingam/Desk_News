//
//  SelectedNewsViewController.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 13/09/23.
//

import UIKit
import Lottie

class SelectedNewsViewController: UIViewController {
    
    @IBOutlet weak var learnMoreBtn: UIButton!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var scrollContent: UIScrollView!
    @IBOutlet weak var bgView: UIView!
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
        Thememanager.shared.switchTheme()
        self.view.backgroundColor = Thememanager.shared.mainBgColor
        self.bgView.backgroundColor = Thememanager.shared.mainBgColor
        self.scrollContent.backgroundColor = Thememanager.shared.mainBgColor
        self.innerView.backgroundColor = Thememanager.shared.mainBgColor
        self.chanelName.textColor = Thememanager.shared.tabBarTintColor
        self.dateLabel.textColor = Thememanager.shared.tabBarTintColor
        self.newsTitle.textColor = Thememanager.shared.tabBarTintColor
        self.newDescriptionLabel.textColor = Thememanager.shared.tabBarTintColor
        self.learnMoreBtn.setTitleColor(Thememanager.shared.tabBarTintColor, for: .normal)
        self.learnMoreBtn.tintColor = Thememanager.shared.tabBarTintColor
        self.learnMoreBtn.setTitle("Learn More", for: .normal)
        self.learnMoreBtn.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        self.backButton.tintColor = Thememanager.shared.tabBarTintColor
        
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
            var animationView: LottieAnimationView?
            animationView = .init(name: "no_data.json")
            animationView!.frame = self.noPreviewImageButton.bounds
            animationView!.contentMode = .scaleAspectFill
            animationView!.loopMode = .loop
            animationView!.animationSpeed = 0.5
            animationView!.layer.cornerRadius = 15
            self.noPreviewImageButton.backgroundColor = UIColor().hexStringToUIColor(hex: "#FFFFFF")
            self.noPreviewImageButton.addSubview(animationView!)
            animationView!.play()
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
}
