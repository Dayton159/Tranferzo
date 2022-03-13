//
//  URLSessionService.swift
//  Tranferzo
//
//  Created by Dayton on 10/03/22.
//

import Foundation
import Combine

class URLSessionService: APIService {
  private let session: URLSession
  
  init(session: URLSession = .shared) {
    self.session = session
  }
  
  func fetch<ResponseType>(request: URLRequest,
                           decodeTo: ResponseType.Type) -> AnyPublisher<ResponseType, APIServiceError> where ResponseType: Decodable {
    return Future<ResponseType, APIServiceError> { completion in
      let datatask =  self.session.dataTask(with: request) { data, response, error in
        
        if let error = error {
          completion(.failure(APIServiceError.custom(error)))
          return
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode != 503 else {
          completion(.failure(APIServiceError.noInternetConnection))
          return
        }
        
        
        guard let data = data, !data.isEmpty else {
          completion(.failure(APIServiceError.cannotMapToObject))
          return
        }
        
        if 200..<300 ~= response.statusCode {
          do {
            let model = try JSONDecoder().decode(ResponseType.self, from: data)
            completion(.success(model))
          } catch {
            completion(.failure(APIServiceError.cannotMapToObject))
          }
          
        } else {
          do {
            let model = try JSONDecoder().decode(ErrorResponse.self, from: data)
            completion(.failure(APIServiceError.errorResponse(model)))
          } catch {
            completion(.failure(APIServiceError.cannotMapToObject))
          }
        }
      }
      datatask.resume()
    }
    .subscribe(on: DispatchQueue.global(qos: .background))
    .receive(on: DispatchQueue.main)
    .eraseToAnyPublisher()
  }
}
