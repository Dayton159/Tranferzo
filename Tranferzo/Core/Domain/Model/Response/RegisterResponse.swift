//
//  RegisterResponse.swift
//  Tranferzo
//
//  Created by Dayton on 13/03/22.
//

struct RegisterResponse: Codable, Equatable {
  let status: String
  let token: String
}
