//
//  DummyLoginData.swift
//  TranferzoTests
//
//  Created by Dayton on 11/03/22.
//

@testable import Tranferzo

extension AuthData {
  static var dummy: AuthData {
    .init(username: "dummyUsername", password: "dummyPassword")
  }
}
