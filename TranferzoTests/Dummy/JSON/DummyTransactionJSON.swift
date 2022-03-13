//
//  DummyTransactionJSON.swift
//  TranferzoTests
//
//  Created by Dayton on 12/03/22.
//

struct DummyTransactionJSON {
  static let success = """
{
    "status": "success",
    "data": [
        {
            "transactionId": "622cd6718c7f3a5bcccf8cdc",
            "amount": 100000,
            "transactionDate": "2022-03-12T17:20:49.718Z",
            "description": "Default money-in transaction",
            "transactionType": "received",
            "sender": {
                "accountNo": "1111-111-1111",
                "accountHolder": "Jane"
            }
        },
        {
            "transactionId": "622c14780e2a338413ff19e5",
            "amount": 20,
            "transactionDate": "2022-03-12T03:33:12.448Z",
            "description": "test",
            "transactionType": "transfer",
            "receipient": {
                "accountNo": "6554-630-9653",
                "accountHolder": "Andy"
            }
        },
        {
            "transactionId": "622ba0266297f0429081b477",
            "amount": 10.5,
            "transactionDate": "2022-03-11T19:16:54.933Z",
            "description": "testing",
            "transactionType": "transfer",
            "receipient": {
                "accountNo": "6554-630-9653",
                "accountHolder": "Andy"
            }
        },
        {
            "transactionId": "622b36b8b8ebff581462da5d",
            "amount": 2,
            "transactionDate": "2022-03-11T11:47:04.706Z",
            "description": null,
            "transactionType": "transfer",
            "receipient": {
                "accountNo": "6554-630-9653",
                "accountHolder": "Andy"
            }
        },
        {
            "transactionId": "622b2795bcc5ae6bdce8c26f",
            "amount": 1,
            "transactionDate": "2022-03-11T10:42:29.275Z",
            "description": "1",
            "transactionType": "transfer",
            "receipient": {
                "accountNo": "6554-630-9653",
                "accountHolder": "Andy"
            }
        },
        {
            "transactionId": "622a77777177e4d2a91dc535",
            "amount": 10,
            "transactionDate": "2022-03-10T22:11:03.882Z",
            "description": "nice",
            "transactionType": "transfer",
            "receipient": {
                "accountNo": "2833-703-6351",
                "accountHolder": "Mohammed"
            }
        },
        {
            "transactionId": "622a1b14a5545747094f6fa8",
            "amount": 1,
            "transactionDate": "2022-03-10T15:36:52.413Z",
            "description": "t",
            "transactionType": "transfer",
            "receipient": {
                "accountNo": "1265-467-6977",
                "accountHolder": "Elsie"
            }
        },
        {
            "transactionId": "622a18fda5545747094f6f19",
            "amount": 1,
            "transactionDate": "2022-03-10T15:27:57.536Z",
            "description": "yes",
            "transactionType": "transfer",
            "receipient": {
                "accountNo": "2833-703-6351",
                "accountHolder": "Mohammed"
            }
        }
    ]
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
