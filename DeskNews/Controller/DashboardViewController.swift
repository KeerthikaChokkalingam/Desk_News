//
//  DashboardViewController.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 22/08/23.
//

import UIKit

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var selectedCategoryLabel: UILabel!
    @IBOutlet weak var newsList: UITableView!
    @IBOutlet weak var categoriesCollections: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
