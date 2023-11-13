//
//  LoginViewController.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

import UIKit
import Combine

protocol LoginViewControllerCoordinator: AnyObject {
    func didFinish()
}

final class LoginViewController: UIViewController {
    
    private weak var coordinator: LoginViewControllerCoordinator?
    private let viewModel: LoginViewModel
    var cancellables = Set<AnyCancellable>()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "rickmortyportal"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let loginTextField = LoginTextField(placeholder: "Введите логин", type: .username)
    private let passTextField = LoginTextField(placeholder: "Введите пароль", type: .password)
    private let repeatPassTextField = LoginTextField(placeholder: "Повторите пароль", type: .password)
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 25
        return stackView
    }()
    
    private let loginButton = RMButton(title: ".",
                                       font: .systemFont(ofSize: 16, weight: .semibold),
                                       style: .filled)
    
    private let switchButton = RMButton(title: ".",
                                             font: .systemFont(ofSize: 12, weight: .semibold),
                                             style: .plain)
    
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
        addTextFieldPublishers()
        addInteractPublishers()
        addAction()
    }
}

private extension LoginViewController {
    
    func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(logoImageView)
        view.addSubview(stackView)
        view.addSubview(loginButton)
        view.addSubview(switchButton)
        stackView.addArrangedSubview(loginTextField)
        stackView.addArrangedSubview(passTextField)
        loginTextField.delegate = self
        passTextField.delegate = self
        repeatPassTextField.delegate = self
    }
    
    func layoutUI() {
        logoImageView.setConstraints(top: view.safeAreaLayoutGuide.topAnchor, pTop: 10)
        logoImageView.centerX()
        logoImageView.setHeightConstraint(with: 180)
        logoImageView.setWidthConstraint(with: 180)
        
        stackView.setConstraints(right: view.rightAnchor, left: view.leftAnchor, pRight: 40, pLeft: 40)
        stackView.centerY()
        
        loginButton.setConstraints(top: stackView.bottomAnchor, right: view.rightAnchor, left: view.leftAnchor, pTop: 25, pRight: 40, pLeft: 40)
        loginButton.setHeightConstraint(with: 40)
        
        switchButton.setConstraints(right: view.rightAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, left: view.leftAnchor, pRight: 40, pBottom: 10, pLeft: 40)
    }
    
    // MARK: - Publishers
    func addTextFieldPublishers() {
        loginTextField.textPublisher
            .assign(to: \.login, on: viewModel)
            .store(in: &cancellables)
        
        passTextField.textPublisher
            .assign(to: \.password, on: viewModel)
            .store(in: &cancellables)
        
        repeatPassTextField.textPublisher
            .assign(to: \.repeatPass, on: viewModel)
            .store(in: &cancellables)
    }
    
    func addInteractPublishers() {
        viewModel.$isAuth
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                guard let self else { return }
                if status {
                    self.stackView.removeArrangedSubview(repeatPassTextField)
                    self.repeatPassTextField.removeFromSuperview()
                    self.repeatPassTextField.isHidden = true
                    self.loginButton.setTitleKeepingFont("Войти")
                    self.switchButton.setTitleKeepingFont("Нет аккаунта? Зарегистрироваться")
                } else {
                    self.stackView.addArrangedSubview(repeatPassTextField)
                    self.repeatPassTextField.isHidden = false
                    self.loginButton.setTitleKeepingFont("Зарегистрироваться")
                    self.switchButton.setTitleKeepingFont("Есть аккаунт? Войти")
                }
            }
            .store(in: &cancellables)
        
        viewModel.isSumbitEnabled
            .receive(on: DispatchQueue.main)
            .sink { [weak self] unlock in
                guard let self else { return }
                if unlock {
                    loginButton.isEnabled = true
                } else {
                    loginButton.isEnabled = false
                }
            }
            .store(in: &cancellables)
        
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self else { return }
                switch state {
                case .loading:
                    stackView.isUserInteractionEnabled = false
                    loginButton.isEnabled = false
                case .success(let reg):
                    if reg {
                        stackView.isUserInteractionEnabled = true
                        UIAlertController.showSuccessAlert(
                            title: "Успех",
                            message: "Вы зарегистрировали аккаунт \(viewModel.login)",
                            presentingViewController: self) { [weak self] in
                                guard let self else { return }
                                viewModel.doneRegister()
                            }
                    } else {
                        stackView.isUserInteractionEnabled = true
                        self.coordinator?.didFinish()
                    }
                case .failed(let message):
                    stackView.isUserInteractionEnabled = true
                    UIAlertController.showSuccessAlert(
                        title: "Ошибка входа",
                        message: message,
                        presentingViewController: self)
                case .none:
                    stackView.isUserInteractionEnabled = true
                }
            }
            .store(in: &cancellables)
    }
    
    func addAction() {
        let loginAction = UIAction { [weak self] _ in
            guard let self else { return }
            Task {
                await self.viewModel.submitLogin()
            }
        }
        loginButton.addAction(loginAction, for: .touchUpInside)
        
        let switchAction = UIAction { [weak self] _ in
            guard let self else { return }
            viewModel.isAuth.toggle()
        }
        switchButton.addAction(switchAction, for: .touchUpInside)
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField {
        case passTextField:
            guard let text = passTextField.text else { return }
            passTextField.eyeButton.isEnabled = !text.isEmpty
        case repeatPassTextField:
            guard let text = repeatPassTextField.text else { return }
            repeatPassTextField.eyeButton.isEnabled = !text.isEmpty
        default: break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if loginButton.isEnabled {
            loginButton.sendActions(for: .touchUpInside)
        }
        return true
    }
}
