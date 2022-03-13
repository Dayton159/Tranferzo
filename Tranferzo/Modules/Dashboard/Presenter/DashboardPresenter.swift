//
//  DashboardPresenter.swift
//  Tranferzo
//
//  Created by Dayton on 12/03/22.
//

protocol DashboardViewProtocol: BaseViewProtocol {
  var transactionLists: [[TransactionModel]] { get set }
  func didGetBalance(with balance: BalanceModel)
}

final class DashboardPresenter: DashboardInteractorOutputProtocol {
  weak private var view: DashboardViewProtocol?
  
  init(interface: DashboardViewProtocol) {
      self.view = interface
  }
  
  func didLoad(with transaction: [[TransactionModel]]) {
    self.view?.transactionLists = transaction
  }
  
  func didLoad(with balance: BalanceModel) {
    self.view?.didGetBalance(with: balance)
  }
  
  func updateState(with state: NetworkState) {
    self.view?.state(state)
  }
  
  func didFail(with message: String) {
    self.view?.showError(by: message)
  }
}
