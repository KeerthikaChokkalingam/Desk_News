//
//  APIConstants.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 23/08/23.
//

import Foundation

class APIConstants {
//    public static var sourceUrl: String = "http://api.mediastack.com/v1/news?access_key="
//    public static var accessKey: String = "d68f217b13f73ca17157a361f73f8d42" // get free access_key from https://mediastack.com
//    public static var dashboardApiUrl: String = sourceUrl + accessKey + "&offset=0&count=50&limit=50"
//    public static var requestUrl: String = sourceUrl + accessKey
//
    
    public static var accessKey: String = "5948bdf1620f4371ab70b1d2083d863c"
    public static var sourceUrl: String = "https://newsapi.org/v2/top-headlines?country=in&category=sports&apiKey=" + accessKey
    
}
