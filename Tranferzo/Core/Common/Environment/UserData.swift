//
//  UserData.swift
//  Tranferzo
//
//  Created by Dayton on 11/03/22.
//

import Foundation

struct UserData {
  @Defaults(key: "accHolder", defaultValue: "")
  static var accHolder: String
}
