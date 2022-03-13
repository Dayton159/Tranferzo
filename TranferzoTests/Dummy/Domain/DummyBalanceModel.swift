//
//  DummyBalanceModel.swift
//  TranferzoTests
//
//  Created by Dayton on 12/03/22.
//

@testable import Tranferzo

extension BalanceModel {
  static var dummy: BalanceModel {
    .init(
      accNumber: "2970-111-3648",
      balance: "SGD 3.46"
    )
  }
}
