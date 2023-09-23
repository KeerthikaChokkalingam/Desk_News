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
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
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
}
extension UIViewController {
    func internetFailure(childTableView: UITableView) {
        let controller = UIAlertController(title: "No Internet Detected", message: "This app requires an Internet connection", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            Utils().endRefreshController(sender: childTableView)
            controller.dismiss(animated: true)
        }
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
    func errorAlert(message: String) {
        let alert = UIAlertController(title: AppConstant.appName, message: message, preferredStyle: .alert)
        
        // Create the custom view and add it to the alert controller's view
        let customView = AlertWithIconView()
        customView.messageLabel.text = "It's out rush , Try again !!!"
        
        alert.view.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customView.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor),
            customView.topAnchor.constraint(equalTo: alert.view.topAnchor),
            customView.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor)
        ])
        
        // Add actions as needed
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        // Present the alert
        present(alert, animated: true, completion: nil)
    }
}
