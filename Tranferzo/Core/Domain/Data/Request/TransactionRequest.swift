//
//  TransactionRequest.swift
//  Tranferzo
//
//  Created by Dayton on 12/03/22.
//

struct TransactionRequest: APIRequest {
  typealias Response = TransactionListResponse
  var pathname: String { "transactions" }
}
