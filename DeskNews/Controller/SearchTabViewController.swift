//
//  SearchTabViewController.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 31/08/23.
//

import UIKit

class SearchTabViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var scrollContentView: UIView!
    
    var topCategories = AppConstant.categories
    var labelStartingPoint: CGFloat = 15
    var selectedLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchTextField()
        setUpDynamicLabel()
    }
    
}

extension SearchTabViewController {
    func setUpSearchTextField() {
        searchTextField.delegate = self
        searchTextField.backgroundColor = UIColor.opaqueSeparator
        searchTextField.layer.cornerRadius = 20
        searchTextField.placeholder = "Search"
        searchTextField.leftViewMode = .always
        let searchView = UIView(frame: CGRect(x: 15, y: 15, width: 40, height: 30))
        let searchImageView = UIImageView(frame: CGRect(x: 15, y: 4, width: 20, height: 20))
        searchImageView.image = UIImage(systemName: "magnifyingglass")
        searchView.addSubview(searchImageView)
        searchTextField.leftView = searchView
    }
    func setUpDynamicLabel() {
        for item in topCategories {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 19)
            let labelSize = (item as NSString).size(withAttributes: [.font: label.font!])
            label.frame = CGRect(x: labelStartingPoint, y: 15, width: labelSize.width, height: 45)
            label.text = item
            if item == "General" {
                selectedLabel = label
            } else {
                label.textColor = .gray
            }
            label.accessibilityIdentifier = item
            label.textAlignment = .center
            label.backgroundColor = .clear
            label.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
            label.addGestureRecognizer(tapGesture)
            scrollContentView.addSubview(label)
            labelStartingPoint += labelSize.width + 20
        }
    }
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        if let tappedLabel = sender.view as? UILabel {
            if tappedLabel == selectedLabel {
                // Deselect the label
                tappedLabel.textColor = .gray
                selectedLabel = nil
            } else {
                // Deselect the previously selected label (if any)
                selectedLabel?.textColor = .gray
                // Select the tapped label
                tappedLabel.textColor = .black
                selectedLabel = tappedLabel
            }
        }
    }
}

extension SearchTabViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
