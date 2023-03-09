//
//  URLRequest+ContentType.swift
//  URLSessionAsyncNetworking
//
//  Created by Ahmed Fathy on 08/03/2023.
//

import Foundation

extension URLRequest {
    
    enum ContentType {
        case formURLEncoded
        case formData
        case raw
        case binary
        case GraphQL
        case multipart(boundary: String)
        case undefined(stringValue: String)
        
        var key: String {
            switch self {
            case .formURLEncoded: return "application/x-www-form-urlencoded"
            case .formData: return "form-data"
            case .raw: return "raw"
            case .binary: return "binary"
            case .GraphQL: return "GraphQL"
            case .multipart(let boundary): return "multipart/form-data; boundary=\(boundary)"
            case .undefined(let stringValue): return stringValue
            }
        }
        
        fileprivate static func getType(for key: String) -> ContentType {
            if key == "application/x-www-form-urlencoded" {
                return .formURLEncoded
            } else if key == "form-data" {
                return .formData
            } else if key == "raw" {
                return .raw
            } else if key == "binary" {
                return .binary
            } else if key == "GraphQL" {
                return .GraphQL
            } else if key.localizedStandardContains("multipart/form-data; boundary=") {
                let boundary = key.replacingOccurrences(of: "multipart/form-data; boundary=", with: "")
                return .multipart(boundary: boundary)
            } else {
                return .undefined(stringValue: key)
            }
        }
    }
    
    var contentType: ContentType {
        get { ContentType.getType(for: self.value(forHTTPHeaderField: "Content-Type") ?? "") }
        set { self.setValue(newValue.key, forHTTPHeaderField: "Content-Type") }
    }
}
