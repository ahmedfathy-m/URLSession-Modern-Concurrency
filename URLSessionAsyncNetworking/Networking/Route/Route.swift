//
//  Route.swift
//  URLSessionAsyncNetworking
//
//  Created by Ahmed Fathy on 08/03/2023.
//

import Foundation

/// This protocols describes all details of a network call. The route protocols allows to create multiple routers using enums as long as you provide the required fields.
protocol Route {
    var baseURL: String { get }
    var routePath: String { get }
    var method: URLRequest.HTTPMethod { get }
    var body: HTTPBodyTextFields { get }
    var query: QueryParameters { get }
    var contentType: URLRequest.ContentType { get }
    var acceptType: URLRequest.AcceptType { get }
    var dataFields: HTTPBodyDataFields { get }
}

extension Route {
    /// This function converts the network route object to a URLRequest. You don't need to call this function, manually. The Webservice object will call it for you and run the request, automatically.
    /// - Returns: A URLRequest-type object that describes the network call in detail.
    func asURLRequest() -> URLRequest {
        guard let url = URL(string: "\(baseURL)/\(routePath)") else {
            fatalError("Request URL is invalid URL")
        }
        var request = URLRequest(url: url)
        request.method = method
        request.queryItems = query
        request.contentType = contentType
        request.acceptType = acceptType

        if case .multipart(_) = self.contentType, !dataFields.isEmpty {
            request.httpBody = toMultiPart()
        } else {
            request.bodyParameters = body
        }

        request.cachePolicy = .reloadRevalidatingCacheData
        
        return request
    }
    
    fileprivate func toMultiPart() -> Data? {
        if case .multipart(let boundary) = self.contentType {
            var data = Data()
            data.append(body.toMultiPart(with: boundary))
            data.append(dataFields.toMultiPart(with: boundary))
            data.append("--\(boundary)--")
            return data
        } else {
            return nil
        }
    }
}
