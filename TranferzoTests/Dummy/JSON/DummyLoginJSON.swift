//
//  DummyLoginJSON.swift
//  TranferzoTests
//
//  Created by Dayton on 11/03/22.
//

struct DummyLoginJSON {
  static let success = """
{
    "status": "success",
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MTZlNzNlMDYyYWY0ZGQ5YmMyYzYxMWQiLCJ1c2VybmFtZSI6InRlc3QiLCJhY2NvdW50Tm8iOiIyOTcwLTExMS0zNjQ4IiwiaWF0IjoxNjQ2OTMwODE5LCJleHAiOjE2NDY5NDE2MTl9.qUniW24MeUQSzropqktgH01D51K34iEzBo-R1EV6eBo",
    "username": "test",
    "accountNo": "2970-111-3648"
}
"""
  
  static let failed = """
{
    "status": "failed",
    "error": "invalid login credential"
}
"""
}
