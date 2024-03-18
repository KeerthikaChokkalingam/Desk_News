//
//  CustomDropdownView.swift
//  DeskNews
//
//  Created by Keerthika on 10/03/24.
//

import UIKit

protocol CustomDropdownDelegate: AnyObject {
    func didSelectOption(_ option: String)
}

class CustomDropdownView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: CustomDropdownDelegate?
    private var options: [String] = []
    private var tableView: UITableView?
    
    init(frame: CGRect, options: [String]) {
        super.init(frame: frame)
        self.options = options
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        // Customize your dropdown UI
        self.backgroundColor = Thememanager.shared.mainBgColor
        tableView = UITableView(frame: bounds, style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.backgroundColor = Thememanager.shared.mainBgColor
        self.layer.borderColor = Thememanager.shared.tabBarTintColor.cgColor
        self.layer.borderWidth = 1
        addSubview(tableView ?? UITableView())
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = options[indexPath.row]
        cell.textLabel?.textColor = Thememanager.shared.tabBarTintColor
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        cell.backgroundColor = Thememanager.shared.mainBgColor
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectOption(options[indexPath.row])
        self.removeFromSuperview()
    }
}
