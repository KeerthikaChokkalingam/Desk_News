//
//  Dashboard View Model.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 23/08/23.
//

import Foundation
import UIKit

class DashboardViewModel: NSObject {
    
    func cellForTableView(baseTableView: UITableView, signleArticleSet: ArticalSet, indexPathValue: IndexPath, newsCollections: [ArticalSet]) -> UITableViewCell {
        switch indexPathValue.row {
        case 0 :
            guard let cell = baseTableView.dequeueReusableCell(withIdentifier: "NewsOfTheDayFeedTableViewCell", for: indexPathValue) as? NewsOfTheDayFeedTableViewCell else {return UITableViewCell()}
            if signleArticleSet.title != nil {
                cell.updateCell(apiResponse: signleArticleSet)
                cell.learnMoreButton.accessibilityIdentifier = signleArticleSet.url
                cell.contentLabelContentView.applyBlurEffectToView()
                cell.newsDayView.applyBlurEffectToView()
                cell.learnMoreButton.applyBlurEffectToView()
            } else {
                cell.backGroundView.backgroundColor = .white
                cell.setUpUI()
            }
            return cell
        case 1:
            guard let cell = baseTableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell", for: indexPathValue) as? TitleTableViewCell else {return UITableViewCell()}
            if signleArticleSet.title != nil {
                cell.liveNewsLabel.hideSkeleton()
                cell.liveNewsLabel.font = UIFont.boldSystemFont(ofSize: 17)
                cell.liveNewsLabel.text = "Live News Around You"
            }
            return cell
        default:
            guard let cell = baseTableView.dequeueReusableCell(withIdentifier: "LiveNewsContentTableViewCell", for: indexPathValue) as? LiveNewsContentTableViewCell else {return UITableViewCell()}
            if newsCollections.count != 0 {
                cell.singleNewsListCollections.hideSkeleton()
                cell.getValuesFromApiRoadCollections(apiResponse: newsCollections)
            }
            return cell
        }
    }
    func heightForTableViewRow(indexpath: Int) -> CGFloat {
        switch indexpath {
        case 0 :
            if UIDevice.current.userInterfaceIdiom == .pad {
                return 550
            } else {
                return 355
            }
        case 1:
            if UIDevice.current.userInterfaceIdiom == .pad {
                return 100
            } else {
                return 50
            }
        default:
            if UIDevice.current.userInterfaceIdiom == .pad {
                return 380
            } else {
                return 240
            }
        }
    }
}
