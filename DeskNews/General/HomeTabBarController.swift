//
//  HomeTabBarController.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 16/09/23.
//

import UIKit

class HomeTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBar.isHidden = false
    }

}
