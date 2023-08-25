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
}
