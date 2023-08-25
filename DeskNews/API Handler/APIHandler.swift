//
//  APIHandler.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 25/08/23.
//

import Foundation
import UIKit

class APIHandler {
    
    
    func GetNewsApiCall() {
        let _: Void =  URLSession.shared.dataTask(with: NSURL(string: APIConstants.requestUrl)! as URL) { data, response, error in
            if let error = error {
                print("Request Error: ", error)
            }
            guard let response = response as? HTTPURLResponse else { return }
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        print(String(decoding: data, as: UTF8.self))
                        let decodedUsers = try JSONDecoder().decode(PaginationStruct.self, from: data)
                        
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            } else {
                print("Response Error: ", error as Any)
            }
        }.resume()
    }
}


