//
//  NewsOfTheDayFeedTableViewCell.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 23/08/23.
//

import UIKit

class NewsOfTheDayFeedTableViewCell: UITableViewCell {

    @IBOutlet weak var contentLabelContentView: UIView!
    @IBOutlet weak var learnMoreButton: UIButton!
    @IBOutlet weak var newsContentLabel: UILabel!
    @IBOutlet weak var newsOfDayLabel: UILabel!
    @IBOutlet weak var newsDayView: UIView!
    @IBOutlet weak var contentImageView: CustomImageView!
    @IBOutlet weak var backGroundView: UIView!
    
    override func awakeFromNib() {
        newsDayView.isHidden = true
        learnMoreButton.isHidden = true
        selectionStyle = .none
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpUI() {
        newsDayView.isHidden = false
        learnMoreButton.isHidden = false
        backGroundView.layer.cornerRadius = 25
        contentImageView.layer.cornerRadius = 25
        newsDayView.clipsToBounds = true
        newsDayView.layer.cornerRadius = 20
        learnMoreButton.layer.cornerRadius = 20
        newsOfDayLabel.layer.cornerRadius = 20
        contentLabelContentView.applyBlurEffectToView()
        newsDayView.applyBlurEffectToView()
        learnMoreButton.applyBlurEffectToView()
        contentLabelContentView.clipsToBounds = true
        newsDayView.clipsToBounds = true
        learnMoreButton.clipsToBounds = true
        contentLabelContentView.layer.cornerRadius = 15
        newsContentLabel.layer.cornerRadius = 15
        newsDayView.layer.cornerRadius = 15
        learnMoreButton.layer.cornerRadius = 15
    }
    func updateCell(apiResponse: ArticalSet) {
        setUpUI()
        newsContentLabel.text = apiResponse.title
        contentImageView.contentMode = .scaleAspectFill
        contentImageView.loadImage(urlString: apiResponse.urlToImage ?? "")
    }
}
