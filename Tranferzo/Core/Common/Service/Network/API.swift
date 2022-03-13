//
//  API.swift
//  Tranferzo
//
//  Created by Dayton on 10/03/22.
//

import Foundation
import Combine

protocol APIService {
  func fetch<ResponseType: Decodable>(request: URLRequest,
                                      decodeTo: ResponseType.Type) -> AnyPublisher<ResponseType, APIServiceError>
}

class API<Request: APIRequest> {
  private let apiService: APIService
  private let secretTokenStore: SecretStore

  init(apiService: APIService = URLSessionService(),
       secretTokenStore: SecretStore = KeyChainStore()) {
    self.apiService = apiService
    self.secretTokenStore = secretTokenStore
  }

  func fetch(_ request: Request) -> AnyPublisher<Request.Response, APIServiceError> {
    var urlRequest = request.makeURLRequest()
    
    if let token = try? self.secretTokenStore.getValue(for: Secrets.authJwtToken) {
      urlRequest.setHeader(.authorization(token))
    }
    
    return self.apiService.fetch(request: urlRequest, decodeTo: Request.Response.self)
  }
}
