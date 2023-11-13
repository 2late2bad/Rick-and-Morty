//
//  Keychain.swift
//  Rick&Morty
//
//  Created by Alexander V. on 12.11.2023.
//

import Foundation

final class KeychainImp: Keychain {
        
    func saveCredentials(username: String, password: String) {
        if let dataFromString = password.data(using: String.Encoding.utf8) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassInternetPassword,
                kSecAttrAccount as String: username,
                kSecValueData as String: dataFromString
            ]
            
            let status = SecItemAdd(query as CFDictionary, nil)
            if status != errSecSuccess {
                #if DEBUG
                print(">DEBUG>")
                print("Ошибка сохранения в Keychain")
                #endif
            }
        }
    }
    
    func retrieveCredentials(username: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrAccount as String: username,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess {
            if let retrievedData = dataTypeRef as? Data,
               let password = String(data: retrievedData, encoding: String.Encoding.utf8) {
                return password
            }
        }
        
        return nil
    }
    
    func updatePassword(username: String, newPassword: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrAccount as String: username
        ]

        let attributes: [String: Any] = [
            kSecValueData as String: newPassword.data(using: .utf8)!
        ]

        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)

        if status != errSecSuccess {
            #if DEBUG
            print(">DEBUG>")
            print("Ошибка обновления пароля в Keychain")
            #endif
        }
    }
}
