//
//  RegisterRepository.swift
//  Tranferzo
//
//  Created by Dayton on 13/03/22.
//

import Combine

protocol RegisterRepositoryProtocol: AnyObject {
  func registerUser(data: AuthData) -> AnyPublisher<String, APIServiceError>
}

final class RegisterRepository {
  private let _dataSource: RegisterDataSourceProtocol
  
  init(dataSource: RegisterDataSourceProtocol) {
    self._dataSource = dataSource
  }
}

extension RegisterRepository: RegisterRepositoryProtocol {
  func registerUser(data: AuthData) -> AnyPublisher<String, APIServiceError> {
    return _dataSource.registerUser(data: data)
      .map { $0.capitalized }
      .eraseToAnyPublisher()
  }
}
