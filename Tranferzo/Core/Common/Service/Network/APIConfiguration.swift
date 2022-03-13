//
//  APIConfiguration.swift
//  Tranferzo
//
//  Created by Dayton on 10/03/22.
//

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case delete = "DELETE"
}

enum HTTPHeaderField{
  case contentType(String)
  case authorization(String)
  
  var header: HTTPHeader {
    switch self {
    case .contentType(let value): return HTTPHeader(name: "Content-Type", value: value)
    case .authorization(let token): return HTTPHeader(name: "Authorization", value: token)
    }
  }
}

struct HTTPHeader {
  let name: String
  let value: String
}
