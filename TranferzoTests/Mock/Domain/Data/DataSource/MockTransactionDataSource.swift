//
//  MockTransactionDataSource.swift
//  TranferzoTests
//
//  Created by Dayton on 12/03/22.
//

import Combine
@testable import Tranferzo

class MockTransactionDataSource: TransactionDataSourceProtocol {
  
  var expError: Error?
  
  func getTransaction() -> AnyPublisher<[TransactionResponse], APIServiceError> {
    return Future<[TransactionResponse], APIServiceError> { completion in
      if let expError = self.expError {
        completion(.failure(APIServiceError.custom(expError)))
      } else {
        completion(.success(TransactionResponse.dummyList))
      }
    }
    .eraseToAnyPublisher()
  }
}
