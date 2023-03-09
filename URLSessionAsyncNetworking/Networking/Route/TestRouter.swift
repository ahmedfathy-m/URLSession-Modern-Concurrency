//
//  TestRouter.swift
//  URLSessionAsyncNetworking
//
//  Created by Ahmed Fathy on 08/03/2023.
//

import Foundation

enum Router {
    case home(image: Data)
}

extension Router: Route {
    var baseURL: String {
        "awamer.com"
    }
    
    var routePath: String {
        "api/home"
    }
    
    var method: URLRequest.HTTPMethod {
        .post
    }
    
    var body: [String : Any] {
        return [:]
    }
    
    var query: [String : String] {
        return [:]
    }
    
    var contentType: URLRequest.ContentType {
        .multipart(boundary: UUID().uuidString)
    }
    
    var acceptType: URLRequest.AcceptType {
        .json
    }
    
    var dataFields: HTTPBodyDataFields {
        var dataFields = HTTPBodyDataFields()
        switch self {
        case .home(let image):
            dataFields.append(DataField(key: "key", mimeType: .jpeg, data: image))
        }
        return dataFields
    }
}
