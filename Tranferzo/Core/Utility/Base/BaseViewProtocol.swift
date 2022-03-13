//
//  BaseViewProtocol.swift
//  Tranferzo
//
//  Created by Dayton on 11/03/22.
//

enum NetworkState: Equatable {
  case loading
  case finish
  case error
}

extension NetworkState {
  var isFinished: Bool {
      guard case .finish = self else { return false }
      return true
  }
}

protocol BaseInteractorOutputProtocol: AnyObject {
  func updateState(with state: NetworkState)
  func didFail(with message: String)
}

protocol BaseViewProtocol: AnyObject {
  func showError(by message: String)
  func state(_ state: NetworkState)
}
