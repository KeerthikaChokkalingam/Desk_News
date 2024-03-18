//
//  SearchTabViewController.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 31/08/23.
//

import UIKit

class SearchTabViewController: UIViewController {
    
    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var scrollBgColor: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var tableBgView: UIView!
    @IBOutlet weak var searchListTableView: UITableView!
    @IBOutlet weak var categoryCollectionView: UIScrollView!
    @IBOutlet weak var lineViewTrailingAnchor: NSLayoutConstraint!
    @IBOutlet weak var highLightedView: UIView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var highLightedViewWidth: NSLayoutConstraint!
    @IBOutlet weak var highLightedViewLeadingAnchor: NSLayoutConstraint!
    
    var topCategories = AppConstant.categories
    var labelStartingPoint: CGFloat = 0
    var selectedLabel: UILabel?
    var responseNews: HeadLinesResponse?
    var wholeResponse = [ArticalSet]() // original news value
    var searchNewsResponse = [ArticalSet]() // filter value based on search
    var newText = String()
    var selectedCategory = "General"
    var indicator = UIActivityIndicatorView()
    var apiHelper: APIHandler?
    var viewModel: SearchTabViewModel?
    var refresher: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setUpSearchTextField()
    }
    override func viewWillAppear(_ animated: Bool) {
        selectedLabel = nil
        setUpDynamicLabel()
        setUpUiColor()
        apiCall()
    }
    
    deinit {
        viewModel = nil
        apiHelper = nil
    }
}
extension SearchTabViewController {
    func apiCall() {
        tabBarController?.tabBar.isHidden = false
        var countryValue: String = ""
        if NetworkConnectionHandler().checkReachable() {
            if refresher {
            } else {
                Utils().startLoading(sender: indicator, wholeView: view)
            }
            if let counrty = UserDefaults.standard.string(forKey: "country") {
                countryValue = counrty
            }
            if countryValue != ""  {
                apiCall(pageValue: "1", country: countryValue, category: selectedCategory)
                
            } else if countryValue == ""  {
                apiCall(pageValue: "1", country: "in", category: selectedCategory)
                
            }
        } else {
            internetFailure(childTableView: searchListTableView)
        }
    }
    func setupUI() {
        searchListTableView.register(UINib(nibName: "NewsFeedTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsFeedTableViewCell")
        let refresher = Utils().addRefreshController(sender: searchListTableView)
        refresher.addTarget(self, action: #selector(refresh), for: .valueChanged)
        indicator = Utils().setUpLoader(sender: view)
        lineView.layer.cornerRadius = 2
        highLightedView.layer.cornerRadius = 2
        categoryCollectionView.delegate = self
        
    }
    func setUpUiColor() {
        Thememanager.shared.switchTheme()
        self.view.backgroundColor = Thememanager.shared.mainBgColor
        self.tableBgView.backgroundColor = Thememanager.shared.mainBgColor
        self.searchView.backgroundColor = Thememanager.shared.mainBgColor
        self.titleView.backgroundColor = Thememanager.shared.mainBgColor
        self.lineView.backgroundColor = Thememanager.shared.tabBarTintColor
        self.titleLbl.textColor = Thememanager.shared.tabBarTintColor
        self.seperatorView.backgroundColor =  Thememanager.shared.tabBarTintColor
        self.highLightedView.backgroundColor = Thememanager.shared.tabBarTintColor
    }
    func setUpSearchTextField() {
        searchTextField.delegate = self
        searchTextField.layer.cornerRadius = 20
        searchTextField.placeholder = "Search"
        searchTextField.setPlaceholderTextColor(UIColor.separator) // Set your desired color
        searchTextField.leftViewMode = .always
        let searchView = UIView(frame: CGRect(x: 15, y: 15, width: 60, height: 30))
        let searchImageView = UIImageView(frame: CGRect(x: 15, y: 4, width: 25, height: 22))
        searchImageView.image = UIImage(systemName: "magnifyingglass")
        searchImageView.tintColor = UIColor.separator
        searchView.addSubview(searchImageView)
        searchTextField.leftView = searchView
        searchTextField.font = UIFont.systemFont(ofSize: 15)
    }
    func apiCall(pageValue: String, country: String, category: String){
        apiHelper = APIHandler()
        apiHelper?.GetNewsForDashboardApiCall(data: APIConstants.generateURL(country: country, category: category, page: pageValue), completion: { [weak self] responseData, errorMessagge in
            guard let self else {return}
            if errorMessagge == nil {
                guard let responseData else {return}
                self.responseNews =  responseData
                self.wholeResponse = (self.wholeResponse ) + (self.responseNews?.articles ?? [ArticalSet]())
                self.searchNewsResponse = self.wholeResponse
                DispatchQueue.main.async {
                    if (self.refresher) {
                        Utils().endRefreshController(sender: self.searchListTableView ?? UITableView())
                    }
                    Utils().endLoading(sender: self.indicator , wholeView: self.view ?? UIView())
                    self.searchListTableView.reloadData()
                }
            } else {
                guard let errorMessagge else {return}
                self.errorAlert(message: errorMessagge)
            }
        })
    }
    @objc func refresh() {
        refresher = true
        var countryValue: String = ""
        if let counrty = UserDefaults.standard.string(forKey: "country") {
            countryValue = counrty
        }
        if countryValue != ""  {
            apiCall(pageValue: "1", country: countryValue, category: selectedCategory)
            
        } else if countryValue == ""  {
            apiCall(pageValue: "1", country: "in", category: selectedCategory)
            
        }
    }
}

extension SearchTabViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        return true
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel = SearchTabViewModel()
        let isReload = viewModel?.tfEndEditing(searchKey: newText, originalValue: wholeResponse, filterVlaue: searchNewsResponse, baseView: searchListTableView)
        self.searchNewsResponse = (self.viewModel?.filteredValue)!
        DispatchQueue.main.async {
            self.searchListTableView.reloadData()
        }
    }
}
extension UITextField {
    func setPlaceholderTextColor(_ color: UIColor) {
        guard let placeholder = self.placeholder else { return }
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: color])
    }
}
