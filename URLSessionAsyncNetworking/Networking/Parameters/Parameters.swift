//
//  Parameters.swift
//  URLSessionAsyncNetworking
//
//  Created by Ahmed Fathy on 08/03/2023.
//

import Foundation

typealias QueryParameters = [String: String]

typealias HTTPBodyTextFields = [String: Any]

extension HTTPBodyTextFields {
    func toMultiPart(with boundary: String) -> Data {
        var fieldString = String()
        self.forEach { (key, value) in
            fieldString += "--\(boundary)\r\n"
            fieldString += "Content-Disposition: form-data; name=\"\(key)\"\r\n"
            fieldString += "Content-Type: text/plain; charset=ISO-8859-1\r\n"
            fieldString += "Content-Transfer-Encoding: 8bit\r\n"
            fieldString += "\r\n"
            fieldString += "\(value)\r\n"
        }
        return fieldString.data(using: .utf8)!
    }
}
