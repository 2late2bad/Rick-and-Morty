//
//  LoginViewModel.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

final class LoginViewModel {
    
    var loginAuth: LoginAuth?
    
    init(loginAuth: LoginAuth?) {
        self.loginAuth = loginAuth
    }
    
    func login() {
        loginAuth?.logIn()
    }
}
