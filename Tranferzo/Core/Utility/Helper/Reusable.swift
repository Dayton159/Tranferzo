//
//  Reusable.swift
//  Tranferzo
//
//  Created by Dayton on 12/03/22.
//

import UIKit

protocol Reusable: AnyObject {
  static var reuseIdentifier: String { get }
  static var nib: UINib? { get }
}

extension Reusable {
  static var reuseIdentifier: String {
    String(describing: self)
  }
  
  static var nib: UINib? { UINib(nibName: String(describing: self), bundle: nil) }
}
