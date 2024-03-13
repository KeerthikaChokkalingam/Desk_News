//
//  APIConstants.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 23/08/23.
//

import Foundation

class APIConstants {
    public static var accessKey: String = "5948bdf1620f4371ab70b1d2083d863c"
    public static var baseURL: String = "https://newsapi.org/v2/top-headlines?"
    
    static func generateURL(country: String, category: String, page: String) -> String {
        let dynamicURL = "\(baseURL)country=\(country)&page=\(page)&category=\(category)&apiKey=\(accessKey)"
        print(dynamicURL)
        return dynamicURL
    }
    
}
