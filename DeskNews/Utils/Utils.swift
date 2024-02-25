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
    func getAppMode() -> Int {
        // 0- dark mode, 1- light mode
        if let retrievedString = UserDefaults.standard.string(forKey: "appMode") {
            if retrievedString == "LightMode" {
                return 1
            } else {
                return 0
            }
        } else {
            // if this key is nil by default app mode is light
            return 1
        }
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
func getCountryCode(countryName: String) -> String {
    switch countryName {
    case "unitedArabEmirates":
        return "ae"
    case "argentina":
        return "ar"
    case "austria":
        return "at"
    case "australia":
        return "au"
    case "belgium":
        return "be"
    case "bulgaria":
        return "bg"
    case "brazil":
        return "br"
    case "canada":
        return "ca"
    case "switzerland":
        return "ch"
    case "china":
        return "cn"
    case "colombia":
        return "co"
    case "cuba":
        return "cu"
    case "czechia":
        return "cz"
    case "denmark":
        return "de"
    case "egypt":
        return "eg"
    case "france":
        return "fr"
    case "unitedKingdom":
        return "gb"
    case "greece":
        return "gr"
    case "hongKong":
        return "hk"
    case "hungary":
        return "hu"
    case "indonesia":
        return "id"
    case "ireland":
        return "id"
    case "israel":
        return "ie"
    case "india":
        return "id"
    case "italy":
        return "it"
    case "japan":
        return "jp"
    case "southKorea":
        return "kr"
    case "lithuania":
        return "lt"
    case "latvia":
        return "lv"
    case "morocco":
        return "ma"
    case "mexico":
        return "mx"
    case "myanmar":
        return "my"
    case "nigeria":
        return "ng"
    case "netherlands":
        return "nl"
    case "norway":
        return "no"
    case "newZealand":
        return "nz"
    case "philippines":
        return "ph"
    case "poland":
        return "pl"
    case "portugal":
        return "pt"
    case "romania":
        return "ro"
    case "serbia":
        return"rs"
    case "russia":
        return "ru"
    case "southAfrica":
        return "sa"
    case "sweden":
        return "se"
    case "singapore":
        return "sg"
    case "slovenia":
        return "si"
    case "slovakia":
        return "sk"
    case "thailand":
        return "th"
    case "turkey":
        return "tr"
    case "taiwan":
        return "tw"
    case "ukraine":
        return "ua"
    case "unitedStates":
        return "us"
    case "venezuela":
        return "ve"
    case "zambia":
        return "za"
    default:
        return "in"
    }
}

//ae - unitedArabEmirates
//ar - argentina
//at - austria
//au - australia
//be - belgium
//bg - bulgaria
//br - brazil
//ca - canada
//ch - switzerland
//cn - china
//co - colombia
//cu - cuba
//cz - czechia
//de - denmark
//eg - egypt
//fr - france
//gb - unitedKingdom
//gr - greece
//hk - hongKong
//hu - hungary
//id - indonesia
//ie - ireland
//il - israel
//in - india
//it - italy
//jp - japan
//kr - southKorea
//lt - lithuania
//lv - latvia
//ma - morocco
//mx - mexico
//my - myanmar
//ng - nigeria
//nl - netherlands
//no - norway
//nz - newZealand
//ph - philippines
//pl - poland
//pt - portugal
//ro - romania
//rs - serbia
//ru - russia
//sa - southAfrica
//se - sweden
//sg - singapore
//si - slovenia
//sk - slovakia
//th - thailand
//tr - turkey
//tw - taiwan
//ua - ukraine
//us - unitedStates
//ve - venezuela
//za - zambia
