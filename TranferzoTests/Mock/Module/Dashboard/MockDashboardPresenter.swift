//
//  MockDashboardPresenter.swift
//  TranferzoTests
//
//  Created by Dayton on 12/03/22.
//

@testable import Tranferzo

class MockDashboardPresenter: DashboardInteractorOutputProtocol {
  
  var transactions: [[TransactionModel]] = []
  var balance:BalanceModel?
  var state: NetworkState = .loading
  var message: String?
  
  func didLoad(with transaction: [[TransactionModel]]) {
    self.transactions = transaction
  }
  
  func didLoad(with balance: BalanceModel) {
    self.balance = balance
  }
  
  func updateState(with state: NetworkState) {
    self.state = state
  }
  
  func didFail(with message: String) {
    self.message = message
  }
}
