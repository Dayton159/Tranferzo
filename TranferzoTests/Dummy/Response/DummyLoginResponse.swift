//
//  DummyLoginResponse.swift
//  TranferzoTests
//
//  Created by Dayton on 11/03/22.
//

@testable import Tranferzo

extension LoginResponse {
  static var dummy: LoginResponse {
    .init(
      status: "success",
      token: "artsdgfdfsdw123456",
      username: "user",
      accountNo: "123-456-789"
    )
  }
}
