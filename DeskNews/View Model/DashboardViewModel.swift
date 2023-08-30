//
//  Dashboard View Model.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 23/08/23.
//

import Foundation

class DashboardViewModel {
    
    var aPIResponseModel: PaginationStruct?
    
    func GetNewsForDashboardApiCall(data: String , completion: @escaping () -> ()) {
        let _: Void =  URLSession.shared.dataTask(with: NSURL(string: data)! as URL) { data, response, error in
            if let error = error {
                print("Request Error: ", error)
            }
            guard let response = response as? HTTPURLResponse else { return }
            if response.statusCode == 200 {
                if let data = data {
                     let decoder = JSONDecoder()
                    let gettedNews = try! decoder.decode(PaginationStruct.self, from: data)
                    self.aPIResponseModel = gettedNews
                    completion()
                } else {
                    
                }
            } else {
                print("Error Code: ", response.statusCode)
            }
        }.resume()
    }
}
