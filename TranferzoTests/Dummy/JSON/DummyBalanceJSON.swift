//
//  DummyBalanceJSON.swift
//  TranferzoTests
//
//  Created by Dayton on 12/03/22.
//

struct DummyBalanceJSON {
  static let success = """
{
    "status": "success",
    "accountNo": "2970-111-3648",
    "balance": 43.96
}
"""
  
  static let failed = """
{
    "status": "failed",
    "error": {
        "name": "JsonWebTokenError",
        "message": "jwt malformed"
    }
}
"""
}
