//
//  DummyBalanceResponse.swift
//  TranferzoTests
//
//  Created by Dayton on 12/03/22.
//

@testable import Tranferzo

extension BalanceResponse {
  static var dummy: BalanceResponse {
    .init(
      status: "success",
      accountNo: "2970-111-3648",
      balance: 3.46
    )
  }
}
