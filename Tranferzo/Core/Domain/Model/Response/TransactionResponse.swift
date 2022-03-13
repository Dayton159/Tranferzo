//
//  TransactionResponse.swift
//  Tranferzo
//
//  Created by Dayton on 12/03/22.
//

struct TransactionListResponse: Codable, Equatable {
  let status: String
  let data: [TransactionResponse]
}

struct TransactionResponse: Codable, Equatable {
  let id: String
  let amount: Double
  let date: String
  let description: String?
  let type: String
  let receipient: RecipientResponse?
  let sender: RecipientResponse?
  
  private enum CodingKeys: String, CodingKey {
    case amount, description, receipient, sender
    case id = "transactionId"
    case date = "transactionDate"
    case type = "transactionType"
  }
}

struct RecipientResponse: Codable, Equatable {
  let accNumber: String
  let accHolder: String
  
  private enum CodingKeys: String, CodingKey {
    case accNumber = "accountNo"
    case accHolder = "accountHolder"
  }
}
