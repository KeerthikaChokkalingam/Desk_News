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
    
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 15
        appModeSetter.transform = CGAffineTransformMakeScale(0.90, 0.90);
        
        if let retrievedString = UserDefaults.standard.string(forKey: "appMode") {
            if retrievedString == "LightMode" {
                appModeSetter.isOn = false
                appModeSetter.onTintColor = UIColor().hexStringToUIColor(hex: "#C8FFE0")
                // Do something for dark mode
            } else {
                appModeSetter.isOn = true
                appModeSetter.onTintColor = UIColor().hexStringToUIColor(hex: "#003b4a")
                // Do something for light mode
            }
        } else {
            appModeSetter.isOn = false
            appModeSetter.onTintColor = UIColor().hexStringToUIColor(hex: "#C8FFE0")
        }
    }
    override func layoutSubviews() {
        Thememanager.shared.switchTheme()
        self.contentView.backgroundColor = Thememanager.shared.mainBgColor
        self.bgView.backgroundColor = Thememanager.shared.tabBarTintColor
        self.lbl.textColor = Thememanager.shared.mainBgColor
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func appModeChanger(_ sender: UISwitch) {
        if delegate != nil {
            if sender.isOn {
                UserDefaults.standard.set("DarkMode", forKey: "appMode")
                sender.onTintColor = UIColor().hexStringToUIColor(hex: "#003b4a")
            } else{
                UserDefaults.standard.set("LightMode", forKey: "appMode")
                sender.onTintColor = UIColor().hexStringToUIColor(hex: "#C8FFE0")
            }
            delegate?.didSelectThemeSwitch()
        }
    }
}
