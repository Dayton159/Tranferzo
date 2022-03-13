//
//  MockLoginDataSource.swift
//  TranferzoTests
//
//  Created by Dayton on 11/03/22.
//

import Combine
@testable import Tranferzo

class MockLoginDataSource: LoginDataSourceProtocol {

  var expError: Error?

  func authenticateUser(data: AuthData) -> AnyPublisher<String, APIServiceError> {
    return Future<String, APIServiceError> { completion in
      if let expError = self.expError {
        completion(.failure(APIServiceError.custom(expError)))
      } else {
        completion(.success(LoginResponse.dummy.status))
      }
    }
    .eraseToAnyPublisher()
  }
}
