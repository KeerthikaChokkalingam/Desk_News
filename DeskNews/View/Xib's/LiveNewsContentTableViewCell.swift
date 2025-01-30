//
//  LiveNewsContentTableViewCell.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 30/08/23.
//

import UIKit

class LiveNewsContentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var singleNewsListCollections: UICollectionView!
    @IBOutlet weak var childView: UIView!
    
    var collectionValues = [ArticalSet]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    override func layoutSubviews() {
        self.contentView.backgroundColor = Thememanager.shared.mainBgColor
        self.childView.backgroundColor = Thememanager.shared.mainBgColor
        self.singleNewsListCollections.backgroundColor = Thememanager.shared.mainBgColor
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
extension LiveNewsContentTableViewCell {
    func setUpUI() {
        singleNewsListCollections.delegate = self
        singleNewsListCollections.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        singleNewsListCollections.collectionViewLayout = layout
        singleNewsListCollections.register(UINib(nibName: "SingleNewsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SingleNewsCollectionViewCell")
        singleNewsListCollections.isSkeletonable = true
        singleNewsListCollections.showAnimatedSkeleton()
    }
    func getValuesFromApiRoadCollections(apiResponse: [ArticalSet]) {
        collectionValues = apiResponse
        DispatchQueue.main.async {
            self.singleNewsListCollections.reloadData()
        }
    }
}

extension LiveNewsContentTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleNewsCollectionViewCell", for: indexPath) as? SingleNewsCollectionViewCell else {return UICollectionViewCell()}
        cell.mainContentView.backgroundColor = Thememanager.shared.tabBarTintColor
        cell.mainContentView.layer.shadowColor = Thememanager.shared.mainBgColor.cgColor
        cell.mainContentView.layer.shadowOpacity = 0.5
        cell.mainContentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.mainContentView.layer.shadowRadius = 4
        cell.newsTitleLabel.textColor = Thememanager.shared.mainBgColor
        cell.newsAuthorNameLabel.textColor = Thememanager.shared.mainBgColor
        cell.newsPublishedTimeLabel.textColor = Thememanager.shared.mainBgColor
        if collectionValues.count != 0 {
            cell.mainContentView.hideSkeleton()
            cell.loadValues(apiResponse: collectionValues[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: 420, height: 380)
        } else {
            return CGSize(width: 230, height: 240)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectedNewsViewController") as? SelectedNewsViewController else {return}
        vc.selectedNewsData = collectionValues[indexPath.row]
        parentViewController?.navigationController?.pushViewController(vc, animated: true)
    }
}


