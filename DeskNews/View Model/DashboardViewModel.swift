//
//  Dashboard View Model.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 23/08/23.
//

import Foundation

class DashboardViewModel {
    
    var aPIResponseModel: HeadLinesResponse?
    
    func GetNewsForDashboardApiCall(data: String , completion: @escaping () -> ()) {
        let _: Void =  URLSession.shared.dataTask(with: NSURL(string: data)! as URL) { data, response, error in
            if let error = error {
                print("Request Error: ", error)
            }
            guard let response = response as? HTTPURLResponse else { return }
            if response.statusCode == 200 {
                if let data = data {
                    do {
                        let responseData = try JSONDecoder().decode(HeadLinesResponse.self, from: data)
                        self.aPIResponseModel = responseData
                        completion()
                    } catch {
                        print("Decode error: \(error)")
                    }
                } else {
                    print("Data is nil.")
                }
            } else {
                print("Error Code: ", response.statusCode)
            }
        }.resume()
    }
}
