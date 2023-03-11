//
//  Post.swift
//  URLSessionAsyncNetworking
//
//  Created by Ahmed Fathy on 10/03/2023.
//

import Foundation

struct Post: Codable, Hashable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
