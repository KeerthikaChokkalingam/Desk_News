//
//  LiveNewsContentTableViewCell.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 30/08/23.
//

import UIKit

class LiveNewsContentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var singleNewsListCollections: UICollectionView!
    
    var collectionValues = [APIDataStruct]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
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
        layout.minimumInteritemSpacing = 10
        singleNewsListCollections.collectionViewLayout = layout
        singleNewsListCollections.register(UINib(nibName: "SingleNewsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SingleNewsCollectionViewCell")
    }
    func getValuesFromApiRoadCollections(apiResponse: [APIDataStruct]) {
        collectionValues = apiResponse
        DispatchQueue.main.async {
            self.singleNewsListCollections.reloadData()
        }
    }
}

extension LiveNewsContentTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionValues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleNewsCollectionViewCell", for: indexPath) as? SingleNewsCollectionViewCell else {return UICollectionViewCell()}
        if collectionValues.count != 0 {
            cell.loadValues(apiResponse: collectionValues[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 210, height: 240)
    }
    
}
