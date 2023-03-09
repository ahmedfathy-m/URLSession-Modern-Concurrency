//
//  URLRequest+AcceptType.swift
//  URLSessionAsyncNetworking
//
//  Created by Ahmed Fathy on 08/03/2023.
//

import Foundation

extension URLRequest {
    enum AcceptType: String {
        case json = "application/json"
    }
    
    var acceptType: AcceptType? {
        get { AcceptType(rawValue: self.value(forHTTPHeaderField: "Accept") ?? "") }
        set { self.setValue(newValue?.rawValue, forHTTPHeaderField: "Accept")}
    }
}
