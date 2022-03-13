//
//  LoginRequest.swift
//  Tranferzo
//
//  Created by Dayton on 11/03/22.
//

struct LoginRequest: APIRequest {
  typealias Response = LoginResponse
  typealias RequestData = AuthData

  var pathname: String { "login" }
  var method: HTTPMethod { .post }

  var loginData: RequestData?
  var body: RequestData? { loginData }
}
