//
//  MockAPIService.swift
//  TranferzoTests
//
//  Created by Dayton on 11/03/22.
//

import Foundation
import Combine
@testable import Tranferzo

class MockAPIService: APIService {
  var dummyResponse: String = ""
  var expPathname: String?
  var expMethod: String?
  var expError: ErrorResponse?
  var expQueryItemParam: String?
  var expQueryItemString: String?
  
  func fetch<ResponseType>(request: URLRequest, decodeTo: ResponseType.Type) -> AnyPublisher<ResponseType, APIServiceError> where ResponseType: Decodable {
    return Future<ResponseType, APIServiceError> { completion in
      
      if let error = self.expError {
        completion(.failure(APIServiceError.errorResponse(error)))
      }
      
      if let pathname = self.expPathname, request.url?.path != pathname {
        completion(.failure(APIServiceError.custom(NSError(domain: "Tranferzo-VIPTests", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Pathname invalid. Expected: \(pathname). Actual: \(request.url?.path ?? "nil")"]))))
      }
      
      if let method = self.expMethod, request.method?.rawValue != method {
        completion(.failure(APIServiceError.custom(NSError(domain: "Tranferzo-VIPTests", code: 1002, userInfo: [NSLocalizedDescriptionKey: "Method invalid. Expected: \(method). Actual: \(request.method?.rawValue ?? "nil")"]))))
      }
      
      if request.method?.rawValue == "POST" {
        if request.httpBody == nil {
          completion(.failure(APIServiceError.custom(NSError(domain: "Tranferzo-VIPTests", code: 1003, userInfo: [NSLocalizedDescriptionKey : "HTTP Body is required. Expected: not nil. Actual: nil"]))))
        }
      }
      
      if let param = self.expQueryItemParam, let actualValue = self.getQueryStringParameter(url: request.url?.absoluteString, param: param) {
        if self.expQueryItemString != actualValue {
          completion(.failure(APIServiceError.custom(NSError(domain: "Tranferzo-VIPTests", code: 400, userInfo: [NSLocalizedDescriptionKey: "Param invalid. Expected: Param \(param) with value \(self.expQueryItemString ?? "nil"). Actual: \(actualValue)"]))))
        }
      }
      do {
        let value = try self.dummyDecoded(to: ResponseType.self)
        completion(.success(value))
      } catch {
        completion(.failure(APIServiceError.custom(error)))
      }
    }
    .eraseToAnyPublisher()
  }
  
  private func getQueryStringParameter(url: String?, param: String) -> String? {
    guard let stringURL = url,
          let url = URLComponents(string: stringURL) else { return nil }
    return url.queryItems?.first(where: { $0.name == param })?.value
  }
  
  private func dummyDecoded<T> (to: T.Type) throws -> T where T: Decodable {
    let data = dummyResponse.data(using: .utf8)
    let decoded = try JSONDecoder().decode(to, from: data!)
    return decoded
  }
}
