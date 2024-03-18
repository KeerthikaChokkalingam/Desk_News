//
//  APIHandler.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 25/08/23.
//

import Foundation
import UIKit

class APIHandler {
    var aPIResponseModel: HeadLinesResponse?
    
    func GetNewsForDashboardApiCall(data: String , completion: @escaping (_ responseData: HeadLinesResponse?,_ errorMessagge: String?) -> Void) {
        guard let url = URL(string: data) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error == nil {
                guard let response = response as? HTTPURLResponse else { return }
                if (200...299).contains(response.statusCode) {
                    if let data = data {
                        do {
                            let responseData = try JSONDecoder().decode(HeadLinesResponse.self, from: data)
                            self.aPIResponseModel = responseData
                            completion(responseData, nil)
                        } catch {
                            //                            print("Decode error: \(error)")
                            completion(nil, error.localizedDescription)
                        }
                    } else {
                        //                        print("Data is nil.")
                        guard let error else {return}
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    guard let error else {return}
                    completion(nil, error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
