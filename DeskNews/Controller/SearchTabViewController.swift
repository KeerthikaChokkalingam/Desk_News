//
//  SearchTabViewController.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 31/08/23.
//

import UIKit

class SearchTabViewController: UIViewController {
    
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
    var viewModel: DashboardViewModel?
    var responseNews: HeadLinesResponse?
    var wholeResponse = [ArticalSet]() // original news value
    var searchNewsResponse = [ArticalSet]() // filter value based on search
    var newText = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchTextField()
        setUpDynamicLabel()
    }
    override func viewWillAppear(_ animated: Bool) {
        if NetworkConnectionHandler().checkReachable() {
            apiCall(pageValue: "1")
        } else {
            internetFailure()
        }
    }
    
}

extension SearchTabViewController {
    
    func setUpSearchTextField() {
        searchListTableView.delegate = self
        searchListTableView.dataSource = self
        searchListTableView.register(UINib(nibName: "NewsFeedTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsFeedTableViewCell")
        searchTextField.delegate = self
        searchTextField.layer.cornerRadius = 20
        searchTextField.placeholder = "Search"
        searchTextField.leftViewMode = .always
        let searchView = UIView(frame: CGRect(x: 15, y: 15, width: 60, height: 30))
        let searchImageView = UIImageView(frame: CGRect(x: 15, y: 4, width: 25, height: 22))
        searchImageView.image = UIImage(systemName: "magnifyingglass")
        searchImageView.tintColor = UIColor.separator
        searchView.addSubview(searchImageView)
        searchTextField.leftView = searchView
        
        searchTextField.rightViewMode = .always
        let filterView = UIView(frame: CGRect(x: 15, y: 15, width: 60, height: 30))
        let filterImageView = UIImageView(frame: CGRect(x: 15, y: 4, width: 22, height: 22))
        filterImageView.image = UIImage(named: "filter")
        filterImageView.tintColor = UIColor.separator
        filterView.addSubview(filterImageView)
        searchTextField.rightView = filterView
        
        lineView.layer.cornerRadius = 2
        searchTextField.font = UIFont.systemFont(ofSize: 15)
        highLightedView.layer.cornerRadius = 2
        categoryCollectionView.delegate = self
    }
    
    func setUpDynamicLabel() {
        for item in topCategories {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 19)
            let labelSize = (item as NSString).size(withAttributes: [.font: label.font!])
            label.frame = CGRect(x: labelStartingPoint, y: 0, width: labelSize.width, height: 45)
            label.text = item
            label.font = UIFont(name: "Helvetica Nueue", size: 15)
            label.tag = Int(labelStartingPoint) + Int(labelSize.width)
            print("label.tag:\(label.tag)")
            if item == "General" {
                highLightedViewWidth.constant = labelSize.width
                selectedLabel = label
            } else {
                label.textColor = .gray
            }
            label.accessibilityIdentifier = item
            label.textAlignment = .left
            label.backgroundColor = .clear
            label.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
            label.addGestureRecognizer(tapGesture)
            scrollContentView.addSubview(label)
            labelStartingPoint += labelSize.width + 23
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
                if self.traitCollection.userInterfaceStyle == .dark {
                    tappedLabel.textColor = .white
                } else {
                    tappedLabel.textColor = .black
                }
                tappedLabel.textColor = highLightedView.backgroundColor
                highLightedViewWidth.constant = tappedLabel.frame.width
                highLightedViewLeadingAnchor.constant = tappedLabel.frame.origin.x
                selectedLabel = tappedLabel
                if tappedLabel.tag > (Int(self.view.frame.width) - 20) {
                    categoryCollectionView.setContentOffset(CGPoint(x: (self.view.frame.width - (tappedLabel.frame.width + 25)), y: 0), animated: true)
                }
            }
        }
    }
    
    func apiCall(pageValue: String){
        viewModel = DashboardViewModel()
        viewModel?.GetNewsForDashboardApiCall(data: "https://newsapi.org/v2/top-headlines?country=in&page=" + pageValue + "&category=general&apiKey=" + APIConstants.accessKey ,completion: { [weak self] in
            self?.responseNews =  (self?.viewModel?.aPIResponseModel)
            self?.wholeResponse = (self?.wholeResponse ?? [ArticalSet]()) + (self?.responseNews?.articles ?? [ArticalSet]())
            self?.searchNewsResponse = self?.wholeResponse ?? [ArticalSet]()
            DispatchQueue.main.async {
                self?.searchListTableView.reloadData()
            }
        })
    }
    func internetFailure() {
        let controller = UIAlertController(title: "No Internet Detected", message: "This app requires an Internet connection", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            Utils().endRefreshController(sender: self.searchListTableView ?? UITableView())
            controller.dismiss(animated: true)
        }
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
}

extension SearchTabViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        newText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        return true
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        let filter = wholeResponse.filter{item1 in
            (item1.title!).lowercased().contains(newText.lowercased())
            ||
            ((item1.source?.name ?? "").lowercased().contains(newText.lowercased()))
        }
        if filter.count > 0 {
            searchNewsResponse = filter
        } else {
            searchNewsResponse.removeAll()
        }
        if newText == "" {
            searchNewsResponse = wholeResponse
        }
        searchListTableView.reloadData()
    }
}

extension SearchTabViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Check if the scroll view's contentOffset.x is close to the right end of the contentSize.
        let scrollViewWidth = scrollView.frame.size.width
        let contentWidth = scrollView.contentSize.width
        let offsetX = scrollView.contentOffset.x
        
        // Adjust the threshold value as needed
        let threshold: CGFloat = 10.0
        
        if offsetX > contentWidth - scrollViewWidth - threshold {
            print("reached")
            // The scroll view has reached the right end
            // You can perform your desired action here
            lineViewTrailingAnchor.constant = -25
        } else {
            lineViewTrailingAnchor.constant = 0
        }
    }
}

extension SearchTabViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchNewsResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsFeedTableViewCell", for: indexPath) as? NewsFeedTableViewCell else {return UITableViewCell()}
        if (searchNewsResponse.count) > 0 {
            let currentData = searchNewsResponse[indexPath.row]
            cell.applyServerResult(values: currentData)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if newText == "" {
            if indexPath.row == ((wholeResponse.count) - 1) {
                if (responseNews?.totalResults ?? 0 ) > (wholeResponse.count) {
                    Utils().lazyLoaderShow(sender: tableView)
                    let page = (wholeResponse.count / 2)
                    let pageCount = (page / 10) + 1
                    apiCall(pageValue: String(pageCount))
                    print("wholeResponse:\(wholeResponse)")
                } else {
                    tableView.tableFooterView = nil
                }
            }
        }
    }
}
