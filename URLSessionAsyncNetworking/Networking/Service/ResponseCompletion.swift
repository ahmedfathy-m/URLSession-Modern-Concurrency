//
//  ResponseCompletion.swift
//  URLSessionAsyncNetworking
//
//  Created by Ahmed Fathy on 09/03/2023.
//

import Foundation

typealias ResponseCompletion<Model> = (Model?, Error?)->Void
