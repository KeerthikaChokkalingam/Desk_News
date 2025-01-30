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

extension UIColor {
    func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }

    func darker(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: -abs(percentage) )
    }

    func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0;
        if (self.getRed(&r, green: &g, blue: &b, alpha: &a)) {
            return UIColor(red: min(r + percentage/100, 1.0),
                           green: min(g + percentage/100, 1.0),
                           blue: min(b + percentage/100, 1.0),
                           alpha: a)
        } else {
            return nil
        }
    }
}

func createShimmerLayer(for view: UIView, isLightTheme: Bool) {
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = view.bounds
    gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
    gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)

    let baseColor = isLightTheme ? UIColor().hexStringToUIColor(hex: "#C8FFE0") : UIColor().hexStringToUIColor(hex: "#003B4A")

    let highlightColor = isLightTheme ? baseColor.lighter(by: 20) : baseColor.lighter(by: 30)
    let shadeColor = isLightTheme ? baseColor.darker(by: 10) : baseColor.darker(by: 20)


    gradientLayer.colors = [
        shadeColor?.cgColor ?? baseColor.cgColor,
        baseColor.cgColor,
        highlightColor?.cgColor ?? baseColor.cgColor,
        baseColor.cgColor,
        shadeColor?.cgColor ?? baseColor.cgColor
    ]

    gradientLayer.locations = [0, 0.35, 0.5, 0.65, 1]

    let animation = CABasicAnimation(keyPath: "transform.translation.x")
    animation.fromValue = -view.frame.width
    animation.toValue = view.frame.width
    animation.duration = 1.5 // Adjust speed as needed
    animation.repeatCount = .infinity
    gradientLayer.add(animation, forKey: "shimmer")

    view.layer.mask = gradientLayer // Important: Use mask
}
