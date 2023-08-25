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
struct APIResponseStruct: Codable {
    var responseCode: Int
    var responseMessage: String
    var responseBody: PaginationStruct
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
    var url: URL?
    var source: String?
    var image: URL?
    var category: String?
    var language: String?
    var country: String?
    var published_at: String?
}

