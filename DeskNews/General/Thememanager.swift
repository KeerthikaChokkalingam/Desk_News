//
//  Thememanager.swift
//  DeskNews
//
//  Created by Keerthika on 22/02/24.
//

import UIKit

enum Theme {
    case light
    case dark
}

class Thememanager: NSObject {
    static let shared = Thememanager()
    private override init() {}
    
    var currentTheme: Theme = .light
    
    
    func switchTheme() {
        if let retrievedString = UserDefaults.standard.string(forKey: "appMode") {
            if retrievedString == "LightMode" {
                currentTheme = .light
            } else {
                currentTheme = .dark
            }
        } else {
            currentTheme = .light
        }
    }
    
    var mainBgColor: UIColor {
        get {
            let bgColor = currentTheme == .light ? UIColor().hexStringToUIColor(hex: "#C8FFE0") : UIColor().hexStringToUIColor(hex: "#003B4A")
            return bgColor
        }
    }
    var tabBarTintColor: UIColor {
        get {
            let bgColor = currentTheme == .light ? UIColor().hexStringToUIColor(hex: "#003B4A") : UIColor().hexStringToUIColor(hex: "#C8FFE0")
            return bgColor
        }
    }
}

