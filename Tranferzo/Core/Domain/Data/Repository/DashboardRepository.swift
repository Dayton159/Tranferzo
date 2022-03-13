//
//  DashboardRepository.swift
//  Tranferzo
//
//  Created by Dayton on 12/03/22.
//

import Combine

protocol DashboardRepositoryProtocol: AnyObject {
  func getTransaction() -> AnyPublisher<[TransactionEntity], APIServiceError>
  func getBalance() -> AnyPublisher<BalanceModel, APIServiceError>
}

final class DashboardRepository {
  private let _balance: BalanceDataSourceProtocol
  private let _transaction: TransactionDataSourceProtocol
  private let _mapperTransaction: (([TransactionResponse]) -> [TransactionEntity])
  private let _mapperBalance: ((BalanceResponse) -> BalanceModel)
  
  
  init(
    balance: BalanceDataSourceProtocol,
    transaction: TransactionDataSourceProtocol,
    mapperTransaction: @escaping (([TransactionResponse]) -> [TransactionEntity]),
    mapperBalance: @escaping ((BalanceResponse) -> BalanceModel)
  ) {
    self._balance = balance
    self._transaction = transaction
    self._mapperTransaction = mapperTransaction
    self._mapperBalance = mapperBalance
  }
}

extension DashboardRepository: DashboardRepositoryProtocol {
  func getTransaction() -> AnyPublisher<[TransactionEntity], APIServiceError> {
    return _transaction
      .getTransaction()
      .map { self._mapperTransaction($0) }
      .eraseToAnyPublisher()
  }
  
  
  func getBalance() -> AnyPublisher<BalanceModel, APIServiceError> {
    return _balance
      .getBalance()
      .map { self._mapperBalance($0) }
      .eraseToAnyPublisher()
  }
}
