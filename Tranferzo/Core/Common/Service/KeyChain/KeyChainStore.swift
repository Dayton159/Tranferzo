//
//  KeyChainStore.swift
//  Tranferzo
//
//  Created by Dayton on 10/03/22.
//

import Foundation
import Security

protocol SecretStore {
  func setValue(_ value: String, for userAccount: String) throws
  func getValue(for userAccount: String) throws -> String?
  func removeValue(for userAccount: String) throws
  func removeAllValues() throws
}

class KeyChainStore: SecretStore {
  private let keyChainStoreQueryable: KeyChainStoreQueryable
  
  init(keyChainStoreQueryable: KeyChainStoreQueryable = GenericPasswordQueryable(service: Secrets.apiServiceId)) {
    self.keyChainStoreQueryable = keyChainStoreQueryable
  }
  
  func setValue(_ value: String, for userAccount: String) throws {
    guard let encodedPassword = value.data(using: .utf8) else {
      throw KeyChainStoreError.string2DataConversionError
    }
    
    var query = keyChainStoreQueryable.query
    query[String(kSecAttrAccount)] = userAccount
    
    var status = SecItemCopyMatching(query as CFDictionary, nil)
    switch status {

    case errSecSuccess:
      var attributesToUpdate: [String: Any] = [:]
      attributesToUpdate[String(kSecValueData)] = encodedPassword
      
      status = SecItemUpdate(query as CFDictionary,
                             attributesToUpdate as CFDictionary)
      if status != errSecSuccess {
        throw error(from: status)
      }

    case errSecItemNotFound:
      query[String(kSecValueData)] = encodedPassword
      
      status = SecItemAdd(query as CFDictionary, nil)
      if status != errSecSuccess {
        throw error(from: status)
      }
    default:
      throw error(from: status)
    }
    
  }
  
  func getValue(for userAccount: String) throws -> String? {
    var query = keyChainStoreQueryable.query
    query[String(kSecMatchLimit)] = kSecMatchLimitOne
    query[String(kSecReturnAttributes)] = kCFBooleanTrue
    query[String(kSecReturnData)] = kCFBooleanTrue
    query[String(kSecAttrAccount)] = userAccount
    
    var queryResult: AnyObject?
    let status = withUnsafeMutablePointer(to: &queryResult) {
      SecItemCopyMatching(query as CFDictionary, $0)
    }
    
    switch status {

    case errSecSuccess:
      guard
        let queriedItem = queryResult as? [String: Any],
        let passwordData = queriedItem[String(kSecValueData)] as? Data,
        let password = String(data: passwordData, encoding: .utf8)
      else {
        throw KeyChainStoreError.data2StringConversionError
      }
      return password

    case errSecItemNotFound:
      return nil
    default:
      throw error(from: status)
    }
    
  }
  
  func removeValue(for userAccount: String) throws {
    var query = keyChainStoreQueryable.query
    query[String(kSecAttrAccount)] = userAccount
    
    let status = SecItemDelete(query as CFDictionary)
    guard status == errSecSuccess || status == errSecItemNotFound else {
      throw error(from: status)
    }
    
  }
  
  func removeAllValues() throws {
    let query = keyChainStoreQueryable.query
    
    let status = SecItemDelete(query as CFDictionary)
    guard status == errSecSuccess || status == errSecItemNotFound else {
      throw error(from: status)
    }
    
  }
  
  func error(from status: OSStatus) -> KeyChainStoreError {
    let message = SecCopyErrorMessageString(status, nil) as String? ?? NSLocalizedString("Unhandled Error", comment: "")
    return KeyChainStoreError.unhandledError(message: message)
  }
}
