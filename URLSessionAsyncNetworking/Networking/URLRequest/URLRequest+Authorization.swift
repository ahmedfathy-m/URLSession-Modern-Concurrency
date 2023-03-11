//
//  URLRequest+Authorization.swift
//  URLSessionAsyncNetworking
//
//  Created by Ahmed Fathy on 08/03/2023.
//

import Foundation

extension URLRequest {
    ///Directly set/retrieves the bearer token without needing to add the "Bearer" prefix
    var bearerToken: String {
        get { self.value(forHTTPHeaderField: "Authorization")?.replacingOccurrences(of: "Bearer ", with: "") ?? "" }
        set { self.setValue("Bearer \(newValue)", forHTTPHeaderField: "Authorization")}
    }
}
