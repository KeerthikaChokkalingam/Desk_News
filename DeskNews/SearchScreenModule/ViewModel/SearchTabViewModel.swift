//
//  SearchTabViewModel.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 22/09/23.
//

import Foundation
import UIKit
import CoreImage
import CoreGraphics

class SearchTabViewModel: NSObject {
    
    var filteredValue = [ArticalSet]()
    
    func tfEndEditing(searchKey: String, originalValue: [ArticalSet], filterVlaue: [ArticalSet], baseView: UITableView) -> Bool {
        filteredValue.removeAll()
        var filterVlaue = filterVlaue
        let filter = originalValue.filter{item1 in
            (item1.title!).lowercased().contains(searchKey.lowercased())
            ||
            ((item1.source?.name ?? "").lowercased().contains(searchKey.lowercased()))
        }
        if filter.count > 0 {
            filterVlaue = filter
        } else {
            filterVlaue.removeAll()
        }
        if searchKey == "" {
            filterVlaue = originalValue
        }
        filteredValue = filterVlaue
        
        return true
    }
    func setButtonTextColor(fromImage image: UIImage) -> UIColor  {
        var textColor: UIColor = .black
        let ciImage = CIImage(image: image)
        if let ciImage = ciImage  {
            
            // Create a context for analyzing the image
            let context = CIContext(options: nil)
            
            // Define a region of interest (ROI) if needed, e.g., CGRect(x: 0, y: 0, width: 100, height: 100)
            let roiRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
            
            // Render the image in the ROI
            let renderedImage = context.createCGImage(ciImage, from: roiRect)
            
            // Process the rendered image (e.g., calculate average color, brightness)
            let averageColor = renderedImage?.averageColor ?? .white
            
            // Choose the text color based on the processed color
            textColor = averageColor.isLight ? .black : .white
        }
        return textColor
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
        cell.bgView.backgroundColor = Thememanager.shared.tabBarTintColor
        cell.chanelNameLabel.textColor = Thememanager.shared.mainBgColor
        cell.dateTimeLabel.textColor = Thememanager.shared.mainBgColor
        cell.authorLabel.textColor = Thememanager.shared.mainBgColor
        cell.titleLabel.textColor = Thememanager.shared.mainBgColor
        
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
                    
                    var countryValue: String = ""
                    if let counrty = UserDefaults.standard.string(forKey: "country") {
                        countryValue = counrty
                    }
                    if countryValue != "" {
                        apiCall(pageValue: String(pageCount), country: countryValue, category: selectedCategory)
                        
                    } else if countryValue == "" {
                        apiCall(pageValue: String(pageCount), country: "in", category: selectedCategory)
                        
                    }
                } else {
                    tableView.tableFooterView = nil
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectedNewsViewController") as? SelectedNewsViewController else {return}
        vc.selectedNewsData = searchNewsResponse[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension SearchTabViewController {
    func setUpDynamicLabel() {
        for item in topCategories {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 19)
            let labelSize = (item as NSString).size(withAttributes: [.font: label.font!])
            label.frame = CGRect(x: labelStartingPoint, y: 0, width: labelSize.width, height: 45)
            label.text = item
            label.font = UIFont(name: "Helvetica Nueue", size: 15)
            if item == selectedCategory {
                highLightedViewWidth.constant = labelSize.width
                selectedLabel = label
                Thememanager.shared.switchTheme()
                label.textColor = Thememanager.shared.tabBarTintColor
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
            label.tag = Int(labelStartingPoint)
        }
    }
    
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        searchTextField.text = ""
        if let tappedLabel = sender.view as? UILabel {
            if tappedLabel == selectedLabel {
                // Deselect the label
                tappedLabel.textColor = .gray
                selectedLabel = nil
            } else {
                // Deselect the previously selected label (if any)
                selectedLabel?.textColor = .gray
                // Select the tapped label
                selectedCategory = tappedLabel.text ?? ""
                // Make API call based on category
                Utils().startLoading(sender: indicator, wholeView: view)
                // Remove data from already selected category
                wholeResponse.removeAll()
                searchNewsResponse.removeAll()
                // Reload table view
                searchListTableView.reloadData()
                
                var countryValue: String = ""
                if let counrty = UserDefaults.standard.string(forKey: "country") {
                    countryValue = counrty
                }
                if countryValue != "" {
                    apiCall(pageValue: "1", country: countryValue, category: selectedCategory)
                    
                } else if countryValue == ""  {
                    apiCall(pageValue: "1", country: "in", category: selectedCategory)
                    
                }
                Thememanager.shared.switchTheme()
                tappedLabel.textColor = Thememanager.shared.tabBarTintColor
                highLightedViewWidth.constant = tappedLabel.frame.width
                highLightedViewLeadingAnchor.constant = tappedLabel.frame.origin.x
                selectedLabel = tappedLabel
                // scroll view scrollRectToVisible point change based on Selected label
                if tappedLabel.tag > (Int(self.view.frame.maxX)) {
                    categoryCollectionView.scrollRectToVisible(CGRect(x: (self.view.frame.width - (tappedLabel.frame.width - 43)), y: 0, width: 300, height: 30), animated: true)
                } else if tappedLabel.tag > (Int(self.view.frame.midX)){
                    categoryCollectionView.scrollRectToVisible(CGRect(x: 40, y: 0, width: 300, height: 30), animated: true)
                } else {
                    categoryCollectionView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 300, height: 30), animated: true)
                }
            }
        }
    }
    
}
extension CGImage {
    var averageColor: UIColor {
        guard let pixelData = dataProvider?.data else { return .clear }
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        var totalRed = 0
        var totalGreen = 0
        var totalBlue = 0
        
        for x in 0..<width {
            for y in 0..<height {
                let pixelInfo: Int = ((Int(width) * Int(y)) + Int(x)) * 4
                
                let red = CGFloat(data[pixelInfo])
                let green = CGFloat(data[pixelInfo + 1])
                let blue = CGFloat(data[pixelInfo + 2])
                
                totalRed += Int(red)
                totalGreen += Int(green)
                totalBlue += Int(blue)
            }
        }
        
        let count = width * height
        let red = CGFloat(totalRed) / CGFloat(count)
        let green = CGFloat(totalGreen) / CGFloat(count)
        let blue = CGFloat(totalBlue) / CGFloat(count)
        
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1.0)
    }
}

extension UIColor {
    var isLight: Bool {
        var white: CGFloat = 0.0
        getWhite(&white, alpha: nil)
        return white > 0.5
    }
}
