//
//  Auth.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

protocol SessionCheckerAuth {
    var isSessionActive: Bool { get }
}

protocol LoginAuth {
    func logIn()
}

protocol LogoutAuth {
    func logOut()
}

final class Auth {
    private var session = false
}

extension Auth: SessionCheckerAuth {
    var isSessionActive: Bool { session }
}

extension Auth: LoginAuth {
    func logIn() {
        session = true
    }
}

extension Auth: LogoutAuth {
    func logOut() {
        session = false
    }
}
