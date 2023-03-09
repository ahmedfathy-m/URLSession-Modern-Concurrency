//
//  ErrorHandler.swift
//  URLSessionAsyncNetworking
//
//  Created by Ahmed Fathy on 09/03/2023.
//

import Foundation

struct ErrorHandler {
    func handle(_ error: Error, isLoggingEnabled: Bool, isPresentationEnabled: Bool) {
        if isLoggingEnabled {
            self.log(error)
        }
        
        if isPresentationEnabled {
            
        }
    }
    
    fileprivate func log(_ error: Error) {
        if let error = error as? ResponseHandlerError {
            print("RESPONSE ERROR")
            print("======================")
            print(error.localizedDescription)
        } else if let error = error as? DecodingError {
            print("DECODING ERROR")
            print("======================")
            switch error {
            case .typeMismatch(let type, let context):
                print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
            case .valueNotFound(let type, let context):
                print("could not find type \(type) in JSON: \(context.debugDescription)")
            case .keyNotFound(let key, let context):
                print("could not find key \(key) in JSON: \(context.debugDescription)")
            case .dataCorrupted(let context):
                print("data found to be corrupted in JSON: \(context.debugDescription)")
            @unknown default:
                print(error.localizedDescription)
            }
        } else {
            print("SWIFT/IOS ERROR")
            print("======================")
            print(error.localizedDescription)
        }
    }
}
