//
//  Data+String.swift
//  URLSessionAsyncNetworking
//
//  Created by Ahmed Fathy on 09/03/2023.
//

import Foundation

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}
