//
//  MockRegisterRepository.swift
//  TranferzoTests
//
//  Created by Dayton on 13/03/22.
//

import Combine
@testable import Tranferzo

class MockRegisterRepository: RegisterRepositoryProtocol {
  
  var expError: Error?
  
  func registerUser(data: AuthData) -> AnyPublisher<String, APIServiceError> {
    return Future<String, APIServiceError> { completion in
      if let expError = self.expError {
        completion(.failure(APIServiceError.custom(expError)))
      } else {
        completion(.success(RegisterResponse.dummy.status.capitalized))
      }
    }
    .eraseToAnyPublisher()
  }
}
