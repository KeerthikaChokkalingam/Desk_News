//
//  Utils.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 25/08/23.
//

import Foundation
import UIKit
import SystemConfiguration

class Utils {
    func addRefreshController(sender: UITableView) -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Fetch Latest News")
        refreshControl.tag = 333
        sender.addSubview(refreshControl)
        return refreshControl
    }
    func endRefreshController(sender: UITableView) {
        if let refresher = sender.viewWithTag(333) as? UIRefreshControl {
            refresher.endRefreshing()
        }
    }
    func setUpLoader(sender: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = sender.center
        activityIndicator.color = UIColor.gray
        activityIndicator.tag = 444
        sender.addSubview(activityIndicator)
        return activityIndicator
    }
    func startLoading(sender: UIActivityIndicatorView, wholeView: UIView) {
        if let indicator = sender.viewWithTag(444) as? UIActivityIndicatorView {
            indicator.isHidden = false
            indicator.startAnimating()
        }
    }
    func endLoading(sender: UIActivityIndicatorView, wholeView: UIView) {
        if let indicator = sender.viewWithTag(444) as? UIActivityIndicatorView {
            indicator.isHidden = true
            indicator.hidesWhenStopped = true
            indicator.stopAnimating()
        }
    }
    
    func dateFromISO8601String(_ dateString: String) -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter.date(from: dateString)
    }
    
    func timeAgoSinceDate(_ date: Date) -> String {
        let now = Date()
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        
        if let timeDifference = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date, to: now).year, timeDifference > 0 {
            formatter.allowedUnits = [.year]
        } else if let timeDifference = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date, to: now).month, timeDifference > 0 {
            formatter.allowedUnits = [.month]
        } else if let timeDifference = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date, to: now).day, timeDifference > 0 {
            formatter.allowedUnits = [.day]
        } else if let timeDifference = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date, to: now).hour, timeDifference > 0 {
            formatter.allowedUnits = [.hour]
        } else if let timeDifference = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date, to: now).minute, timeDifference > 0 {
            formatter.allowedUnits = [.minute]
        } else {
            return "Just now"
        }
        
        return formatter.string(from: date, to: now) ?? ""
    }
    func isValidURL(_ urlString: String) -> Bool {
        if let url = URL(string: urlString) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    func lazyLoaderShow(sender: UITableView) {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: 70, height: CGFloat(70))
        sender.tableFooterView = spinner
        sender.tableFooterView?.isHidden = false
    }
}

func addGradientToView(view: UIView) {
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = view.bounds

    // Define the colors for your gradient
    let color1 = (UIColor().hexStringToUIColor(hex: "#003b4a")).cgColor
    let color2 = (UIColor().hexStringToUIColor(hex: "C8FFE0")).cgColor
    gradientLayer.colors = [color2, color1]

    // Define the start and end points of the gradient
    gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
    gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)

    // You can adjust the locations of the colors if needed
    gradientLayer.locations = [0.0, 1.0]

    view.layer.insertSublayer(gradientLayer, at: 0)
}
