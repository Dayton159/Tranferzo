//
//  UITableView+Extension.swift
//  Tranferzo
//
//  Created by Dayton on 12/03/22.
//

import UIKit

extension UITableView {

  func registerReusableCell<T: UITableViewCell>(_: T.Type) where T: Reusable {
    if let nib = T.nib {
      self.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    } else {
      self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
  }

  func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: Reusable {
    guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T
    else { fatalError("Can't Dequeue cell \(T.self)") }

    return cell
  }
  
}
