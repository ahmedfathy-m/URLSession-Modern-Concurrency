//
//  URLRequest+HTTPMethod.swift
//  URLSessionAsyncNetworking
//
//  Created by Ahmed Fathy on 08/03/2023.
//

import Foundation

extension URLRequest {
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case delete = "DELETE"
    }
    
    var method: HTTPMethod? {
        get { HTTPMethod(rawValue: self.httpMethod ?? "") }
        set { self.httpMethod = newValue?.rawValue ?? ""}
    }
}
