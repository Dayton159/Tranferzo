//
//  AppCoordinator.swift
//  Tranferzo
//
//  Created by Dayton on 10/03/22.
//

import UIKit

class AppCoordinator {
  private let window: UIWindow
  private let mainRouter: MainRouter

  init(window: UIWindow, mainRouter: MainRouter) {
    self.window = window
    self.mainRouter = mainRouter
  }

  func start() {
    window.rootViewController = mainRouter.makeMainView()
    window.makeKeyAndVisible()

    UIView.transition(with: window,
                      duration: 0.5,
                      options: .transitionCrossDissolve,
                      animations: nil,
                      completion: nil)
  }
}
