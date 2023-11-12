//
//  LoginViewModel.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

import Foundation
import Combine

final class LoginViewModel: ObservableObject {

    // MARK: - View state
    enum ViewState {
        case loading
        case success
        case failed(String)
        case none
    }

    // MARK: - Properties
    private var loginAuth: LoginAuth?
    private let keychain: Keychain
    @Published var isAuth: Bool = true
    @Published var login = ""
    @Published var password = ""
    @Published var repeatPass = ""
    @Published var state: ViewState = .none

    // MARK: - Init
    init(loginAuth: LoginAuth?, keychain: Keychain) {
        self.loginAuth = loginAuth
        self.keychain = keychain
    }

    // MARK: - Publishers
    var statusPublisher: AnyPublisher<Bool, Never> {
        $isAuth
            .map { $0 }
            .eraseToAnyPublisher()
    }

    var isValidLoginPublisher: AnyPublisher<Bool, Never> {
        $login
            .map { !$0.isEmpty && $0.count > 5 }
            .eraseToAnyPublisher()
    }

    var isValidPasswordPublisher: AnyPublisher<Bool, Never> {
        $password
            .map { !$0.isEmpty && $0.count > 5 }
            .eraseToAnyPublisher()
    }

    var isValidRepeatPasswordPublisher: AnyPublisher<Bool, Never> {
        $repeatPass
            .map { !$0.isEmpty && $0.count > 5 }
            .eraseToAnyPublisher()
    }

    var validatedPasswords: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest($password, $repeatPass)
            .map { pass, repeatPass in
                guard pass == repeatPass, pass.count > 5 else { return false }
                return true
            }
            .eraseToAnyPublisher()
    }

    var isSumbitEnabled: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest4(statusPublisher,
                                  isValidLoginPublisher,
                                  isValidPasswordPublisher,
                                  validatedPasswords)
        .map { auth, emailCorrect, passCorrect, allPassCorrect in
            switch auth {
            case true:
                return emailCorrect && passCorrect
            case false:
                return emailCorrect && allPassCorrect
            }
        }
        .eraseToAnyPublisher()
    }

    // MARK: - Methods
    @MainActor
    func submitLogin() async {
        state = .loading

        if isAuth {
            if password == keychain.retrieveCredentials(username: login) {
                loginAuth?.logIn(user: login)
                self.state = .success
            } else {
                self.state = .failed("Некорректный логин или пароль")
            }
        } else {
            keychain.saveCredentials(username: login, password: password)
            state = .success
        }
    }
}
