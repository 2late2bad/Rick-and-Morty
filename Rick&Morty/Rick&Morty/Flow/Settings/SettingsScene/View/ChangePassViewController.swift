//
//  ChangePassViewController.swift
//  Rick&Morty
//
//  Created by Alexander V. on 12.11.2023.
//

import UIKit

final class ChangePassViewController: UIViewController {
    
    let user: String
    let keychain: Keychain
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Смена пароля"
        label.textColor = .label
        label.textAlignment = .center
        label.font = .monospacedDigitSystemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var userLabel: UILabel = {
        let label = UILabel()
        label.text = "Ваш логин: \(user)"
        label.textColor = .label
        label.textAlignment = .center
        label.font = .monospacedDigitSystemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    private let changePassTextField = LoginTextField(placeholder: "Ваш новый пароль", type: .custom)
    
    private let changePassButton = RMButton(title: "Изменить пароль",
                                            font: .systemFont(ofSize: 16, weight: .semibold),
                                            style: .filled)
    
    init(user: String, keychain: Keychain) {
        self.user = user
        self.keychain = keychain
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        layoutUI()
        addAction()
    }
    
    private func setupViews() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(titleLabel)
        view.addSubview(userLabel)
        view.addSubview(changePassTextField)
        view.addSubview(changePassButton)
        changePassTextField.delegate = self
    }
    
    @objc private func handleTap() {
        view.endEditing(true)
    }
    
    private func layoutUI() {
        titleLabel.setConstraints(top: view.topAnchor, right: view.rightAnchor, left: view.leftAnchor, pTop: 20, pRight: 10, pLeft: 10)
        userLabel.setConstraints(top: titleLabel.bottomAnchor, right: view.rightAnchor, left: view.leftAnchor, pTop: 40, pRight: 10, pLeft: 10)
        changePassTextField.setConstraints(top: userLabel.bottomAnchor, right: view.rightAnchor, left: view.leftAnchor, pTop: 25, pRight: 40, pLeft: 40)
        changePassTextField.setHeightConstraint(with: 40)
        changePassButton.setConstraints(top: changePassTextField.bottomAnchor, right: view.rightAnchor, left: view.leftAnchor, pTop: 25, pRight: 40, pLeft: 40)
        changePassButton.setHeightConstraint(with: 40)
    }
    
    private func addAction() {
        let changePassAction = UIAction { [weak self] _ in
            guard let self else { return }
            guard let text = changePassTextField.text, text.count > 5 else {
                UIAlertController.showSuccessAlert(
                    title: "Недопустимый пароль",
                    message: "Пароль должен содержать не менее 6 символов",
                    presentingViewController: self)
                return
            }
            keychain.updatePassword(username: user, newPassword: text)
            view.endEditing(true)
            UIAlertController.showSuccessAlert(
                title: "Успех!",
                message: "Вы поменяли пароль",
                presentingViewController: self) { [weak self] in
                    self?.changePassTextField.isEnabled = false
                    self?.changePassButton.isEnabled = false
                    self?.dismiss(animated: true)
                }
        }
        changePassButton.addAction(changePassAction, for: .touchUpInside)
    }
}

extension ChangePassViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        changePassButton.sendActions(for: .touchUpInside)
        return true
    }
}
