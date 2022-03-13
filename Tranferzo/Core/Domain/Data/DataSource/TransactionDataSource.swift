//
//  TransactionDataSource.swift
//  Tranferzo
//
//  Created by Dayton on 12/03/22.
//

import Combine

protocol TransactionDataSourceProtocol: AnyObject {
  func getTransaction() -> AnyPublisher<[TransactionResponse], APIServiceError>
}


final class TransactionDataSource {
  private let _transaction: TransactionRequest
  
  init(transaction: TransactionRequest) {
    self._transaction = transaction
  }
}

extension TransactionDataSource: TransactionDataSourceProtocol {
  func getTransaction() -> AnyPublisher<[TransactionResponse], APIServiceError> {
    return API()
      .fetch(_transaction)
      .map { $0.data }
      .eraseToAnyPublisher()
  }
}
