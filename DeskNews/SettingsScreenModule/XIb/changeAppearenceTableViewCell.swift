//
//  changeAppearenceTableViewCell.swift
//  DeskNews
//
//  Created by Keerthika on 30/11/23.
//

import UIKit

protocol SettingsScreenDelegate: AnyObject {
    func didSelectThemeSwitch()
}

class changeAppearenceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var appModeSetter: UISwitch!
    
    weak var delegate: SettingsScreenDelegate?

    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 15
        appModeSetter.transform = CGAffineTransformMakeScale(0.90, 0.90);
        if self.traitCollection.userInterfaceStyle == .dark {
            appModeSetter.isOn = true
            print("Dark Mode")
            // Do something for dark mode
        } else {
            appModeSetter.isOn = false
            print("Light Mode")
            // Do something for light mode
        }
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func appModeChanger(_ sender: Any) {
        if delegate != nil {
            delegate?.didSelectThemeSwitch()
        }
    }
}
