//
//  CharacterDetailViewController.swift
//  Rick&Morty
//
//  Created by Alexander V. on 09.11.2023.
//

import UIKit
import Combine

protocol CharacterDetailViewControllerCoordinator {
    func didTapOriginButton()
    func didTapLocationButton()
}

final class CharacterDetailViewController: UIViewController {
    
    private var cancellables = Set<AnyCancellable>()
    private let viewModel: CharacterDetailViewModel
    private let coordinator: CharacterDetailViewControllerCoordinator
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.addDefaultImage()
        imageView.contentMode = .scaleAspectFill
        imageView.setHeightConstraint(with: UIScreen.main.bounds.width)
        return imageView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = R.ViewValues.defaultCornerRadius * 2
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name Test"
        label.font = .preferredFont(forTextStyle: .title2)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var statusLabel: UILabel = makeGrayLabels(text: "Status: Test")
    private lazy var specieLabel: UILabel = makeGrayLabels(text: "Specie: Test")
    private lazy var genderLabel: UILabel = makeGrayLabels(text: "Gender: Test")
    
    private lazy var originButton: UIButton = makeSubtitleBlueButton(title: "Origin", subtitle: "Earth")
    private lazy var loactionButton: UIButton = makeSubtitleBlueButton(title: "Location", subtitle: "Citadel")
    
    init(viewModel: CharacterDetailViewModel,
         coordinator: CharacterDetailViewControllerCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        stateController()
        configureTargets()
        viewModel.viewDidLoad()
    }
}

private extension CharacterDetailViewController {
    
    func setupView() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
        
        view.addSubview(characterImageView)
        characterImageView.setConstraints(top: view.safeAreaLayoutGuide.topAnchor,
                                          right: view.rightAnchor,
                                          left: view.leftAnchor)
        view.addSubview(containerView)
        containerView.setConstraints(top: characterImageView.bottomAnchor,
                                     right: view.rightAnchor,
                                     bottom: view.bottomAnchor,
                                     left: view.leftAnchor,
                                     pTop: -15)
        containerView.addSubview(nameLabel)
        nameLabel.setConstraints(top: containerView.topAnchor,
                                 right: containerView.rightAnchor,
                                 left: containerView.leftAnchor,
                                 pTop: R.ViewValues.normalPadding)
        containerView.addSubview(statusLabel)
        statusLabel.setConstraints(top: nameLabel.bottomAnchor,
                                 right: containerView.rightAnchor,
                                 left: containerView.leftAnchor,
                                 pTop: 5)
        containerView.addSubview(specieLabel)
        specieLabel.setConstraints(top: statusLabel.bottomAnchor,
                                 right: containerView.rightAnchor,
                                 left: containerView.leftAnchor,
                                 pTop: 5)
        containerView.addSubview(genderLabel)
        genderLabel.setConstraints(top: specieLabel.bottomAnchor,
                                 right: containerView.rightAnchor,
                                 left: containerView.leftAnchor,
                                 pTop: 5)
        let buttonStackView = UIStackView(arrangedSubviews: [originButton, loactionButton])
        buttonStackView.axis = .vertical
        buttonStackView.spacing = R.ViewValues.normalPadding
        containerView.addSubview(buttonStackView)
        buttonStackView.setConstraints(top: genderLabel.bottomAnchor,
                                       right: containerView.rightAnchor,
                                       left: containerView.leftAnchor,
                                       pTop: R.ViewValues.normalPadding,
                                       pRight: R.ViewValues.doublePadding,
                                       pLeft: R.ViewValues.doublePadding)
    }
    
    func stateController() {
        viewModel
            .state
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                self?.hideSpinner()
                switch state {
                case .success:
                    self?.configureSelf()
                case .loading:
                    self?.showSpinner()
                case .fail(error: let error):
                    self?.presentAlert(message: error, title: "Error")
                }
            }
            .store(in: &cancellables)
    }
    
    private func configureSelf() {
        nameLabel.text = viewModel.nameCharacter
        statusLabel.text = viewModel.status
        specieLabel.text = viewModel.specie
        characterImageView.setImageFromData(data: viewModel.imageData)
        originButton.configuration?.subtitle = viewModel.origin
        loactionButton.configuration?.subtitle = viewModel.location
    }
    
    private func configureTargets() {
        originButton.addTarget(self, action: #selector(didTapOriginButton), for: .touchUpInside)
        loactionButton.addTarget(self, action: #selector(didTapLocationButton), for: .touchUpInside)
    }
    
    func makeGrayLabels(text: String) -> UILabel {
        let label = UILabel()
        label.text = "Status: Test"
        label.textColor = .systemGray
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .center
        return label
    }
    
    func makeSubtitleBlueButton(title: String, subtitle: String) -> UIButton {
        let button = UIButton(type: .system)
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.subtitle = subtitle
        configuration.buttonSize = .small
        configuration.titleAlignment = .center
        configuration.cornerStyle = .large
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.preferredFont(forTextStyle: .headline)
            return outgoing
        }
        configuration.subtitleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.preferredFont(forTextStyle: .subheadline)
            return outgoing
        }
        button.configuration = configuration
        return button
    }
    
    @objc func didTapOriginButton() {
        coordinator.didTapOriginButton()
    }
    
    @objc func didTapLocationButton() {
        coordinator.didTapLocationButton()
    }
}

extension CharacterDetailViewController: SpinnerDisplayable {}
extension CharacterDetailViewController: MessageDisplayable {}
