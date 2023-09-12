//
//  NewsOfTheDayFeedTableViewCell.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 23/08/23.
//

import UIKit

class NewsOfTheDayFeedTableViewCell: UITableViewCell {

    @IBOutlet weak var learnMoreButton: UIButton!
    @IBOutlet weak var newsContentLabel: UILabel!
    @IBOutlet weak var newsOfDayLabel: UILabel!
    @IBOutlet weak var newsDayView: UIView!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var backGroundView: UIView!
    override func awakeFromNib() {
        newsDayView.isHidden = true
        learnMoreButton.isHidden = true
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
    }
    func updateCell(apiResponse: ArticalSet) {
        setUpUI()
        newsContentLabel.text = apiResponse.title
        contentImageView.contentMode = .scaleAspectFill
        Utils().downloadImage(from: ((apiResponse.urlToImage ?? apiResponse.url))!) { [weak self] image in
            DispatchQueue.main.async {
                self?.contentImageView.image = image
                self?.setButtonTextColor(fromImage: image!)
            }
        }
    }
    func setButtonTextColor(fromImage image: UIImage) {
        guard let ciImage = CIImage(image: image) else {
            return
        }
        let context = CIContext(options: nil)
        let roiRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        let renderedImage = context.createCGImage(ciImage, from: roiRect)
        let averageColor = renderedImage?.averageColor ?? .white
        let textColor: UIColor = averageColor.isLight ? (UIColor().hexStringToUIColor(hex: "003b4a")) : .white
        newsContentLabel.textColor = textColor
        newsDayView.backgroundColor = textColor
        newsOfDayLabel.backgroundColor = textColor
        learnMoreButton.backgroundColor = textColor
        if newsOfDayLabel.backgroundColor == .white {
            newsOfDayLabel.textColor = UIColor().hexStringToUIColor(hex: "003b4a")
        } else {
            newsOfDayLabel.textColor = .white
        }
        if learnMoreButton.backgroundColor == .white {
            learnMoreButton.setTitleColor(UIColor().hexStringToUIColor(hex: "003b4a"), for: .normal)
            learnMoreButton.tintColor = UIColor().hexStringToUIColor(hex: "003b4a")
        } else {
            learnMoreButton.setTitleColor(UIColor.white, for: .normal)
            learnMoreButton.tintColor = .white
        }
        
    }
}
