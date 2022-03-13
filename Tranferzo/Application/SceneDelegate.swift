//
//  SceneDelegate.swift
//  Tranferzo
//
//  Created by Dayton on 10/03/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  private var appCoordinator: AppCoordinator?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    window = UIWindow(frame: windowScene.coordinateSpace.bounds)
    window?.windowScene = windowScene
    
    appCoordinator = AppCoordinator(window: window!, mainRouter: self.makeMainRouter())
    appCoordinator?.start()
  }

  func sceneDidBecomeActive(_ scene: UIScene) { }


  func sceneWillEnterForeground(_ scene: UIScene) { }

  
  private func makeMainRouter() -> MainRouter {
    MainRouter()
  }
}

