//
//  CustomListView.swift
//  DeskNews
//
//  Created by Keerthika on 27/12/23.
//

import UIKit

class CustomListView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var listView: UITableView?
    var listValue: [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupListView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupListView()
    }
    
    private func setupListView() {
        listView = UITableView(frame: self.bounds)
        if let listView = listView {
            listView.delegate = self
            listView.dataSource = self
            listView.backgroundColor = colorManager().mainBgColor
            listView.separatorStyle = .singleLine
            listView.layer.borderWidth = 0.5
            listView.layer.borderColor = colorManager().tabBarTintColor.cgColor
            listView.isScrollEnabled = true
            if #available(iOS 11.0, *) {
                listView.clipsToBounds = true
                listView.layer.cornerRadius = 10
                listView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            }
            self.addSubview(listView)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listValue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        var cellContext = cell.defaultContentConfiguration()
        cell.backgroundColor = colorManager().mainBgColor
        cellContext.text = listValue[indexPath.row]
        cellContext.textProperties.color = colorManager().tabBarTintColor
        cellContext.textProperties.alignment = .natural
        cellContext.textProperties.numberOfLines = 1
        cellContext.textProperties.font = UIFont(name: "Helvetica Neue", size: 14)!
        cell.contentConfiguration = cellContext
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.removeFromSuperview()
    }
}

