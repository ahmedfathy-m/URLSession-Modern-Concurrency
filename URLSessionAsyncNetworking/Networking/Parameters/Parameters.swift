//
//  Parameters.swift
//  URLSessionAsyncNetworking
//
//  Created by Ahmed Fathy on 08/03/2023.
//

import Foundation

typealias QueryParameters = [String: String]

extension QueryParameters {
    /// Describes an empty dictionary of QueryParameters objects
    static var empty: QueryParameters {
        return [:]
    }
}

typealias HTTPBodyTextFields = [String: Any]

extension HTTPBodyTextFields {
    /// Describes an empty dictionary of HTTPBodyTexField objects
    static var empty: HTTPBodyTextFields {
        return [:]
    }
    
    /// This function converts the text fields of an HTTP body to a multipart segment using the boundary string
    /// - Parameter boundary: The boundary string used in a multipart request
    /// - Returns: A multipart segment represeting the text field as raw data
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
