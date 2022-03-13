//
//  LoginRepository.swift
//  Tranferzo
//
//  Created by Dayton on 11/03/22.
//

import Combine

protocol LoginRepositoryProtocol: AnyObject {
  func authenticateUser(data: AuthData) -> AnyPublisher<String, APIServiceError>
}

final class LoginRepository {
  private let _dataSource: LoginDataSourceProtocol
  
  init(dataSource: LoginDataSourceProtocol) {
    self._dataSource = dataSource
  }
}

extension LoginRepository: LoginRepositoryProtocol {
  func authenticateUser(data: AuthData) -> AnyPublisher<String, APIServiceError> {
    return _dataSource.authenticateUser(data: data)
      .map { $0.capitalized }
      .eraseToAnyPublisher()
  }
}
