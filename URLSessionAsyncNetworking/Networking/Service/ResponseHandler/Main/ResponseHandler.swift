//
//  ResponseHandler.swift
//  URLSessionAsyncNetworking
//
//  Created by Ahmed Fathy on 09/03/2023.
//

import Foundation

/// Your additional processing goes here
struct ResponseHandler {
    /// In this function, you can add any extra processing on your data. It could be as  simple as decoding the data with a JSONDecoder or maybe you want to extract the data from a child object because your API returns additional info that you don't need where you make the API call
    /// - Parameters:
    ///   - data: The raw data retreived from the API call without any processing
    ///   - model: The data type you need to retrieve
    /// - Returns: Processed/Decoded response
    func process<Model: Codable>(data: Data?, model: Model.Type) throws -> Model {
        guard let data else { throw ResponseHandlerError.missingInputData }
        return try JSONDecoder().decode(model.self, from: data)
    }
}
