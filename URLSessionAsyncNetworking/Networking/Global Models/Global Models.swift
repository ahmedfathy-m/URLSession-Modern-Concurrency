//
//  File.swift
//  URLSessionAsyncNetworking
//
//  Created by Ahmed Fathy on 08/03/2023.
//

import Foundation

// MARK: - GlobalModel
struct GlobalModel<DataModel: Codable>: Codable {
    let userStatus, msg: String
    let code: Int
    let data: DataModel?
    let key: ResponseStatus

    enum CodingKeys: String, CodingKey {
        case userStatus = "user_status"
        case msg, key, code, data
    }
}

struct GenericModel: Codable {
    let userStatus, msg: String
    let code: Int
    let key: ResponseStatus

    enum CodingKeys: String, CodingKey {
        case userStatus = "user_status"
        case msg, key, code
    }
}

enum ResponseStatus: String, Codable {
    case success
    case fail
}
