//
//  NSMutableData+String.swift
//  URLSessionAsyncNetworking
//
//  Created by Ahmed Fathy on 08/03/2023.
//

import Foundation

extension NSMutableData {
  func append(_ string: String) {
    if let data = string.data(using: .utf8) {
      self.append(data)
    }
  }
}
