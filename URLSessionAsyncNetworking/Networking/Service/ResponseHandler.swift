//
//  ResponseHandler.swift
//  URLSessionAsyncNetworking
//
//  Created by Ahmed Fathy on 09/03/2023.
//

import Foundation

struct ResponseHandler {
    func decode<Model: Codable>(data: Data?, model: Model.Type) throws -> Model {
        guard let data else { throw ResponseHandlerError.missingInputData }
        // Check if data type is the global model itself
        if Model.self == GenericModel.self {
            let decodedData = try JSONDecoder().decode(Model.self, from: data) as! GenericModel
            if decodedData.key == .success {
                return decodedData as! Model
            } else {
                throw ResponseHandlerError.APIError(message: decodedData.msg)
            }
        } else {
            let decodedData = try JSONDecoder().decode(GlobalModel<Model>.self, from: data)
            if decodedData.key == .success {
                guard let data = decodedData.data else { throw ResponseHandlerError.missingReturnData }
                return data
            } else {
                throw ResponseHandlerError.APIError(message: decodedData.msg)
            }
        }
    }
}
