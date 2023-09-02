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
    convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 { // Alpha channel included
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xFF000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00FF0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000FF00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000FF) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            } else if hexColor.count == 6 { // No alpha channel
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x0000FF) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: 1.0)
                    return
                }
            }
        }
        
        return nil
    }
}
