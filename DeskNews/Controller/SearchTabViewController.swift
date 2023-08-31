//
//  SearchTabViewController.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 31/08/23.
//

import UIKit

class SearchTabViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchTextField()
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
}

extension SearchTabViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
