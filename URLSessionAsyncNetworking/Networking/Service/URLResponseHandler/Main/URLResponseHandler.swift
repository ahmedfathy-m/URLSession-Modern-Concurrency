//
//  URLResponseHandler.swift
//  URLSessionAsyncNetworking
//
//  Created by Ahmed Fathy on 10/03/2023.
//

import Foundation

/// This object receives and validates the URLResponse
struct URLResponseHandler {
    let response: HTTPURLResponse
    
    init(_ response: HTTPURLResponse) {
        self.response = response
    }
    
    init(_ response: URLResponse) {
        self.response = response as! HTTPURLResponse
    }
}

extension URLResponseHandler {
    /// Validates the status code and throws an error in case of an Error
    func validate() throws {
        let statusCode = self.response.statusCode
        switch statusCode {
        case 400...499: throw ClientHTTPResponseError(rawValue: statusCode) ?? .badRequest
        case 500...599: throw ServerHTTPResponseError(rawValue: statusCode) ?? .internalServerError
        default: print("Valid Response: \(statusCode)")
        }
    }
}
