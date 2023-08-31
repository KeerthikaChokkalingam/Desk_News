//
//  SingleNewsCollectionViewCell.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 30/08/23.
//

import UIKit

class SingleNewsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var previewButton: UIButton!
    @IBOutlet weak var newsAuthorNameLabel: UILabel!
    @IBOutlet weak var newsPublishedTimeLabel: UILabel!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        previewButton.isHidden = true
    }
    func loadValues(apiResponse: APIDataStruct) {
        newsImageView.clipsToBounds = true
        previewButton.isHidden = false
        newsImageView.contentMode = .scaleAspectFill
        newsImageView.layer.cornerRadius = 15
        previewButton.layer.cornerRadius = 15
        if apiResponse.image != nil  {
            previewButton.isHidden = true
            newsImageView.isHidden = false
            Utils().downloadImage(from: ((apiResponse.image!))) { [weak self] image in
                DispatchQueue.main.async {
                    self?.newsImageView.image = image
                }
            }
        } else {
            newsImageView.isHidden = true
            previewButton.isHidden = false
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
