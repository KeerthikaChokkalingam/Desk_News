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
    
    func getRegularFont(type: String, size: CGFloat) -> UIFont {
        return UIFont(name: type, size: size) ?? UIFont()
    }
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error downloading image: \(error)")
                completion(nil)
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                print("Invalid image data")
                completion(nil)
                return
            }
            completion(image)
        }.resume()
    }
    
    func addRefreshController(sender: UITableView) -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
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
    
}
