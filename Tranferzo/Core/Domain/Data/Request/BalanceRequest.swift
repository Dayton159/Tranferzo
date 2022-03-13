//
//  BalanceRequest.swift
//  Tranferzo
//
//  Created by Dayton on 12/03/22.
//

struct BalanceRequest: APIRequest {
  typealias Response = BalanceResponse
  var pathname: String { "balance" }
}
