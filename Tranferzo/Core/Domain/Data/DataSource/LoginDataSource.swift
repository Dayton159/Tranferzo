//
//  LoginDataSource.swift
//  Tranferzo
//
//  Created by Dayton on 11/03/22.
//

import Combine

protocol LoginDataSourceProtocol: AnyObject {
  func authenticateUser(data: AuthData) -> AnyPublisher<String, APIServiceError>
}

final class LoginDataSource {
  private var _login: LoginRequest
  private let _accessTokenStore: SecretStore
  
  init(login: LoginRequest, accessTokenStore: SecretStore) {
    self._login = login
    self._accessTokenStore = accessTokenStore
  }
}

extension LoginDataSource: LoginDataSourceProtocol {
  func authenticateUser(data: AuthData) -> AnyPublisher<String, APIServiceError> {
    self._login.loginData = data
    return API()
      .fetch(_login)
      .tryMap{ result in
        // Save token to KeyChain
        try self._accessTokenStore.setValue(result.token, for: Secrets.authJwtToken)
        // Save AccountHolder
        UserData.accHolder = result.username
        
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
