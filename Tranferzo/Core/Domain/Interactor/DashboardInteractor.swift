//
//  DashboardInteractor.swift
//  Tranferzo
//
//  Created by Dayton on 12/03/22.
//

import Combine

protocol DashboardInteractorOutputProtocol: BaseInteractorOutputProtocol {
  func didLoad(with transaction: [[TransactionModel]])
  func didLoad(with balance: BalanceModel)
}

protocol DashboardUseCase: AnyObject {
  func getBalance()
  func getTransaction()
}

final class DashboardInteractor: BaseInteractor {
  private let _output: DashboardInteractorOutputProtocol
  private let _repository: DashboardRepositoryProtocol
  private let _mapper: (([TransactionEntity]) -> [[TransactionModel]])
  
  init(
    output: DashboardInteractorOutputProtocol,
    repository: DashboardRepositoryProtocol,
    mapper: @escaping (([TransactionEntity]) -> [[TransactionModel]])
  ) {
    self._output = output
    self._repository = repository
    self._mapper = mapper
  }
}

extension DashboardInteractor: DashboardUseCase {
  func getBalance() {
    _output.updateState(with: .loading)
    _repository.getBalance()
      .sink(receiveCompletion: { errorData in
        switch errorData {
        case .failure(let error):
          self._output.updateState(with: .error)
          self._output.didFail(with: error.errorMessage)
        default: break
        }
      }, receiveValue: { result in
        self._output.didLoad(with: result)
        self._output.updateState(with: .finish)
      })
      .store(in: &cancellables)
  }
  
  func getTransaction() {
    _output.updateState(with: .loading)
    _repository.getTransaction()
      .map { self._mapper($0) }
      .sink(receiveCompletion: { errorData in
        switch errorData {
        case .failure(let error):
          self._output.updateState(with: .error)
          self._output.didFail(with: error.errorMessage)
        default: break
        }
      }, receiveValue: { result in
        self._output.didLoad(with: result)
        self._output.updateState(with: .finish)
      })
      .store(in: &cancellables)
  }
}
