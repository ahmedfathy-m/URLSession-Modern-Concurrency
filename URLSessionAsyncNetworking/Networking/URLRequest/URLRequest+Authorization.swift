//
//  URLRequest+Authorization.swift
//  URLSessionAsyncNetworking
//
//  Created by Ahmed Fathy on 08/03/2023.
//

import Foundation

extension URLRequest {
    var bearerToken: String {
        get { self.value(forHTTPHeaderField: "Authorization")?.replacingOccurrences(of: "Bearer ", with: "") ?? "" }
        set { self.setValue(newValue, forHTTPHeaderField: "Authorization")}
    }
}
