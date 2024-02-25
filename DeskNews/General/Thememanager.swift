//
//  Thememanager.swift
//  DeskNews
//
//  Created by Keerthika on 22/02/24.
//

import UIKit

class Thememanager: NSObject {
    static let shared = Thememanager()
    private override init() {}
    
    var currentTheme: Theme = .light
    
    enum Theme {
        case light
        case dark
    }
    
    func switchTheme() {
        currentTheme = (currentTheme == .light) ? .dark : .light
    }
}

class colorManager: NSObject {
    let appMode = Utils().getAppMode()
    var mainBgColor: UIColor {
        get {
            let bgColor = appMode == 1 ? UIColor().hexStringToUIColor(hex: "#C8FFE0") : UIColor().hexStringToUIColor(hex: "#C8FFE0")
            return bgColor
        }
    }
    var tabBarTintColor: UIColor {
        get {
            let bgColor = appMode == 1 ? UIColor().hexStringToUIColor(hex: "#003B4A") : UIColor().hexStringToUIColor(hex: "#003B4A")
            return bgColor
        }
    }
}
