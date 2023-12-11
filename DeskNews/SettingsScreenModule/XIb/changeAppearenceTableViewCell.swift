//
//  changeAppearenceTableViewCell.swift
//  DeskNews
//
//  Created by Keerthika on 30/11/23.
//

import UIKit

class changeAppearenceTableViewCell: UITableViewCell {
    
    weak var customDel: SettingsScreenDelegate!

    @IBOutlet weak var appModeSetter: UISegmentedControl!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if self.traitCollection.userInterfaceStyle == .dark {
            appModeSetter.selectedSegmentIndex = 1
            print("Dark Mode")
            // Do something for dark mode
        } else {
            appModeSetter.selectedSegmentIndex = 0
            print("Light Mode")
            // Do something for light mode
        }
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func appModeChanger(_ sender: UISegmentedControl) {
        print("sender inde: \(sender.selectedSegmentIndex)")
        if sender.selectedSegmentIndex == 0 {
            if customDel != nil {
                customDel.gettingAppMode?(appModeValue: "light")
            }
        } else {
            if customDel != nil {
                customDel.gettingAppMode?(appModeValue: "dark")
            }
        }
    }
}
