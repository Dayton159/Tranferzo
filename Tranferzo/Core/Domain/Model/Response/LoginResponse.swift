//
//  LoginResponse.swift
//  Tranferzo
//
//  Created by Dayton on 11/03/22.
//

struct LoginResponse: Codable, Equatable {
  let status: String
  let token: String
  let username:String
  let accountNo: String
}
