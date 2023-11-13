//
//  ChangePassViewController.swift
//  Rick&Morty
//
//  Created by Alexander V. on 12.11.2023.
//

import UIKit

final class ChangePassViewController: UIViewController {
    
    // MARK: - Property
    let user: String
    let keychain: Keychain
    
    private let titleLabel = RMLabel(text: "Смена пароля",
                                       font: .monospacedDigitSystemFont(ofSize: 20, weight: .bold))
    
    private lazy var userLabel = RMLabel(text: "Ваш логин: \(user)",
                                           font: .monospacedDigitSystemFont(ofSize: 16, weight: .light))
    
    private let changePassTextField = RMLoginTextField(placeholder: "Ваш новый пароль",
                                                       type: .custom)
    
    private let changePassButton = RMButton(title: "Изменить пароль",
                                            font: .systemFont(ofSize: 16, weight: .semibold),
                                            style: .filled)
    
    // MARK: - Init
    init(user: String, keychain: Keychain) {
        self.user = user
        self.keychain = keychain
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        layoutUI()
        addAction()
    }
}

// MARK: - Private methods
private extension ChangePassViewController {
    
    func setupViews() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(titleLabel)
        view.addSubview(userLabel)
        view.addSubview(changePassTextField)
        view.addSubview(changePassButton)
        changePassTextField.delegate = self
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func layoutUI() {
        titleLabel.setConstraints(top: view.topAnchor,
                                  right: view.rightAnchor,
                                  left: view.leftAnchor,
                                  pTop: 20, pRight: 10, pLeft: 10)
        userLabel.setConstraints(top: titleLabel.bottomAnchor,
                                 right: view.rightAnchor,
                                 left: view.leftAnchor,
                                 pTop: 40, pRight: 10, pLeft: 10)
        changePassTextField.setConstraints(top: userLabel.bottomAnchor,
                                           right: view.rightAnchor,
                                           left: view.leftAnchor,
                                           pTop: 25, pRight: 40, pLeft: 40)
        changePassTextField.setHeightConstraint(with: 40)
        changePassButton.setConstraints(top: changePassTextField.bottomAnchor,
                                        right: view.rightAnchor,
                                        left: view.leftAnchor,
                                        pTop: 25, pRight: 40, pLeft: 40)
        changePassButton.setHeightConstraint(with: 40)
    }
    
    func addAction() {
        let changePassAction = UIAction { [weak self] _ in
            guard let self else { return }
            guard let text = changePassTextField.text, text.count > 5 else {
                self.presentAlert(message: "Пароль должен содержать не менее 6 символов",
                                  title: "Недопустимый пароль")
                return
            }
            keychain.updatePassword(username: user, newPassword: text)
            view.endEditing(true)
            UIAlertController.showSuccessAlert(
                title: "Успех!",
                message: "Вы поменяли пароль для логина \(user)",
                presentingViewController: self) { [weak self] in
                    self?.changePassTextField.isEnabled = false
                    self?.changePassButton.isEnabled = false
                    self?.dismiss(animated: true)
                }
        }
        changePassButton.addAction(changePassAction, for: .touchUpInside)
    }
}

// MARK: - TextFieldDelegate
extension ChangePassViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        changePassButton.sendActions(for: .touchUpInside)
        return true
    }
}

extension ChangePassViewController: MessageDisplayable {}
