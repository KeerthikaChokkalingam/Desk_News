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
    var responseNews: PaginationStruct?
    var apiDataValues = APIDataStruct()
    var apiDataCollectionValues = [APIDataStruct]()
    var indicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
}
extension HomeDashboardViewController {
    func setUpUI() {
        liveNewsList.delegate = self
        liveNewsList.dataSource = self
        liveNewsList.register(UINib(nibName: "NewsOfTheDayFeedTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsOfTheDayFeedTableViewCell")
        liveNewsList.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTableViewCell")
        liveNewsList.register(UINib(nibName: "LiveNewsContentTableViewCell", bundle: nil), forCellReuseIdentifier: "LiveNewsContentTableViewCell")
        let refresher = Utils().addRefreshController(sender: liveNewsList)
        refresher.addTarget(self, action: #selector(refresh), for: .valueChanged)
        indicator = Utils().setUpLoader(sender: view)
        getNewsApiCall()
    }
    func getNewsApiCall() {
        if NetworkConnectionHandler().checkReachable() {
            Utils().startLoading(sender: indicator, wholeView: view)
            viewModel = DashboardViewModel()
            viewModel?.GetNewsForDashboardApiCall(data: APIConstants.dashboardApiUrl,completion: { [weak self] in
                self?.responseNews = self?.viewModel?.aPIResponseModel
                self?.seperateDataReloadTable()
                DispatchQueue.main.async {
                    Utils().endLoading(sender: self!.indicator, wholeView: self?.view ?? UIView())
                }
            })
        } else {
            let controller = UIAlertController(title: "No Internet Detected", message: "This app requires an Internet connection", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                self.indicator.isHidden = true
                self.indicator.hidesWhenStopped = true
                self.indicator.stopAnimating()
                controller.dismiss(animated: true)
                }
            controller.addAction(okAction)
            present(controller, animated: true, completion: nil)
        }
    }
    @objc func refresh() {
        getNewsApiCall()
    }
    func seperateDataReloadTable() {
        apiDataValues = responseNews?.data[0] ?? apiDataValues
        apiDataCollectionValues = responseNews?.data ?? apiDataCollectionValues
        DispatchQueue.main.async {
            self.liveNewsList.reloadData()
            Utils().endRefreshController(sender: self.liveNewsList)
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
            if apiDataValues.title != nil {
                cell.updateCell(apiResponse: apiDataValues)
            }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell", for: indexPath) as? TitleTableViewCell else {return UITableViewCell()}
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
            return 360
        case 1:
            return 55
        default:
            return 250
        }
    }
}
