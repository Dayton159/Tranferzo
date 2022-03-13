//
//  LoginInteractor.swift
//  Tranferzo
//
//  Created by Dayton on 11/03/22.
//

import Combine

protocol LoginInteractorOutputProtocol: BaseInteractorOutputProtocol  {
  func didLogin(with status: String)
  func validToLogin(valid: Bool)
}

protocol LoginUseCase: AnyObject {
  func authenticateUser()
  func setLoginData(username: String)
  func setLoginData(password: String)
}

final class LoginInteractor: BaseInteractor {
  private let _output: LoginInteractorOutputProtocol
  private let _repository: LoginRepositoryProtocol
  private var _loginData: AuthData = AuthData() {
    didSet {
      self._output.validToLogin(valid: !_loginData.username.isEmpty && !_loginData.password.isEmpty)
    }
  }
  
  init(_output: LoginInteractorOutputProtocol, _repository: LoginRepositoryProtocol) {
    self._output = _output
    self._repository = _repository
  }
}

extension LoginInteractor: LoginUseCase {
  func authenticateUser() {
    _output.updateState(with: .loading)
    _repository.authenticateUser(data: _loginData)
      .sink(receiveCompletion: { errorData in
        switch errorData {
        case .failure(let error):
          self._output.updateState(with: .error)
          self._output.didFail(with: error.errorMessage)
        default: break
        }
      }, receiveValue: { result in
        self._output.didLogin(with: result)
        self._output.updateState(with: .finish)
      })
      .store(in: &cancellables)
  }
  
  func setLoginData(username: String) {
    self._loginData.username = username
  }
  
  func setLoginData(password: String) {
    self._loginData.password = password
  }
}
