//
//  KeyChainStoreError.swift
//  Tranferzo
//
//  Created by Dayton on 10/03/22.
//

import Foundation

enum KeyChainStoreError: Error {
  case string2DataConversionError
  case data2StringConversionError
  case unhandledError(message: String)
}

extension KeyChainStoreError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .string2DataConversionError:
      return NSLocalizedString("String to Data conversion error", comment: "")
    case .data2StringConversionError:
      return NSLocalizedString("Data to String conversion error", comment: "")
    case .unhandledError(let message):
      return NSLocalizedString(message, comment: "")
    }
  }
}
