//
//  Auth.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

import Foundation

protocol SessionCheckerAuth {
    var isSessionActive: Bool { get }
}

protocol LoginAuth {
    var user: String { get }
    func logIn(user: String)
}

protocol LogoutAuth {
    func logOut()
}

final class Auth {
    private var session: Bool {
        didSet {
            UserDefaults.standard.set(session, forKey: R.UDKeys.auth)
        }
    }
    
    private var loginUser: String? {
        didSet {
            UserDefaults.standard.set(loginUser, forKey: R.UDKeys.loginUser)
        }
    }
    
    init() {
        self.session = UserDefaults.standard.bool(forKey: R.UDKeys.auth)
        self.loginUser = UserDefaults.standard.string(forKey: R.UDKeys.loginUser)
    }
}

extension Auth: SessionCheckerAuth {
    var isSessionActive: Bool { session }
}

extension Auth: LoginAuth {
    var user: String {
        loginUser ?? ""
    }
        
    func logIn(user: String) {
        session = true
        loginUser = user
    }
}

extension Auth: LogoutAuth {
    func logOut() {
        session = false
        loginUser = nil
    }
}
