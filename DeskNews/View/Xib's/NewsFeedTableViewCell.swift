//
//  NewsFeedTableViewCell.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 13/09/23.
//

import UIKit
import Lottie
import SwiftUI

class NewsFeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var noPreViewButton: UIButton!
    @IBOutlet weak var newsImageView: CustomImageView!
    @IBOutlet weak var chanelNameLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        noPreViewButton.isHidden = true
        noPreViewButton.layer.cornerRadius = 15
        bgView.layer.cornerRadius = 15
        newsImageView.layer.cornerRadius = 15
        selectionStyle = .none
        bgView.layer.cornerRadius = 15
        bgView.layer.masksToBounds = false
        bgView.layer.shadowColor = UIColor().hexStringToUIColor(hex: "#F9FAFB").cgColor
        bgView.layer.shadowOpacity = 0.3
        bgView.layer.shadowOffset = CGSize(width: 0, height: 2)
        bgView.layer.shadowRadius = 4.0
        bgView.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 8.0).cgPath
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        self.contentView.backgroundColor = Thememanager.shared.mainBgColor
        bgView.backgroundColor = Thememanager.shared.tabBarTintColor
        chanelNameLabel.textColor = Thememanager.shared.mainBgColor
        dateTimeLabel.textColor = Thememanager.shared.mainBgColor
        authorLabel.textColor = Thememanager.shared.mainBgColor
        titleLabel.textColor = Thememanager.shared.mainBgColor
    }
    
    func applyServerResult(values: ArticalSet) {
        chanelNameLabel.text = values.source?.name
        authorLabel.text = values.author
        titleLabel.text = values.title
        if values.urlToImage != nil && values.urlToImage != "" {
            noPreViewButton.isHidden = true
            newsImageView.isHidden = false
            newsImageView.loadImage(urlString: values.urlToImage ?? "")
            newsImageView.contentMode = .scaleAspectFill
        } else {
            newsImageView.isHidden = true
            noPreViewButton.isHidden = false
            var animationView: LottieAnimationView?
            animationView = .init(name: "no_data.json")
            animationView!.frame = self.noPreViewButton.bounds
            animationView!.contentMode = .scaleAspectFill
            animationView!.loopMode = .loop
            animationView!.animationSpeed = 0.5
            animationView!.layer.cornerRadius = 15
            self.noPreViewButton.backgroundColor = UIColor().hexStringToUIColor(hex: "#FFFFFF")
            self.noPreViewButton.addSubview(animationView!)
            animationView!.play()
        }
        let dateString = Utils().dateFromISO8601String(values.publishedAt ?? "")
        let startDate = dateString ?? Date()
        let endDate = Date.now
        let timeInterval = endDate.timeIntervalSince(startDate)
        let someDate = Date(timeIntervalSinceNow: TimeInterval(-(timeInterval)))
        let timeAgoString = Utils().timeAgoSinceDate(someDate)
        if timeAgoString != "Just now" {
            dateTimeLabel.text = timeAgoString + " ago"
        } else {
            dateTimeLabel.text = timeAgoString
        }
    }
}
