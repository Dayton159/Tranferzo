//
//  LoginPresenter.swift
//  Tranferzo
//
//  Created by Dayton on 11/03/22.
//

protocol LoginViewProtocol: BaseViewProtocol {
  func authSuccess(status: String)
  func checkLoginStatus(isValid: Bool)
}

final class LoginPresenter: LoginInteractorOutputProtocol {
  weak private var view: LoginViewProtocol?
  
  init(interface: LoginViewProtocol) {
      self.view = interface
  }
  
  func didLogin(with status: String) {
    self.view?.authSuccess(status: status)
  }
  
  func updateState(with state: NetworkState) {
    self.view?.state(state)
  }
  
  func didFail(with message: String) {
    self.view?.showError(by: message)
  }
  
  func validToLogin(valid: Bool) {
    self.view?.checkLoginStatus(isValid: valid)
  }
}
