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
        let dismissDropDown = UITapGestureRecognizer(target: self, action: #selector(dismissDropDown))
        self.view.addGestureRecognizer(dismissDropDown)
        setUpTableView()
    }
    @objc func dismissDropDown(_ sender: UIGestureRecognizer){
        if let list = sender.view?.viewWithTag(50) {
            list.removeFromSuperview()
        }
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
        return 3
//        return settingsModelClass?.settingsContent.count ?? 0
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
                let tapGesture = UITapGestureRecognizer(target: cell, action: #selector(cell.addMenuView(_:)))
                cell.selectionView.tag = 20
                tapGesture.view?.tag = cell.selectionView.tag
                cell.selectionView.addGestureRecognizer(tapGesture)
                return cell
            case 3:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownTableViewCell", for: indexPath) as? DropDownTableViewCell else {return UITableViewCell()}
                cell.titleLabel.text = "Select Country"
                cell.selectedValue.text = "India"
                cell.selectionStyle = .none
                let tapGesture = UITapGestureRecognizer(target: cell, action: #selector((cell.addMenuView(_:))))
                cell.selectionView.tag = 30
                tapGesture.view?.tag = cell.selectionView.tag
                cell.selectionView.addGestureRecognizer(tapGesture)
                return cell
            default:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "changeAppearenceTableViewCell", for: indexPath) as? changeAppearenceTableViewCell else {return UITableViewCell()}
                return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 70
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
