//
//  Delay.swift
//  Tranferzo
//
//  Created by Dayton on 11/03/22.
//

import Foundation

struct Delay {
  static func wait(delay: Double = 0.2, completion: @escaping() -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
      completion()
    }
  }
}
