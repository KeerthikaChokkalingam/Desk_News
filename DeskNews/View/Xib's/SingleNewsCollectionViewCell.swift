//
//  SingleNewsCollectionViewCell.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 30/08/23.
//

import UIKit
import Lottie

class SingleNewsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var previewButton: UIButton!
    @IBOutlet weak var newsAuthorNameLabel: UILabel!
    @IBOutlet weak var newsPublishedTimeLabel: UILabel!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsImageView: CustomImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        previewButton.isHidden = true
        mainContentView.layer.cornerRadius = 15
        mainContentView.isSkeletonable = true
        mainContentView.showAnimatedSkeleton()
    }
    func loadValues(apiResponse: ArticalSet) {
        newsImageView.clipsToBounds = true
        previewButton.isHidden = false
        newsImageView.contentMode = .scaleAspectFill
        newsImageView.layer.cornerRadius = 15
        previewButton.layer.cornerRadius = 15
        let urlString = apiResponse.image
        if urlString != nil && Utils().isValidURL((urlString!)) {
            previewButton.isHidden = true
            newsImageView.isHidden = false
            newsImageView.loadImage(urlString: apiResponse.image ?? "")
        } else {
            newsImageView.isHidden = true
            previewButton.isHidden = false
            
            var animationView: LottieAnimationView?
            animationView = .init(name: "no_data.json")
            
            if let animView = self.previewButton.viewWithTag(30) {
                let animationViewSize = CGSize(width: self.previewButton.bounds.width - 50, height: self.previewButton.bounds.height)
                animationView!.frame = CGRect(x: -10, y: 10, width: animationViewSize.width, height: animationViewSize.height)
                animView.removeFromSuperview()
                animationView!.frame = self.previewButton.bounds
            } else {
                let animationViewSize = CGSize(width: self.previewButton.bounds.width - 50, height: self.previewButton.bounds.height)
                animationView!.frame = CGRect(x: -10, y: 10, width: animationViewSize.width, height: animationViewSize.height)
            }
            animationView!.contentMode = .scaleAspectFit
            animationView!.loopMode = .loop
            animationView!.animationSpeed = 0.5
            animationView!.tag = 30;
            animationView!.layer.cornerRadius = 15
            self.previewButton.backgroundColor = UIColor().hexStringToUIColor(hex: "#FFFFFF")
            self.previewButton.addSubview(animationView!)
            animationView!.play()
        }
        newsAuthorNameLabel.text = apiResponse.author
        if apiResponse.author == "" || apiResponse.author == nil {
            newsAuthorNameLabel.text = "No Author"
        }
        newsTitleLabel.text = apiResponse.title
        let dateString = Utils().dateFromISO8601String(apiResponse.publishedAt ?? "")
        let startDate = dateString ?? Date()
        let endDate = Date.now
        let timeInterval = endDate.timeIntervalSince(startDate)
        let someDate = Date(timeIntervalSinceNow: TimeInterval(-(timeInterval)))
        let timeAgoString = Utils().timeAgoSinceDate(someDate)
        if timeAgoString != "Just now" {
            newsPublishedTimeLabel.text = timeAgoString + " ago"
        } else {
            newsPublishedTimeLabel.text = timeAgoString
        }
    }
}
