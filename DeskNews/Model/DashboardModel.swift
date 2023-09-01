//
//  DashboardModel.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 23/08/23.
//

import Foundation

class DashboardModel {
}
struct APIRequestStruct: Codable {
    var accessKey: String
    var offset: String
    var count: String
    enum codingKeys: String, CodingKey {
        case accessKey = "access_key"
    }
}
struct PaginationStruct: Codable {
    var pagination: APIResponseBody
    var data: [APIDataStruct]
}
struct APIResponseBody: Codable {
    var limit: Int
    var offset: Int
    var count: Int
    var total: Int
}
struct APIDataStruct: Codable {
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var source: String?
    var image: String?
    var category: String?
    var language: String?
    var country: String?
    var publishedAt: String?

    enum CodingKeys: String, CodingKey {
        case author, title, description, url, source, image, category, language, country
        case publishedAt = "published_at"
    }
}
