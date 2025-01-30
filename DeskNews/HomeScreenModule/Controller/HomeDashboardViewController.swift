//
//  HomeDashboardViewController.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 30/08/23.
//

import UIKit
import SkeletonView

class HomeDashboardViewController: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var tableViewBgView: UIView!
    @IBOutlet weak var liveNewsList: UITableView!
    @IBOutlet weak var seperatorView: UIView!
    
    var viewModel: DashboardViewModel?
    var responseNews: HeadLinesResponse?
    var apiDataValues: ArticalSet?
    var apiDataCollectionValues = [ArticalSet]()
//    var indicator = UIActivityIndicatorView()
//    var refresher: Bool = false
    var apiHelper: APIHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        setUpColors()
        getNewsApiCall()
    }
    
    deinit {
        viewModel = nil
        apiHelper = nil
    }
}
extension HomeDashboardViewController {
    func setUpUI() {
        viewModel = DashboardViewModel()
        liveNewsList.delegate = self
        liveNewsList.dataSource = self
        liveNewsList.register(UINib(nibName: "NewsOfTheDayFeedTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsOfTheDayFeedTableViewCell")
        liveNewsList.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTableViewCell")
        liveNewsList.register(UINib(nibName: "LiveNewsContentTableViewCell", bundle: nil), forCellReuseIdentifier: "LiveNewsContentTableViewCell")
//        indicator = Utils().setUpLoader(sender: view)
//        let refresher = Utils().addRefreshController(sender: liveNewsList)
//        refresher.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
    }
    func setUpColors() {
        Thememanager.shared.switchTheme()
        self.view.backgroundColor = Thememanager.shared.mainBgColor
        self.liveNewsList.backgroundColor = Thememanager.shared.mainBgColor
        self.tableViewBgView.backgroundColor = Thememanager.shared.mainBgColor
        self.titleLbl.clipsToBounds = true
        self.titleLbl.layer.cornerRadius = 20
        self.titleLbl.textColor = Thememanager.shared.tabBarTintColor
        self.seperatorView.backgroundColor = Thememanager.shared.tabBarTintColor
        self.titleLbl.isSkeletonable = true
        self.liveNewsList.isSkeletonable = true
    }
    func apiCall(country: String, category: String){
        apiHelper = APIHandler()
        apiHelper?.GetNewsForDashboardApiCall(data: APIConstants.generateURL(country: country, category: category, page: "1"), completion: { [weak self] responseData, errorMessagge in
            guard let self else {return}
            if errorMessagge == nil {
                guard let responseData else {return}
                self.responseNews = responseData
                self.seperateDataReloadTable()
                DispatchQueue.main.async {
                    self.titleLbl.hideSkeleton()
                    self.liveNewsList.hideSkeleton()
                }
            } else {
                guard let errorMessagge else {return}
                self.errorAlert(message: errorMessagge)
            }
            
        })
    }
    func getNewsApiCall() {
        tabBarController?.tabBar.isHidden = false
        var countryValue: String = ""
        var categoryValue: String = ""
        if NetworkConnectionHandler().checkReachable() {
//            if refresher {
//            } else {
                self.titleLbl.showAnimatedGradientSkeleton()
//            self.liveNewsList.showAnimatedSkeleton()
            self.liveNewsList.showAnimatedGradientSkeleton()
//                Utils().startLoading(sender: indicator, wholeView: view)
//            }
            if let counrty = UserDefaults.standard.string(forKey: "country") {
                countryValue = counrty
                if let categories = UserDefaults.standard.string(forKey: "categories") {
                    categoryValue = categories
                }
            }else{
                if let categories = UserDefaults.standard.string(forKey: "categories") {
                    categoryValue = categories
                    if let country = UserDefaults.standard.string(forKey: "country") {
                        countryValue = country
                    }
                }
            }
            if categoryValue != "" && countryValue != "" {
//                apiCall(country: countryValue, category: categoryValue)
                
            } else if countryValue == "" && categoryValue != "" {
//                apiCall(country: "in", category: categoryValue)
                
            } else if countryValue == "" && categoryValue != "" {
//                apiCall(country: countryValue, category: "general")
            } else {
//                apiCall(country: "in", category: "general")
            }
        } else {
            internetFailure(childTableView: liveNewsList)
        }
    }
    @objc func refresh() {
//        refresher = true
        getNewsApiCall()
    }
    func seperateDataReloadTable() {
        let collectionFilter = responseNews?.articles?.filter{$0.title != nil && $0.title != ""}
        apiDataValues = collectionFilter?.first
        let filter = collectionFilter?.filter{$0.title != apiDataValues?.title}
        var unique = [ArticalSet]()
        for arrValue in filter ?? [ArticalSet]() {
            if !unique.contains(where: { $0.title == arrValue.title }) {
                unique.append(arrValue)
            }
        }
        apiDataCollectionValues = unique
        DispatchQueue.main.async {
//            Utils().endRefreshController(sender: self.liveNewsList ?? UITableView())
//            Utils().endLoading(sender: self.indicator, wholeView: self.view ?? UIView())
            self.liveNewsList.reloadData()
        }
    }
}
extension HomeDashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel?.cellForTableView(baseTableView: tableView, signleArticleSet: apiDataValues ?? ArticalSet(), indexPathValue: indexPath, newsCollections:apiDataCollectionValues) ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel?.heightForTableViewRow(indexpath: indexPath.row) ?? 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectedNewsViewController") as? SelectedNewsViewController else {return}
            vc.selectedNewsData = apiDataValues ?? ArticalSet()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}
