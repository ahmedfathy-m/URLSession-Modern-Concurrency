//
//  DataField.swift
//  URLSessionAsyncNetworking
//
//  Created by Ahmed Fathy on 08/03/2023.
//

import Foundation

struct DataField {
    let key: String
    let mimeType: MimeType
    let data: Data
}

typealias HTTPBodyDataFields = Array<DataField>

extension HTTPBodyDataFields {
    func toMultiPart(with boundary: String) -> Data {
        let field = NSMutableData()
        self.forEach { dataField in
            field.append("--\(boundary)\r\n")
            field.append("Content-Disposition: form-data; name=\"\(dataField.key)\"\r\n")
            field.append("Content-Type: \(dataField.mimeType.rawValue)\r\n")
            field.append("\r\n")
            field.append(dataField.data)
            field.append("\r\n")
        }
        return field as Data
    }
}
