//
//  ErrorModel.swift
//  Tranferzo
//
//  Created by Dayton on 10/03/22.
//

import Foundation

struct ErrorResponse: Codable {
  let status: String
  let error: String
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    status = try container.decode(String.self, forKey: .status)

    if let error = try? container.decode(ErrorBody.self, forKey: .error) {
      self.error = error.message.capitalized
    } else {
      self.error = try container.decode(String.self, forKey: .error).capitalized
    }
  }
}

struct ErrorBody:Codable {
  let name: String
  let message: String
}
