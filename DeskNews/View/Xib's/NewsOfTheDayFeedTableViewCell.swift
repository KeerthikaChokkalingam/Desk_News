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
        super.awakeFromNib()
        setUpUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setUpUI() {
        backGroundView.layer.cornerRadius = 25
        contentImageView.layer.cornerRadius = 25
        newsDayView.layer.cornerRadius = 20
        newsOfDayLabel.layer.cornerRadius = 20
    }
    func updateCell(apiResponse: APIDataStruct) {
        newsContentLabel.text = apiResponse.title
        contentImageView.contentMode = .scaleAspectFill
        Utils().downloadImage(from: ((apiResponse.image ?? apiResponse.url))!) { [weak self] image in
            DispatchQueue.main.async {
                self?.contentImageView.image = image
            }
        }
    }
}
