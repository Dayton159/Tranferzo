//
//  RegisterInteractor.swift
//  Tranferzo
//
//  Created by Dayton on 13/03/22.
//

import Combine

protocol RegisterInteractorOutputProtocol: BaseInteractorOutputProtocol {
  func didRegister(with status: String)
  func validToRegister(valid: Bool)
}

protocol RegisterUseCase: AnyObject {
  func registerUser()
  func setRegisterData(username: String)
  func setRegisterData(password: String)
  func setRegisterData(confirmPass: String)
}

final class RegisterInteractor: BaseInteractor {
  private let _output: RegisterInteractorOutputProtocol
  private let _repository: RegisterRepositoryProtocol
  private var _registerData: AuthData = AuthData() {
    didSet {
      self.isValid()
    }
  }
  private var _confirmPass: String = "" {
    didSet {
      self.isValid()
    }
  }
  
  init(_output: RegisterInteractorOutputProtocol, _repository: RegisterRepositoryProtocol) {
    self._output = _output
    self._repository = _repository
  }
  
  private func isValid() {
    self._output.validToRegister(valid: !_registerData.username.isEmpty &&
                                 !_registerData.password.isEmpty &&
                                 _confirmPass == _registerData.password)
  }
}

extension RegisterInteractor: RegisterUseCase {
  func registerUser() {
    _output.updateState(with: .loading)
    _repository.registerUser(data: _registerData)
      .sink(receiveCompletion: { errorData in
        switch errorData {
        case .failure(let error):
          self._output.updateState(with: .error)
          self._output.didFail(with: error.errorMessage)
        default: break
        }
      }, receiveValue: { result in
        self._output.didRegister(with: result)
        self._output.updateState(with: .finish)
      })
      .store(in: &cancellables)
  }
  
  func setRegisterData(username: String) {
    self._registerData.username = username
  }
  
  func setRegisterData(password: String) {
    self._registerData.password = password
  }
  
  func setRegisterData(confirmPass: String) {
    self._confirmPass = confirmPass
  }
}
