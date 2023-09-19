//
//  APIConstants.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 23/08/23.
//

import Foundation

class APIConstants {
    public static var accessKey: String = "5948bdf1620f4371ab70b1d2083d863c"
    public static var pageValue: String = "1"
    public static var sourceUrl: String = "https://newsapi.org/v2/top-headlines?country=in&page=" + pageValue + "&category=general&apiKey=" + accessKey
    
}
