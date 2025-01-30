//
//  NewsOfTheDayFeedTableViewCell.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 23/08/23.
//

import UIKit
import Lottie
import SwiftUI

class NewsOfTheDayFeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contentLabelContentView: UIView!
    @IBOutlet weak var learnMoreButton: UIButton!
    @IBOutlet weak var newsContentLabel: UILabel!
    @IBOutlet weak var newsOfDayLabel: UILabel!
    @IBOutlet weak var newsDayView: UIView!
    @IBOutlet weak var contentImageView: CustomImageView!
    @IBOutlet weak var backGroundView: UIView!
    
    override func awakeFromNib() {
//        newsDayView.isHidden = true
//        learnMoreButton.isHidden = true
        selectionStyle = .none
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        self.contentView.backgroundColor = Thememanager.shared.mainBgColor
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpUI() {
//        newsDayView.isHidden = false
//        learnMoreButton.isHidden = false
        backGroundView.layer.cornerRadius = 25
        contentImageView.layer.cornerRadius = 25
        newsDayView.clipsToBounds = true
        newsDayView.layer.cornerRadius = 20
        learnMoreButton.layer.cornerRadius = 20
        newsOfDayLabel.layer.cornerRadius = 20
        contentLabelContentView.clipsToBounds = true
        newsDayView.clipsToBounds = true
        learnMoreButton.clipsToBounds = true
        contentLabelContentView.layer.cornerRadius = 15
        newsContentLabel.layer.cornerRadius = 15
        newsDayView.layer.cornerRadius = 15
        contentLabelContentView.layer.cornerRadius = 15
        contentLabelContentView.clipsToBounds = true
        learnMoreButton.layer.cornerRadius = 15
        learnMoreButton.addTarget(self, action: #selector(goToNewsWebTab(_:)), for: .touchUpInside)
        newsDayView.isSkeletonable = true
        newsDayView.showAnimatedGradientSkeleton()
        learnMoreButton.isSkeletonable = true
        learnMoreButton.showAnimatedSkeleton()
//        contentLabelContentView.isSkeletonable = true
//        contentLabelContentView.showAnimatedGradientSkeleton()
        backGroundView.isSkeletonable = true
        backGroundView.showAnimatedSkeleton()
    }
    func updateCell(apiResponse: ArticalSet) {
        setUpUI()
        newsDayView.hideSkeleton()
        learnMoreButton.hideSkeleton()
        contentLabelContentView.hideSkeleton()
        contentImageView.hideSkeleton()
        newsContentLabel.text = apiResponse.title
        backGroundView.contentMode = .scaleAspectFill
        if apiResponse.image != nil && apiResponse.image != "" {
            backGroundView.backgroundColor = .white
//            contentImageView.isHidden = false
            contentImageView.loadImage(urlString: apiResponse.image ?? "")
        } else {
//            contentImageView.image = UIImage(named: "images")
//            var animationView: LottieAnimationView?
//            animationView = .init(name: "no_data.json")
//            animationView!.frame = self.backGroundView.bounds
//            animationView!.contentMode = .scaleAspectFill
//            animationView!.loopMode = .loop
//            animationView!.animationSpeed = 0.5
//            animationView!.layer.cornerRadius = 15
//            self.backGroundView.backgroundColor = UIColor().hexStringToUIColor(hex: "#FFFFFF")
//            self.backGroundView.addSubview(animationView!)
//            self.backGroundView.bringSubviewToFront(self.learnMoreButton)
//            self.backGroundView.bringSubviewToFront(self.contentLabelContentView)
//            self.backGroundView.bringSubviewToFront(self.newsDayView)
//            animationView!.play()
        }
    }
    @objc func goToNewsWebTab(_ sender: UIButton) {
        guard let webVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsWebViewController") as? NewsWebViewController else {return}
        webVc.pageUrl = sender.accessibilityIdentifier ?? ""
        webVc.pageUrl = sender.accessibilityIdentifier ?? ""
        parentViewController?.navigationController?.pushViewController(webVc, animated: true)
    }
}
