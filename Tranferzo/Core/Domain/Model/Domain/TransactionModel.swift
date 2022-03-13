//
//  TransactionModel.swift
//  Tranferzo
//
//  Created by Dayton on 12/03/22.
//

struct TransactionModel: Equatable {
  let id: String
  let amount: String
  let date: String
  let description: String
  let type: String
  let receipient: ReceipientModel
}
