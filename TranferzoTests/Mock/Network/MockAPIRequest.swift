//
//  MockAPIRequest.swift
//  TranferzoTests
//
//  Created by Dayton on 11/03/22.
//

@testable import Tranferzo

struct MockAPIRequest: APIRequest {
  typealias Response = MockResponse
  
  var pathname: String { "mock/path/name" }
}
