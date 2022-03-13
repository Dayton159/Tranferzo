//
//  MockDashboardRepository.swift
//  TranferzoTests
//
//  Created by Dayton on 12/03/22.
//

import Combine
@testable import Tranferzo

class MockDashboardRepository: DashboardRepositoryProtocol {
  
  var expError: Error?
  
  func getBalance() -> AnyPublisher<BalanceModel, APIServiceError> {
    return Future<BalanceModel, APIServiceError> { completion in
      if let expError = self.expError {
        completion(.failure(APIServiceError.custom(expError)))
      } else {
        completion(.success(BalanceModel.dummy))
      }
    }
    .eraseToAnyPublisher()
  }
  
  func getTransaction() -> AnyPublisher<[TransactionEntity], APIServiceError> {
    return Future<[TransactionEntity], APIServiceError> { completion in
      if let expError = self.expError {
        completion(.failure(APIServiceError.custom(expError)))
      } else {
        completion(.success(TransactionEntity.dummyList))
      }
    }
    .eraseToAnyPublisher()
  }
}
