//
//  DropDownTableViewCell.swift
//  DeskNews
//
//  Created by Keerthika on 27/12/23.
//

import UIKit

class DropDownTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var dropDownButton: UIButton!
    @IBOutlet weak var selectedValue: UILabel!
    @IBOutlet weak var selectionView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 15
        selectionView.layer.cornerRadius = 8
        selectionView.layer.borderColor = (UIColor().hexStringToUIColor(hex: "#003b4a")).cgColor
        selectionView.layer.borderWidth = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func addMenuView(_ sender: UIGestureRecognizer) {
        guard let viewBase = sender.view else {
            return
        }

        let popUpView = CustomListView(frame: CGRect(x: selectionView.frame.origin.x + 1, y: selectionView.frame.origin.y + selectionView.frame.size.height, width: selectionView.frame.size.width, height: 150))

        if sender.view?.tag == 20 {
            popUpView.listValue = AppConstant.categories
        } else {
            popUpView.listValue = AppConstant.countryList
        }
        popUpView.tag = 50
        popUpView.listView?.reloadData()
        self.addSubview(popUpView)
    }
    
}
