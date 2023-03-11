//
//  Service.swift
//  URLSessionAsyncNetworking
//
//  Created by Ahmed Fathy on 08/03/2023.
//

import Foundation
import Combine

/// A networking layer based on URLSession with support for Modern Concurrency from iOS 13 and upwards.
final class Webservice {
    /// The main service you need to call to use this networking layer.
    static let main = Webservice()
    private init() {}
    private let mainQueue = DispatchQueue.main
    private let responseHandler = ResponseHandler()
    private var cancellables = Set<AnyCancellable>()
    
    /// Make an asynchronus call to a network route
    /// - Parameters:
    ///   - route: The route defines all aspects of a network call. It represents the target URL and all data required.
    ///   - model: The type of data model you need to retrieve
    /// - Returns: The response of the network call in the form of your required data type
    func loadService<Model: Codable>(route: Route, model: Model.Type) async throws -> Model {
        try await withCheckedThrowingContinuation { continuation in
            performRequest(route: route, model: model.self) { model, error in
                if let error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: model!)
                }
            }
        }
    }
    
    /// Make an API call to a network route and retrieve a publisher of your data to bind to other elements of your code.
    /// - Parameters:
    ///   - route: The route defines all aspects of a network call. It represents the target URL and all data required.
    ///   - model: The type of data model you need to retrieve
    /// - Returns: The response of the network call in the form of AnyPublisher of your required type
    func publishRequest<Model: Codable>(route: Route, model: Model.Type) -> AnyPublisher<Model, Error> {
        let request = route.asURLRequest()
        return Future<Model, Error> { promise in
            URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { (data, response) in
                    try URLResponseHandler(response).validate()
                    return try self.responseHandler.process(data: data, model: model.self)
                }.receive(on: RunLoop.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } receiveValue: { model in
                    promise(.success(model))
                }.store(in: &self.cancellables)
        }.eraseToAnyPublisher()

    }
    
    private func performRequest<Model: Codable>(route: Route, model: Model.Type, completion: @escaping ResponseCompletion<Model>) {
        let request = route.asURLRequest()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else { return self.mainQueue.async { completion(nil, error) } }
            do {
                let result = try self.responseHandler.process(data: data, model: model.self)
                self.mainQueue.async { completion(result, nil) }
            } catch {
                self.mainQueue.async { completion(nil, error) }
            }
        }
        task.resume()
    }
}
