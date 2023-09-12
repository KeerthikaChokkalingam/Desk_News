//
//  ExtensionConstants.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 24/08/23.
//

import UIKit

class ExtensionConstants: NSObject {
    
}
extension UIView {
    func applyBlurEffect(opacity: Float) {
        let blurEffect = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.layer.opacity = opacity
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.applyCornerRadiusSpecify(topL: 0, topR: 0, bottomL: 1, bottomR: 1, radius: 12)
        blurEffectView.clipsToBounds = true
        blurEffectView.tag = 909091
        addSubview(blurEffectView)
        self.sendSubviewToBack(blurEffectView)
    }
    func blurEffect() {
        // 1
        self.backgroundColor = .clear
        // 2
        let blurEffect = UIBlurEffect(style: .dark)
        // 3
        let blurView = UIVisualEffectView(effect: blurEffect)
        // 4
        blurView.frame = self.bounds
        blurView.alpha = 0.7
        blurView.layer.cornerRadius = 12
        blurView.clipsToBounds = true
        blurView.tag = 909090
        self.insertSubview(blurView, at: 0)
    }
    func applyBlurEffectToView() {
        self.backgroundColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 0.1)
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.alpha = 0.7
        self.insertSubview(blurEffectView, at: 0)
    }
    func applyCornerRadiusSpecify(topL: Int, topR: Int, bottomL: Int, bottomR: Int, radius: CGFloat?=nil) {
        var neededCorners: CACornerMask = []
        if topL == 1 {
            neededCorners.insert(.layerMinXMinYCorner)
        }
        if topR == 1 {
            neededCorners.insert(.layerMaxXMinYCorner)
        }
        if bottomL == 1 {
            neededCorners.insert(.layerMinXMaxYCorner)
        }
        if bottomR == 1 {
            neededCorners.insert(.layerMaxXMaxYCorner)
        }
        self.layer.cornerRadius = radius ?? 15
        self.layer.maskedCorners = neededCorners
    }
    
}
extension UIColor {
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    var isLight: Bool {
        var white: CGFloat = 0.0
        getWhite(&white, alpha: nil)
        return white > 0.5
    }
}
extension CGImage {
    var averageColor: UIColor {
        guard let pixelData = dataProvider?.data else { return .clear }
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)

        var totalRed = 0
        var totalGreen = 0
        var totalBlue = 0

        for x in 0..<width {
            for y in 0..<height {
                let pixelInfo: Int = ((Int(width) * Int(y)) + Int(x)) * 4

                let red = CGFloat(data[pixelInfo])
                let green = CGFloat(data[pixelInfo + 1])
                let blue = CGFloat(data[pixelInfo + 2])

                totalRed += Int(red)

                totalGreen += Int(green)
                totalBlue += Int(blue)
            }
        }

        let count = width * height
        let red = CGFloat(totalRed) / CGFloat(count)
        let green = CGFloat(totalGreen) / CGFloat(count)
        let blue = CGFloat(totalBlue) / CGFloat(count)

        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1.0)
    }
}
