//
//  MockResponse.swift
//  TranferzoTests
//
//  Created by Dayton on 11/03/22.
//

import Foundation

struct MockResponse: Codable, Equatable {
  let status: String
  let accountNo: String
  let balance: Double
}
