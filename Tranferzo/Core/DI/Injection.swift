//
//  Injection.swift
//  Tranferzo
//
//  Created by Dayton on 11/03/22.
//

import Foundation

final class Injection: NSObject {
  private func provideLoginRepository() -> LoginRepositoryProtocol {
    let request = LoginRequest()
    let store = KeyChainStore()
    let dataSource = LoginDataSource(login: request, accessTokenStore: store)
    return LoginRepository(dataSource: dataSource)
  }
  
  private func provideDashboardRepository(
    mapper: @escaping (([TransactionResponse]) -> [TransactionEntity]),
    balanceMapper: @escaping ((BalanceResponse) -> BalanceModel)
  ) -> DashboardRepositoryProtocol {
    let balanceRequest = BalanceRequest()
    let balanceDS = BalanceDataSource(balance: balanceRequest)
    
    let transactionRequest = TransactionRequest()
    let transactionDS = TransactionDataSource(transaction: transactionRequest)
    
    return DashboardRepository(balance: balanceDS, transaction: transactionDS, mapperTransaction: mapper, mapperBalance: balanceMapper)
  }
  
  private func provideRegisterRepository() -> RegisterRepositoryProtocol {
    let request = RegisterRequest()
    let store = KeyChainStore()
    let dataSource = RegisterDataSource(register: request, accessTokenStore: store)
    return RegisterRepository(dataSource: dataSource)
  }

  func provideLoginUseCase(output: LoginInteractorOutputProtocol) -> LoginUseCase {
    let repository = self.provideLoginRepository()
    return LoginInteractor(_output: output, _repository: repository)
  }
  
  func provideDashboardUseCase(output: DashboardInteractorOutputProtocol, mapper: TransactionMapper, balanceMapper: @escaping ((BalanceResponse) -> BalanceModel)) -> DashboardUseCase {
    let repository = self.provideDashboardRepository(mapper: mapper.transformResponseToEntity(response:), balanceMapper: balanceMapper)
    
    return DashboardInteractor(output: output, repository: repository, mapper: mapper.transformEntityToDomain(entity:))
  }
  
  func provideRegisterUseCase(output: RegisterInteractorOutputProtocol) -> RegisterUseCase {
    let repository = self.provideRegisterRepository()
    return RegisterInteractor(_output: output, _repository: repository)
  }
}
