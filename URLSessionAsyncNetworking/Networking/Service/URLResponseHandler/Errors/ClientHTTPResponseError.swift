//
//  ClientHTTPResponseError.swift
//  URLSessionAsyncNetworking
//
//  Created by Ahmed Fathy on 10/03/2023.
//

import Foundation

/// An enum contains all client response errors (4xx status code)
enum ClientHTTPResponseError: Int, Error {
    // 4xx Client Error
    case badRequest = 400
    case unauthorized = 401
    case paymentRequired = 402
    case forbidden = 403
    case notFound = 404
    case methodNotAllowed = 405
    case notAcceptable = 406
    case proxyAuthenticationRequired = 407
    case requestTimeout = 408
    case conflict = 409
    case gone = 410
    case lengthRequired = 411
    case preconditionFailed = 412
    case payloadTooLarge = 413
    case uriTooLong = 414
    case unsupportedMediaType = 415
    case rangeNotSatisfiable = 416
    case expectationFailed = 417
    case imATeapot = 418
    case misdirectedRequest = 421
    case unprocessableEntity = 422
    case locked = 423
    case failedDependency = 424
    case tooEarly = 425
    case upgradeRequired = 426
    case preconditionRequired = 428
    case tooManyRequests = 429
    case requestHeaderFieldsTooLarge = 431
    case unavailableForLegalReasons = 451
    
    var localizedDescription: String {
        switch self {
        case .badRequest:
            return "Bad Request"
        case .unauthorized:
            return "Unauthorized"
        case .paymentRequired:
            return "Payment Required"
        case .forbidden:
            return "Forbidden"
        case .notFound:
            return "Not Found"
        case .methodNotAllowed:
            return "Method Not Allowed"
        case .notAcceptable:
            return "Not Acceptable"
        case .proxyAuthenticationRequired:
            return "Proxy Authentication Required"
        case .requestTimeout:
            return "Request Timeout"
        case .conflict:
            return "Conflict"
        case .gone:
            return "Gone"
        case .lengthRequired:
            return "Length Required"
        case .preconditionFailed:
            return "Precondition Failed"
        case .payloadTooLarge:
            return "Payload Too Large"
        case .uriTooLong:
            return "URI Too Long"
        case .unsupportedMediaType:
            return "Unsupported Media Type"
        case .rangeNotSatisfiable:
            return "Range Not Satisfiable"
        case .expectationFailed:
            return "Expectation Failed"
        case .imATeapot:
            return "I'm a teapot"
        case .misdirectedRequest:
            return "Misdirected Request"
        case .unprocessableEntity:
            return "Unprocessable Entity"
        case .locked:
            return "Locked"
        case .failedDependency:
            return "Failed Dependency"
        case .tooEarly:
            return "Too Early"
        case .upgradeRequired:
            return "Upgrade Required"
        case .preconditionRequired:
            return "Precondition Required"
        case .tooManyRequests:
            return "Too Many Requests"
        case .requestHeaderFieldsTooLarge:
            return "Request Header Fields Too Large"
        case .unavailableForLegalReasons:
            return "Unavailable For Legal Reasons"
        }
    }
}
