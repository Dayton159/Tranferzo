//
//  URLRequest+Extension.swift
//  Tranferzo
//
//  Created by Dayton on 10/03/22.
//

import Foundation

extension URLRequest {
  var method: HTTPMethod? {
    get {
      guard let httpMethodStr = self.httpMethod else { return nil }
      return HTTPMethod(rawValue: httpMethodStr)
    }
    set { self.httpMethod = newValue?.rawValue }
  }
  
  mutating func setHeader(_ field: HTTPHeaderField) {
    self.setValue(field.header.value, forHTTPHeaderField: field.header.name)
  }
}

