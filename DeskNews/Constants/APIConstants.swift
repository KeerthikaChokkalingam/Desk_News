//
//  APIConstants.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 23/08/23.
//

import Foundation

class APIConstants {
    public static var sourceUrl: String = "http://api.mediastack.com/v1/news?access_key="
    public static var accessKey: String = "d68f217b13f73ca17157a361f73f8d42" // get free access_key from https://mediastack.com
    public static var dashboardApiUrl: String = sourceUrl + accessKey + "&offset=0&count=6&limit=6"
    public static var requestUrl: String = sourceUrl + accessKey
}
