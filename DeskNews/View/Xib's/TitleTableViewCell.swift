//
//  TitleTableViewCell.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 30/08/23.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    @IBOutlet weak var liveNewsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        liveNewsLabel.textColor = colorManager().tabBarTintColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
