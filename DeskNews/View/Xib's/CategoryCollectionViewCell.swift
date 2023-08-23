//
//  CategoryCollectionViewCell.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 23/08/23.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    func prepareCell(selectedCategory: String) {
        categoryLabel.text = selectedCategory
    }
}
