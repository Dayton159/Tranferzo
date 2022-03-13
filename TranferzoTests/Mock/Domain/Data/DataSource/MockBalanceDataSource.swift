//
//  MockBalanceDataSource.swift
//  TranferzoTests
//
//  Created by Dayton on 12/03/22.
//

import Combine
@testable import Tranferzo

class MockBalanceDataSource: BalanceDataSourceProtocol {
  
  var expError: Error?
  
  func getBalance() -> AnyPublisher<BalanceResponse, APIServiceError> {
    return Future<BalanceResponse, APIServiceError> { completion in
      if let expError = self.expError {
        completion(.failure(APIServiceError.custom(expError)))
      } else {
        completion(.success(BalanceResponse.dummy))
      }
    }
    .eraseToAnyPublisher()
  }
}
