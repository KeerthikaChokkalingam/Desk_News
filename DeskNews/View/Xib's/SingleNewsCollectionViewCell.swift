//
//  SingleNewsCollectionViewCell.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 30/08/23.
//

import UIKit

class SingleNewsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var newsAuthorNameLabel: UILabel!
    @IBOutlet weak var newsPublishedTimeLabel: UILabel!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func loadValues(apiResponse: APIDataStruct) {
        Utils().downloadImage(from: ((apiResponse.image ?? apiResponse.url))!) { [weak self] image in
            DispatchQueue.main.async {
                self?.newsImageView.image = image
            }
        }
        newsAuthorNameLabel.text = apiResponse.author
        newsTitleLabel.text = apiResponse.title
        let dateString = Utils().dateFromISO8601String(apiResponse.published_at ?? "")
        let startDate = dateString ?? Date()
        let endDate = Date.now
        let timeInterval = endDate.timeIntervalSince(startDate)
        let someDate = Date(timeIntervalSinceNow: -(timeInterval))
        let timeAgoString = Utils().timeAgoSinceDate(someDate)
        if timeAgoString != "Just now" {
            newsPublishedTimeLabel.text = timeAgoString + " ago"
        } else {
            newsPublishedTimeLabel.text = timeAgoString
        }
    }
}
