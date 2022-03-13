//
//  DummyTransactionEntity.swift
//  TranferzoTests
//
//  Created by Dayton on 12/03/22.
//

@testable import Tranferzo

extension TransactionEntity {
  static var dummyList: [TransactionEntity] {
    .init(
      [
        .init(
          id: "622cd6718c7f3a5bcccf8cdc",
          amount: 100000,
          date: DateFormatter.JSONResponse.dateFromString("2022-03-12T17:20:49.718Z"),
          description: "Default money-in transaction",
          type: "received",
          receipient: ReceipientModel(
            accNumber:"1111-111-1111",
            accHolder: "Jane"
          )
        ),
        .init(
          id: "622c14780e2a338413ff19e5",
          amount: 20,
          date: DateFormatter.JSONResponse.dateFromString("2022-03-12T03:33:12.448Z"),
          description: "test",
          type: "transfer",
          receipient: ReceipientModel(
            accNumber:"6554-630-9653",
            accHolder: "Andy"
          )
        ),
        .init(
          id: "622ba0266297f0429081b477",
          amount: 10.5,
          date: DateFormatter.JSONResponse.dateFromString("2022-03-11T19:16:54.933Z"),
          description: "testing",
          type: "transfer",
          receipient: ReceipientModel(
            accNumber: "6554-630-9653",
            accHolder: "Andy"
          )
        ),
        .init(
          id: "6229e89b59a4124e14221bf7",
          amount: 12,
          date: DateFormatter.JSONResponse.dateFromString("11-03-2022"),
          description: "Not Available",
          type: "transfer",
          receipient: ReceipientModel(
            accNumber: "-",
            accHolder: ""
          )
        )
      ]
    )
  }
}
