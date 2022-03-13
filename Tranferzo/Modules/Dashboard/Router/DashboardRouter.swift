//
//  DashboardRouter.swift
//  Tranferzo
//
//  Created by Dayton on 12/03/22.
//

import UIKit

final class DashboardRouter {
  private weak var rootVC: UIViewController?
  
  init(view: UIViewController) {
      self.rootVC = view
  }
  
  func logout() {
    self.rootVC?.dismiss(animated: true, completion: nil)
  }
}
