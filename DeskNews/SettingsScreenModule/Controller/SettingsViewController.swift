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
            return 50
        default:
            return 0
        }
    }
    
}

extension SettingsViewController: SettingsScreenDelegate {
    func gettingAppMode(appModeValue: String) {
        print(appModeValue)
    }
}
