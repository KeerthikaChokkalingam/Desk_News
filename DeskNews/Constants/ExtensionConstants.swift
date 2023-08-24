//
//  ExtensionConstants.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 24/08/23.
//

import UIKit

class ExtensionConstants: NSObject {
    
}
extension UIFont {
    enum Poppins {
        case regular(size: CGFloat)
        case medium(size: CGFloat)
        case bold(size: CGFloat)
        
        var font: UIFont! {
            switch self {
            case .regular(let size):
                return UIFont(name: "HelveticaNeue-Regular", size: size)
            case .medium(let size):
                return UIFont(name: "HelveticaNeue Medium", size: size)
            case .bold(let size):
                return UIFont(name: "Helvetica Neu Bold", size: size)
            }
        }
    }
}
