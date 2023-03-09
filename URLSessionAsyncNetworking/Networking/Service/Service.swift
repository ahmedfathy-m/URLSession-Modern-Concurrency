//
//  Service.swift
//  URLSessionAsyncNetworking
//
//  Created by Ahmed Fathy on 08/03/2023.
//

import Foundation

final class Webservice {
    static let main = Webservice()
    private init() {}
    let mainQueue = DispatchQueue.main
    let responseHandler = ResponseHandler()
    let errorHandler = ErrorHandler()
    
    func loadService<Model: Codable>(route: Route, model: Model.Type, task: DataTaskType) async -> Model? {
        await withCheckedContinuation { continuation in
            performRequest(route: route, model: model.self) { model, error in
                if let error { self.errorHandler.handle(error, isLoggingEnabled: true, isPresentationEnabled: false) }
                continuation.resume(returning: model)
            }
        }
    }
    
    fileprivate func performRequest<Model: Codable>(route: Route, model: Model.Type, completion: @escaping ResponseCompletion<Model>) {
        let request = route.asURLRequest()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error != nil else { return self.mainQueue.async { completion(nil, error) } }
            do {
                let result = try self.responseHandler.decode(data: data, model: model.self)
                self.mainQueue.async { completion(result, nil) }
            } catch {
                self.mainQueue.async { completion(nil, error) }
            }
        }
        task.resume()
    }
}
