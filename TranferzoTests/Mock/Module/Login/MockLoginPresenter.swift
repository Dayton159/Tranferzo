//
//  MockLoginPresenter.swift
//  TranferzoTests
//
//  Created by Dayton on 11/03/22.
//

@testable import Tranferzo

class MockLoginPresenter: LoginInteractorOutputProtocol {

  var status: String?
  var state: NetworkState = .loading
  var message: String?
  var isValid: Bool = false
  
  func didLogin(with status: String) {
    self.status = status
  }
  
  func updateState(with state: NetworkState) {
    self.state = state
  }
  
  func didFail(with message: String) {
    self.message = message
  }
  
  func validToLogin(valid: Bool) {
    self.isValid = valid
  }
}
