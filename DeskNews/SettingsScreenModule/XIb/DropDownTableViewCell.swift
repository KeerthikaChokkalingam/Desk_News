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
    
    var showCategories: Bool = false
    var showCountryList: Bool = false
    
    var options: [String] = []
    weak var dropdownDelegate: CustomDropdownDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 15
        selectionView.layer.cornerRadius = 8
        selectionView.layer.borderColor = (UIColor().hexStringToUIColor(hex: "#003b4a")).cgColor
        selectionView.layer.borderWidth = 0.5
        selectionView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDropdownTap))
        selectionView.addGestureRecognizer(tapGesture)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func layoutSubviews() {
        Thememanager.shared.switchTheme()
        self.contentView.backgroundColor = Thememanager.shared.mainBgColor
        self.bgView.backgroundColor = Thememanager.shared.tabBarTintColor
        self.titleLabel.textColor = Thememanager.shared.mainBgColor
        self.selectionView.backgroundColor = Thememanager.shared.mainBgColor
        self.selectedValue.textColor = Thememanager.shared.tabBarTintColor
        self.dropDownButton.tintColor = Thememanager.shared.tabBarTintColor
    }
    @objc private func handleDropdownTap() {
        
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {
            return
        }
        if let tableView = self.superview as? UITableView {
            let frameInSuperview = tableView.convert(selectionView.frame, from: self)
            let customView = CustomDropdownView(frame: CGRect(x: frameInSuperview.minX + 15, y: frameInSuperview.maxY + 118, width: frameInSuperview.width, height: 230), options: options)
            customView.backgroundColor = UIColor.blue
            customView.tag = 12345
            customView.delegate = dropdownDelegate
            window.addSubview(customView)
        }
        
    }
}
