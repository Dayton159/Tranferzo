//
//  BalanceResponse.swift
//  Tranferzo
//
//  Created by Dayton on 12/03/22.
//

struct BalanceResponse: Codable, Equatable {
  let status: String
  let accountNo: String
  let balance: Double
}
