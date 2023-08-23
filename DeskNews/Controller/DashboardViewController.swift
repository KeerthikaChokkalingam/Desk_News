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
    
    var topCategoriesList = AppConstant.categories
    private var identifier: String = "CategoryCollectionViewCell"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        registerCells()
    }
    
}

extension DashboardViewController {
    func registerCells() {
        categoriesCollections.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    func setUpUI() {
        categoriesCollections.delegate = self
        categoriesCollections.dataSource = self
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        categoriesCollections.collectionViewLayout = flowLayout
    }
}

extension DashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topCategoriesList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CategoryCollectionViewCell
        cell.prepareCell(selectedCategory: topCategoriesList[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let labelText = topCategoriesList[indexPath.row]
        let labelWidth = labelText.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]).width
        let cellWidth = labelWidth + 30
        return CGSize(width: cellWidth, height: 40)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
}
