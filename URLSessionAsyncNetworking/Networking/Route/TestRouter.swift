//
//  TestRouter.swift
//  URLSessionAsyncNetworking
//
//  Created by Ahmed Fathy on 08/03/2023.
//

import Foundation

enum Router {
    case placeholder
}

extension Router: Route {
    var baseURL: String {
        "https://jsonplaceholder.typicode.com"
    }
    
    var routePath: String {
        switch self {
        case .placeholder:
            return "posts"
        }
    }
    
    var method: URLRequest.HTTPMethod {
        switch self {
        case .placeholder: return .get
        }
    }
    
    var body: HTTPBodyTextFields {
        .empty
    }
    
    var query: QueryParameters {
        .empty
    }
    
    var contentType: URLRequest.ContentType {
        .formData
    }
    
    var acceptType: URLRequest.AcceptType {
        .json
    }
    
    var dataFields: HTTPBodyDataFields {
        switch self {
        case .placeholder:
            return .empty
        }
    }
}
