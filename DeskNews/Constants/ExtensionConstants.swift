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
    func applyBlurEffectToView() {
        self.backgroundColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 0.1)
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.alpha = 0.7
        blurEffectView.isUserInteractionEnabled = false
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
