//
//  URLRequest+Body.swift
//  URLSessionAsyncNetworking
//
//  Created by Ahmed Fathy on 08/03/2023.
//

import Foundation

extension URLRequest {
    var bodyParameters: [String: Any] {
        get { (try? JSONSerialization.jsonObject(with: self.httpBody ?? Data()) as? [String: Any]) ?? [:] }
        set { self.httpBody = try? JSONSerialization.data(withJSONObject: newValue) }
    }
}
