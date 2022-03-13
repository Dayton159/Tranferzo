//
//  RegisterDataSource.swift
//  Tranferzo
//
//  Created by Dayton on 13/03/22.
//

import Combine

protocol RegisterDataSourceProtocol: AnyObject {
  func registerUser(data: AuthData) -> AnyPublisher<String, APIServiceError>
}

final class RegisterDataSource {
  private var _register: RegisterRequest
  private let _accessTokenStore: SecretStore
  
  init(register: RegisterRequest, accessTokenStore: SecretStore) {
    self._register = register
    self._accessTokenStore = accessTokenStore
  }
}

extension RegisterDataSource: RegisterDataSourceProtocol {
  func registerUser(data: AuthData) -> AnyPublisher<String, APIServiceError> {
    self._register.registerData = data
    return API()
      .fetch(_register)
      .tryMap { result in
        // Save token to KeyChain
        try self._accessTokenStore.setValue(result.token, for: Secrets.authJwtToken)
        // Save AccountHolder
        UserData.accHolder = data.username
        
        return result.status
      }.mapError {
        guard let authError = $0 as? APIServiceError else {
          // Failure from saving to Keychain
          return APIServiceError.custom($0)
        }
        return authError
      }
      .eraseToAnyPublisher()
  }
}
