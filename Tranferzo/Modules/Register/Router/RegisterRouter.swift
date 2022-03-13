//
//  RegisterRouter.swift
//  Tranferzo
//
//  Created by Dayton on 13/03/22.
//

import UIKit

class RegisterRouter {
  
  private weak var rootVC: UIViewController?
  
  init(view: UIViewController) {
      self.rootVC = view
  }
  
  func navigateToDashboard(status: String) {
    let store = KeyChainStore()
    let view = DashboardView(status: "Register \(status)", secrets: store)
    let router = self.makeDashboardRouter(from: view)
    let presenter = DashboardPresenter(interface: view)
    let mapper = TransactionMapper()
    let interactor = Injection.init().provideDashboardUseCase(output: presenter, mapper: mapper) { response in
      return BalanceModel(
        accNumber: response.accountNo,
        balance: response.balance.asCurrency(currency: "SGD")
      )
    }
    
    view.loadBalances = interactor.getBalance
    view.loadTransactions = interactor.getTransaction
    view.logOutSelected = router.logout
    
    let nav = UINavigationController(rootViewController: view)
    nav.modalPresentationStyle = .fullScreen
    rootVC?.show(nav, sender: rootVC)
  }
  
  func navigateToLogin() {
    rootVC?.navigationController?.popViewController(animated: true)
  }
  
  func makeDashboardRouter(from view: UIViewController) -> DashboardRouter {
    DashboardRouter(view: view)
  }
}
