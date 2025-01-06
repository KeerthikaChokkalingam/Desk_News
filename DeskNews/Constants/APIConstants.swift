//
//  APIConstants.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 23/08/23.
//

import Foundation

class APIConstants {
    // news api url -> https://gnews.io/docs/v4#introduction
//    public static var accessKey: String = "5948bdf1620f4371ab70b1d2083d863c"
//    public static var baseURL: String = "https://newsapi.org/v2/top-headlines?"
    public static var accessKey: String = "cac1e51b9b2db139478ea0294104599a"
    public static var baseURL: String = "https://gnews.io/api/v4/search?q=example&lang=en&country=us&max=10&apikey="
    
    static func generateURL(country: String, category: String, page: String) -> String {
//        let dynamicURL = "\(baseURL)country=\(country)&page=\(page)&category=\(category)&apiKey=\(accessKey)"
        let dynamicURL = "\(baseURL)\(accessKey)"
        return dynamicURL
    }
    
}
