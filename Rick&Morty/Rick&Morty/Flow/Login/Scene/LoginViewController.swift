//
//  LoginViewController.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

import UIKit

protocol LoginViewControllerCoordinator: AnyObject {
    func didFinish()
}

final class LoginViewController: UIViewController {
    
    private weak var coordinator: LoginViewControllerCoordinator?
    private let viewModel: LoginViewModel
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Login"
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(coordinator: LoginViewControllerCoordinator?, viewModel: LoginViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        layoutUI()
        addAction()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(loginButton)
    }
    
    private func layoutUI() {
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func addAction() {
        let loginAction = UIAction { [weak self] _ in
            self?.viewModel.login()
            self?.coordinator?.didFinish()
        }
        loginButton.addAction(loginAction, for: .touchUpInside)
    }
}
