//
//  SettingsViewController.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 25/11/23.
//

import UIKit

@objc protocol SettingsScreenDelegate: AnyObject {
    @objc optional func gettingAppMode(appModeValue: String)
}

class SettingsViewController: UIViewController {

    @IBOutlet weak var settingsTableView: UITableView!
    
    var settingsModelClass: SettingsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    deinit {
        settingsModelClass = nil
    }
}

extension SettingsViewController {
    func setUpTableView() {
        settingsModelClass = SettingsModel()
        settingsTableView.register(UINib(nibName: "changeAppearenceTableViewCell", bundle: nil), forCellReuseIdentifier: "changeAppearenceTableViewCell")
        settingsTableView.register(UINib(nibName: "DropDownTableViewCell", bundle: nil), forCellReuseIdentifier: "DropDownTableViewCell")
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsModelClass?.settingsContent.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentData = settingsModelClass?.settingsContent[indexPath.row]
        switch (currentData?["row Count"] as? Int) {
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "changeAppearenceTableViewCell", for: indexPath) as? changeAppearenceTableViewCell else {return UITableViewCell()}
            cell.customDel = self
            cell.selectionStyle = .none
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownTableViewCell", for: indexPath) as? DropDownTableViewCell else {return UITableViewCell()}
            cell.titleLabel.text = "Landing Page Category"
            cell.selectedValue.text = "General"
            cell.selectionStyle = .none
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownTableViewCell", for: indexPath) as? DropDownTableViewCell else {return UITableViewCell()}
            cell.titleLabel.text = "Select Country"
            cell.selectedValue.text = "India"
            cell.selectionStyle = .none
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "changeAppearenceTableViewCell", for: indexPath) as? changeAppearenceTableViewCell else {return UITableViewCell()}
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentData = settingsModelClass?.settingsContent[indexPath.row]
        switch (currentData?["row Count"] as? Int) {
        case 1:
            return 70
        case 2:
            return 70
        case 3:
            return 70
        default:
            return 0
        }
    }
    
}

extension SettingsViewController: SettingsScreenDelegate {
    func gettingAppMode(appModeValue: String) {
        if appModeValue == "light" {
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
        } else {
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
        }
    }
}
