//
//  DummyRegisterJSON.swift
//  TranferzoTests
//
//  Created by Dayton on 13/03/22.
//

struct DummyRegisterJSON {
  static let success = """
{
    "status": "success",
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MjJjZDY3MThjN2YzYTViY2NjZjhjZGEiLCJ1c2VybmFtZSI6IkpvaG4gRG9lIiwiYWNjb3VudE5vIjoiMDM4NC01ODQtMzA3OSIsImlhdCI6MTY0NzEwNTY0OSwiZXhwIjoxNjQ3MTE2NDQ5fQ.LvkswKzjNm5dSiBRgA7sMY5WeaA4z4pTJ67GDQvb6ts"
}
"""
  
  static let failed = """
{
    "status": "failed",
    "error": "username already exists"
}
"""
}
