//
//  KeychainServices.swift
//  patch_ios
//
//  Created by Susan Elias on 10/31/21.
//

import Foundation

struct KeychainWrapperError: Error {
  var message: String?
  var type: KeychainErrorType

  enum KeychainErrorType {
    case badData
    case servicesError
    case itemNotFound
    case unableToConvertToString
  }

  init(status: OSStatus, type: KeychainErrorType) {
    self.type = type
    if let errorMessage = SecCopyErrorMessageString(status, nil) {
      self.message = String(errorMessage)
    } else {
      self.message = "Status Code: \(status)"
    }
  }

  init(type: KeychainErrorType) {
    self.type = type
  }

  init(message: String, type: KeychainErrorType) {
    self.message = message
    self.type = type
  }
}

class KeychainWrapper {
    func storeGenericPasswordFor(
    account: String,
    service: String,
    password: String
    ) throws {
    guard let passwordData = password.data(using: .utf8) else {
      print("Error converting value to data.")
      throw KeychainWrapperError(type: .badData)
    }
      
      // build query
      let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: account,
        kSecAttrService as String: service,
        kSecValueData as String: passwordData
      ]
      
      // store data
      let status = SecItemAdd(query as CFDictionary, nil)
      switch status {
      case errSecSuccess:
        break
          
      case errSecDuplicateItem:
        try updateGenericPasswordFor(
          account: account,
          service: service,
          password: password)

      default:
        throw KeychainWrapperError(status: status, type: .servicesError)
      }

    }
    
    func getGenericPasswordFor(account: String, service: String) throws -> String {
      
      // build query
      let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: account,
        kSecAttrService as String: service,
        kSecMatchLimit as String: kSecMatchLimitOne,
        kSecReturnAttributes as String: true,
        kSecReturnData as String: true
      ]
        
        // fetch item
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status != errSecItemNotFound else {
          throw KeychainWrapperError(type: .itemNotFound)
        }
        guard status == errSecSuccess else {
          throw KeychainWrapperError(status: status, type: .servicesError)
        }

        // convert to string
        guard
          let existingItem = item as? [String: Any],
          let valueData = existingItem[kSecValueData as String] as? Data,
          let value = String(data: valueData, encoding: .utf8)
          else {
            throw KeychainWrapperError(type: .unableToConvertToString)
        }

        return value

    }

    func updateGenericPasswordFor(
      account: String,
      service: String,
      password: String
    ) throws {
      guard let passwordData = password.data(using: .utf8) else {
        print("Error converting value to data.")
        return
      }
      // Query for data to update
      let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: account,
        kSecAttrService as String: service
      ]

      // Dictionary with update data
      let attributes: [String: Any] = [
        kSecValueData as String: passwordData
      ]

      // perform update
      let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
      guard status != errSecItemNotFound else {
        throw KeychainWrapperError(
          message: "Matching Item Not Found",
          type: .itemNotFound)
      }
      guard status == errSecSuccess else {
        throw KeychainWrapperError(status: status, type: .servicesError)
      }
    }

}


