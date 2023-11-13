//
//  Keychain.swift
//  Rick&Morty
//
//  Created by Alexander V. on 12.11.2023.
//

protocol Keychain {
    func saveCredentials(username: String, password: String)
    func retrieveCredentials(username: String) -> String?
    func updatePassword(username: String, newPassword: String)
}
