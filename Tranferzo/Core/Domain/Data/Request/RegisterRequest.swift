//
//  RegisterRequest.swift
//  Tranferzo
//
//  Created by Dayton on 13/03/22.
//

struct RegisterRequest: APIRequest {
  typealias Response = RegisterResponse
  typealias RequestData = AuthData
  
  var pathname: String { "register" }
  var method: HTTPMethod { .post }
  
  var registerData: RequestData?
  var body: RequestData? { registerData }
}
