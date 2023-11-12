//
//  ItemCharacterTableViewCell.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

import UIKit

final class ItemCharacterTableViewCell: UITableViewCell {
    
    // MARK: - Property
    private let mainContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .tertiarySystemGroupedBackground
        view.setHeightConstraint(with: R.ViewValues.defaultHeightContainerCell)
        view.layer.cornerRadius = R.ViewValues.defaultCornerRadius
        view.layer.masksToBounds = true
        return view
    }()
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.setWidthConstraint(with: R.ViewValues.defaultHeightContainerCell)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let labelContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline, compatibleWith: .init(legibilityWeight: .bold))
        label.textColor = .systemBlue
        return label
    }()
    
    private let specieLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSelf()
    }
    
    private var task: Task<Void, Never>?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        task?.cancel()
    }
    
    // MARK: - Methods
    func configure(viewModel: ItemCharacterViewModel) {
        nameLabel.text = viewModel.name
        specieLabel.text = viewModel.specie
        statusLabel.text = viewModel.status
        setImage(viewModel: viewModel)
    }
    
    private func setupSelf() {
        selectionStyle = .none
        addSubview(mainContainerView)
        
        mainContainerView.setConstraints(
            top: topAnchor,
            right: rightAnchor,
            bottom: bottomAnchor,
            left: leftAnchor,
            pRight: R.ViewValues.doublePadding,
            pBottom: R.ViewValues.doublePadding,
            pLeft: R.ViewValues.doublePadding)
        mainContainerView.addSubview(characterImageView)
        characterImageView.setConstraints(
            top: mainContainerView.topAnchor,
            bottom: mainContainerView.bottomAnchor,
            left: mainContainerView.leftAnchor)
        mainContainerView.addSubview(labelContainerStackView)
        labelContainerStackView.setConstraints(
            top: mainContainerView.topAnchor,
            right: mainContainerView.rightAnchor,
            bottom: mainContainerView.bottomAnchor,
            left: characterImageView.rightAnchor,
            pTop: R.ViewValues.normalPadding,
            pBottom: R.ViewValues.normalPadding,
            pLeft: R.ViewValues.normalPadding)
        
        [nameLabel, specieLabel, statusLabel].forEach { labelContainerStackView.addArrangedSubview($0) }
    }
    
    private func setImage(viewModel: ItemCharacterViewModel) {
        characterImageView.addDefaultImage()
        if let data = viewModel.imageData {
            characterImageView.setImageFromData(data: data)
        } else {
            task = Task {
                let dataImage = await viewModel.getImageData()
                characterImageView.setImageFromData(data: dataImage)
            }
        }
    }
}

extension ItemCharacterTableViewCell: Reusable {}
