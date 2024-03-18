//
//  TitleTableViewCell.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 30/08/23.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var childView: UIView!
    @IBOutlet weak var liveNewsLabel: UILabel!
    
    override func layoutSubviews() {
        self.contentView.backgroundColor = Thememanager.shared.mainBgColor
        liveNewsLabel.textColor = Thememanager.shared.tabBarTintColor
        self.childView.backgroundColor = Thememanager.shared.mainBgColor
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
