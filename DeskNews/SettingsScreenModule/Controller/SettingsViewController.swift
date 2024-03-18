//
//  SettingsViewController.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 25/11/23.
//

import UIKit



class SettingsViewController: UIViewController {
    
    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var settingsTableView: UITableView!
    
    var settingsModelClass: SettingsModel?
    
    var isCategorySelected: Bool = false
    var isCountrySelected: Bool = false
    
    var selectedCategoryValue: String = ""
    var selectedCountryValue: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dismissDropDown = UITapGestureRecognizer(target: self, action: #selector(dismissDropDown))
        self.view.addGestureRecognizer(dismissDropDown)
        setUpTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        setUpColors()
    }
    @objc func dismissDropDown(_ sender: UIGestureRecognizer){
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {
            return
        }
        
        // Check if a custom view with the specified tag already exists
        if let existingCustomView = window.viewWithTag(12345) {
            existingCustomView.removeFromSuperview()
            return
        }
    }
    
    
    deinit {
        settingsModelClass = nil
    }
}

extension SettingsViewController {
    func setUpTableView() {
        settingsModelClass = SettingsModel()
        settingsTableView.isScrollEnabled = false
        settingsTableView.register(UINib(nibName: "changeAppearenceTableViewCell", bundle: nil), forCellReuseIdentifier: "changeAppearenceTableViewCell")
        settingsTableView.register(UINib(nibName: "DropDownTableViewCell", bundle: nil), forCellReuseIdentifier: "DropDownTableViewCell")
    }
    @objc func cancelBtnAction() {
        if let alertView = self.view.viewWithTag(777777) {
            alertView.removeFromSuperview()
        }
    }
    @objc func changeCategory(_ sender: UIButton) {
        if let alertView = self.view.viewWithTag(777777) {
            alertView.removeFromSuperview()
        }
        if let tabBarController = self.tabBarController {
            tabBarController.selectedIndex = 0
        }
        
    }
    @objc func changeCountry(_ sender: UIButton) {
        if let alertView = self.view.viewWithTag(777777) {
            alertView.removeFromSuperview()
        }
        if let tabBarController = self.tabBarController {
            tabBarController.selectedIndex = 0
        }
    }
    func setUpColors() {
        Thememanager.shared.switchTheme()
        self.titleLabel.textColor = Thememanager.shared.tabBarTintColor
        self.titleView.backgroundColor = Thememanager.shared.mainBgColor
        self.view.backgroundColor = Thememanager.shared.mainBgColor
        self.settingsTableView.backgroundColor = Thememanager.shared.mainBgColor
        self.seperatorView.backgroundColor =  Thememanager.shared.tabBarTintColor
        self.settingsTableView.reloadData()
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentData = settingsModelClass?.settingsContent[indexPath.row]
        switch (currentData?["row Count"] as? Int) {
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "changeAppearenceTableViewCell", for: indexPath) as? changeAppearenceTableViewCell else {return UITableViewCell()}
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownTableViewCell", for: indexPath) as? DropDownTableViewCell else {return UITableViewCell()}
            cell.titleLabel.text = "Landing Page Category"
            cell.selectionView.tag = indexPath.row
            cell.selectedValue.text = "General"
            if selectedCategoryValue != "" {
                cell.selectedValue.text = selectedCategoryValue
            }
            if isCategorySelected == true {
                cell.selectedValue.text = selectedCategoryValue
            }
            if let retrievedString = UserDefaults.standard.string(forKey: "categories") {
                cell.selectedValue.text = retrievedString
            }
            cell.selectionStyle = .none
            cell.options = AppConstant.categories
            cell.dropdownDelegate = self
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownTableViewCell", for: indexPath) as? DropDownTableViewCell else {return UITableViewCell()}
            cell.titleLabel.text = "Select Country"
            cell.selectionView.tag = indexPath.row
            cell.selectedValue.text = "India"
            if selectedCountryValue != "" {
                cell.selectedValue.text = selectedCountryValue
            }
            if isCountrySelected == true {
                cell.selectedValue.text = selectedCountryValue
            }
            if let retrievedString = UserDefaults.standard.string(forKey: "country") {
                cell.selectedValue.text = getCountryName(countryCode: retrievedString)
            }
            cell.selectionStyle = .none
            cell.options = AppConstant.countryList
            cell.dropdownDelegate = self
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "changeAppearenceTableViewCell", for: indexPath) as? changeAppearenceTableViewCell else {return UITableViewCell()}
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == 2 {
            return true
        } else {
            return false
        }
    }
}

extension SettingsViewController: SettingsScreenDelegate {
    func didSelectThemeSwitch() {
        Thememanager.shared.switchTheme()
        
        if let tabBarController = self.tabBarController {
            tabBarController.selectedIndex = 0
        }
    }
}

extension SettingsViewController: CustomDropdownDelegate {
    func didSelectOption(_ option: String) {
        if AppConstant.categories.contains(option) {
            selectedCategoryValue = option
            isCategorySelected = true
            isCountrySelected = false
            let customView = AlertView(frame: CGRect(x: self.view.frame.midX - 175, y: self.view.frame.midY - 65, width: 350, height: 130))
            customView.backgroundColor = Thememanager.shared.mainBgColor
            customView.layer.borderWidth = 1
            customView.layer.borderColor = Thememanager.shared.tabBarTintColor.cgColor
            customView.tag = 777777
            customView.fromCtegory = true
            customView.layer.cornerRadius = 15
            customView.reloadView()
            customView.cancelBtn.addTarget(self, action: #selector(cancelBtnAction), for: .touchUpInside)
            customView.okBtn.addTarget(self, action: #selector(changeCategory(_:)), for: .touchUpInside)
            self.view.addSubview(customView)
            UserDefaults.standard.set(option, forKey: "categories")
            
        } else {
            selectedCountryValue = option
            isCategorySelected = false
            isCountrySelected = true
            let customView = AlertView(frame: CGRect(x: self.view.frame.midX - 175, y: self.view.frame.midY - 65, width: 350, height: 130))
            customView.backgroundColor = Thememanager.shared.mainBgColor
            customView.tag = 777777
            customView.fromCtegory = false
            customView.layer.borderWidth = 1
            customView.layer.borderColor = Thememanager.shared.tabBarTintColor.cgColor
            customView.layer.cornerRadius = 15
            customView.reloadView()
            customView.cancelBtn.addTarget(self, action: #selector(cancelBtnAction), for: .touchUpInside)
            customView.okBtn.addTarget(self, action: #selector(changeCountry(_:)), for: .touchUpInside)
            self.view.addSubview(customView)
            UserDefaults.standard.set(getCountryCode(countryName: option), forKey: "country")
            
            
        }
        settingsTableView.reloadData()
    }
    
}

