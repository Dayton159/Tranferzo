//
//  MockDI.swift
//  TranferzoTests
//
//  Created by Dayton on 11/03/22.
//

import Foundation
@testable import Tranferzo

final class MockDI: NSObject {
  func provideLoginRepository(with dataSource: LoginDataSourceProtocol) -> LoginRepositoryProtocol {
    return LoginRepository(dataSource: dataSource)
  }
  
  func provideDashboardRepository(balance: BalanceDataSourceProtocol, transaction: TransactionDataSourceProtocol) -> DashboardRepositoryProtocol {
    let mapper = TransactionMapper()
    
    return DashboardRepository(balance: balance, transaction: transaction, mapperTransaction: mapper.transformResponseToEntity(response:)) { response in
      return BalanceModel(
        accNumber: response.accountNo,
        balance: response.balance.asCurrency(currency: "SGD")
      )
    }
  }
  
  func provideRegisterRepository(with dataSource: RegisterDataSourceProtocol) -> RegisterRepositoryProtocol {
    return RegisterRepository(dataSource: dataSource)
  }
  
  func provideLoginUseCase(with repository: LoginRepositoryProtocol, output: LoginInteractorOutputProtocol) -> LoginUseCase {
    return LoginInteractor(_output: output, _repository: repository)
  }
  
  func provideDashboardUseCase(with repository: DashboardRepositoryProtocol, output: DashboardInteractorOutputProtocol) -> DashboardUseCase {
    let mapper = TransactionMapper()
    
    return DashboardInteractor(output: output, repository: repository, mapper: mapper.transformEntityToDomain(entity:))
  }
  
  func provideRegisterUseCase(with repository: RegisterRepositoryProtocol, output: RegisterInteractorOutputProtocol) -> RegisterUseCase {
    return RegisterInteractor(_output: output, _repository: repository)
  }
}
