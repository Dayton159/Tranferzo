//
//  TransactionEntity.swift
//  Tranferzo
//
//  Created by Dayton on 12/03/22.
//

import Foundation

struct TransactionEntity: Equatable {
  let id: String
  let amount: Double
  let date: Date?
  let description: String
  let type: String
  let receipient: ReceipientModel
}
