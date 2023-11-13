//
//  ItemCharacterTableViewCell.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

import UIKit

final class ItemCharacterTableViewCell: UITableViewCell {
    
    // MARK: - Property
    private var task: Task<Void, Never>?

    private let mainContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
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
        label.textColor = .systemMint
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let specieLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        return label
    }()

    private let genderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .preferredFont(forTextStyle: .footnote, compatibleWith: .init(legibilityWeight: .regular))
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
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override methods
    override func prepareForReuse() {
        super.prepareForReuse()
        task?.cancel()
    }
    
    // MARK: - Configure
    func configure(viewModel: ItemCharacterViewModel) {
        nameLabel.text = viewModel.name
        statusLabel.text = viewModel.status
        specieLabel.text = viewModel.specie
        genderLabel.text = viewModel.gender
        setImage(viewModel: viewModel)
    }
    
    // MARK: - Private methods
    private func setupSelf() {
        selectionStyle = .none
        addSubview(mainContainerView)
    }
    
    private func layoutUI() {
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
        mainContainerView.addSubview(statusLabel)
        statusLabel.setConstraints(right: mainContainerView.rightAnchor,
                                   pRight: 10)
        statusLabel.centerY()
        statusLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        mainContainerView.addSubview(labelContainerStackView)
        labelContainerStackView.setConstraints(
            top: mainContainerView.topAnchor,
            right: statusLabel.leftAnchor,
            bottom: mainContainerView.bottomAnchor,
            left: characterImageView.rightAnchor,
            pTop: R.ViewValues.normalPadding,
            pRight: 10,
            pBottom: R.ViewValues.normalPadding,
            pLeft: R.ViewValues.normalPadding)
        
        [nameLabel, specieLabel, genderLabel].forEach { labelContainerStackView.addArrangedSubview($0) }
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
