//
//  APIRequest.swift
//  Tranferzo
//
//  Created by Dayton on 10/03/22.
//

import Foundation

struct EmptyResponse: Codable {}
struct EmptyBody: Codable {}

protocol APIRequest {
  associatedtype RequestData: Codable
  associatedtype Response: Codable
  
  var pathname: String { get }
  var method: HTTPMethod { get }
  var body: RequestData? { get }
  var query: [URLQueryItem]? { get }
  var contentType: String { get }
}

extension APIRequest {
  typealias Response = EmptyResponse
  
  var method: HTTPMethod { .get }
  var body: EmptyBody? { nil }
  var query: [URLQueryItem]? { nil }
  var contentType: String { "application/json" }
}

extension APIRequest {
  func makeURLComponents() -> URLComponents {
    guard var components = URLComponents(string: Environment.baseURL + pathname)
    else { fatalError("Couldn't create URLComponents") }
    components.queryItems = query
    
    return components
  }
  
  func makeURLRequest() -> URLRequest {
    let components = makeURLComponents()
    guard let url = components.url else { fatalError("Empty Component URL")}
    
    var urlRequest = URLRequest(url: url)
    urlRequest.method = method
    urlRequest.setHeader(.contentType(contentType))
    
    if let body = body {
      guard let data = try? JSONEncoder().encode(body) else { fatalError("Failed to Encode Request")}
      urlRequest.httpBody = data
    }
    
    return urlRequest
  }
}
