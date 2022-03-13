//
//  MainRouter.swift
//  Tranferzo
//
//  Created by Dayton on 10/03/22.
//

import UIKit

class MainRouter {
  func makeMainView() -> UIViewController {
    let view = LoginView()
    let router = self.makeLoginRouter(from: view)
    let presenter = LoginPresenter(interface: view)
    let interactor = Injection.init().provideLoginUseCase(output: presenter)
    
    view.setUsernameData = interactor.setLoginData(username:)
    view.setPasswordData = interactor.setLoginData(password:)
    
    view.authenticateUser = interactor.authenticateUser
    view.authSuccess = router.navigateToDashboard
    view.signUpSelected = router.navigateToSignUp
    
    return UINavigationController(rootViewController: view)
  }
  
  func makeLoginRouter(from view: UIViewController) -> LoginRouter {
    LoginRouter(view: view)
  }
}
