//
//  RegisterPresenter.swift
//  Tranferzo
//
//  Created by Dayton on 13/03/22.
//

protocol RegisterViewProtocol: BaseViewProtocol {
  func registerSuccess(status: String)
  func checkRegisterStatus(isValid: Bool)
}

final class RegisterPresenter: RegisterInteractorOutputProtocol {
  weak private var view: RegisterViewProtocol?
  
  init(interface: RegisterViewProtocol) {
      self.view = interface
  }
  
  func didRegister(with status: String) {
    self.view?.registerSuccess(status: status)
  }
  
  func validToRegister(valid: Bool) {
    self.view?.checkRegisterStatus(isValid: valid)
  }
  
  func updateState(with state: NetworkState) {
    self.view?.state(state)
  }
  
  func didFail(with message: String) {
    self.view?.showError(by: message)
  }
}
