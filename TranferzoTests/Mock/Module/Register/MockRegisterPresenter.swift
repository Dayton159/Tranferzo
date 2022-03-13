//
//  MockRegisterPresenter.swift
//  TranferzoTests
//
//  Created by Dayton on 13/03/22.
//

@testable import Tranferzo

class MockRegisterPresenter: RegisterInteractorOutputProtocol {
  
  var status: String?
  var state: NetworkState = .loading
  var message: String?
  var isValid: Bool = false
  
  func didRegister(with status: String) {
    self.status = status
  }
  
  func validToRegister(valid: Bool) {
    self.isValid = valid
  }
  
  func updateState(with state: NetworkState) {
    self.state = state
  }
  
  func didFail(with message: String) {
    self.message = message
  }
}
