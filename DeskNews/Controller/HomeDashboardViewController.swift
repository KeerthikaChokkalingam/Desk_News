//
//  HomeDashboardViewController.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 30/08/23.
//

import UIKit

class HomeDashboardViewController: UIViewController {
    
    @IBOutlet weak var liveNewsList: UITableView!
    
    var viewModel: DashboardViewModel?
    var responseNews: HeadLinesResponse?
    var apiDataValues: ArticalSet?
    var apiDataCollectionValues = [ArticalSet]()
    var indicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        if apiDataValues?.title == nil  {
            getNewsApiCall()
        }
    }
}
extension HomeDashboardViewController {
    func setUpUI() {
        liveNewsList.delegate = self
        liveNewsList.dataSource = self
        liveNewsList.register(UINib(nibName: "NewsOfTheDayFeedTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsOfTheDayFeedTableViewCell")
        liveNewsList.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTableViewCell")
        liveNewsList.register(UINib(nibName: "LiveNewsContentTableViewCell", bundle: nil), forCellReuseIdentifier: "LiveNewsContentTableViewCell")
        indicator = Utils().setUpLoader(sender: view)
        getNewsApiCall()
        let refresher = Utils().addRefreshController(sender: liveNewsList)
        refresher.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    func apiCall(){
        viewModel = DashboardViewModel()
        viewModel?.GetNewsForDashboardApiCall(data: APIConstants.sourceUrl,completion: { [weak self] in
            self?.responseNews = self?.viewModel?.aPIResponseModel
            self?.seperateDataReloadTable()
        })
    }
    func internetFailure() {
        let controller = UIAlertController(title: "No Internet Detected", message: "This app requires an Internet connection", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
            Utils().endRefreshController(sender: self.liveNewsList ?? UITableView())
            controller.dismiss(animated: true)
            }
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
    func pullToRefreshApiCall() {
        if NetworkConnectionHandler().checkReachable() {
            apiCall()
        } else {
            internetFailure()
        }
    }
    func getNewsApiCall() {
        if NetworkConnectionHandler().checkReachable() {
            Utils().startLoading(sender: indicator, wholeView: view)
            apiCall()
        } else {
            internetFailure()
        }
    }
    @objc func refresh() {
        pullToRefreshApiCall()
    }
    func seperateDataReloadTable() {
        let collectionFilter = responseNews?.articles?.filter{$0.urlToImage != nil && $0.urlToImage != ""}
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
            Utils().endRefreshController(sender: self.liveNewsList ?? UITableView())
            Utils().endLoading(sender: self.indicator, wholeView: self.view ?? UIView())
            self.liveNewsList.reloadData()
        }
    }
}
extension HomeDashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0 :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsOfTheDayFeedTableViewCell", for: indexPath) as? NewsOfTheDayFeedTableViewCell else {return UITableViewCell()}
            if apiDataValues?.title != nil {
                cell.updateCell(apiResponse: apiDataValues!)
            }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell", for: indexPath) as? TitleTableViewCell else {return UITableViewCell()}
            if apiDataValues?.title != nil {
                cell.liveNewsLabel.font = UIFont.boldSystemFont(ofSize: 17)
                cell.liveNewsLabel.text = "Live News Around You"
            }
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LiveNewsContentTableViewCell", for: indexPath) as? LiveNewsContentTableViewCell else {return UITableViewCell()}
            if apiDataCollectionValues.count != 0 {
                cell.getValuesFromApiRoadCollections(apiResponse: apiDataCollectionValues)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0 :
            if UIDevice.current.userInterfaceIdiom == .pad {
                return 550
            } else {
                return 355
            }
        case 1:
            if UIDevice.current.userInterfaceIdiom == .pad {
                return 100
            } else {
                return 50
            }
        default:
            if UIDevice.current.userInterfaceIdiom == .pad {
                return 380
            } else {
                return 255
            }
        }
    }
}
