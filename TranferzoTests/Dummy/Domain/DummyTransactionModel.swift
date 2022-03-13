//
//  DummyTransactionModel.swift
//  TranferzoTests
//
//  Created by Dayton on 12/03/22.
//

@testable import Tranferzo

extension TransactionModel {
  static var dummyList: [[TransactionModel]] {
    .init(
      [
        [
          .init(
            id: "622cd6718c7f3a5bcccf8cdc",
            amount: "S$100,000.00",
            date: "12 Mar 2022",
            description: "Default money-in transaction",
            type: "received",
            receipient: ReceipientModel(
              accNumber:"1111-111-1111",
              accHolder: "Jane"
            )
          ),
          .init(
            id: "622c14780e2a338413ff19e5",
            amount: "S$20.00",
            date: "12 Mar 2022",
            description: "test",
            type: "transfer",
            receipient: ReceipientModel(
              accNumber:"6554-630-9653",
              accHolder: "Andy"
            )
          )
        ],
        [
          .init(
            id: "622ba0266297f0429081b477",
            amount: "S$10.50",
            date: "11 Mar 2022",
            description: "testing",
            type: "transfer",
            receipient: ReceipientModel(
              accNumber: "6554-630-9653",
              accHolder: "Andy"
            )
          )
        ],
        [
          .init(
            id: "6229e89b59a4124e14221bf7",
            amount: "S$12.00",
            date: "Unknown",
            description: "Not Available",
            type: "transfer",
            receipient: ReceipientModel(
              accNumber: "-",
              accHolder: ""
            )
          )
        ]
      ]
    )
  }
}
