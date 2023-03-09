//
//  Route.swift
//  URLSessionAsyncNetworking
//
//  Created by Ahmed Fathy on 08/03/2023.
//

import Foundation

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
