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
            UserDefaults.standard.set(session, forKey: "auth")
        }
    }
    
    private var loginUser: String? {
        didSet {
            UserDefaults.standard.set(loginUser, forKey: "login_user")
        }
    }
    
    init() {
        self.session = UserDefaults.standard.bool(forKey: "auth")
        self.loginUser = UserDefaults.standard.string(forKey: "login_user")
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
