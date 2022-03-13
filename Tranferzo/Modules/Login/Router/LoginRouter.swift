//
//  LoginRouter.swift
//  Tranferzo
//
//  Created by Dayton on 11/03/22.
//

import UIKit

final class LoginRouter {
  
  private weak var rootVC: UIViewController?
  
  init(view: UIViewController) {
      self.rootVC = view
  }
  
  func navigateToDashboard(status: String) {
    let store = KeyChainStore()
    let view = DashboardView(status: "Login \(status)", secrets: store)
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
  
  func navigateToSignUp() {
    let view = RegisterView()
    let router = self.makeRegisterRouter(from: view)
    let presenter = RegisterPresenter(interface: view)
    let interactor = Injection.init().provideRegisterUseCase(output: presenter)
    
    view.setUsernameData = interactor.setRegisterData(username:)
    view.setPasswordData = interactor.setRegisterData(password:)
    view.setConfirmPasswordData = interactor.setRegisterData(confirmPass:)
    
    view.registerUser = interactor.registerUser
    view.registerSuccess = router.navigateToDashboard(status:)
    view.loginSelected = router.navigateToLogin
    
    rootVC?.show(view, sender: rootVC)
  }
  
  func makeDashboardRouter(from view: UIViewController) -> DashboardRouter {
    DashboardRouter(view: view)
  }
  
  func makeRegisterRouter(from view: UIViewController) -> RegisterRouter {
    RegisterRouter(view: view)
  }
}
