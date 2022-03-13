//
//  BalanceDataSource.swift
//  Tranferzo
//
//  Created by Dayton on 12/03/22.
//

import Combine

protocol BalanceDataSourceProtocol: AnyObject {
  func getBalance() -> AnyPublisher<BalanceResponse, APIServiceError>
}

final class BalanceDataSource {
  private let _balance: BalanceRequest
  
  init(balance: BalanceRequest) {
    self._balance = balance
  }
}

extension BalanceDataSource: BalanceDataSourceProtocol {
  func getBalance() -> AnyPublisher<BalanceResponse, APIServiceError> {
    return API()
      .fetch(_balance)
      .eraseToAnyPublisher()
  }
}
