//
//  EpisodeCell.swift
//  Rick&Morty
//
//  Created by Alexander V. on 10.11.2023.
//

import UIKit

final class EpisodeCell: UICollectionViewCell {
    
    private let episodeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .label
        label.numberOfLines = 4
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .caption2)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [episodeLabel, nameLabel, dateLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = contentView.bounds
        gradientLayer.colors = [UIColor.systemPink.cgColor, UIColor.systemPurple.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.cornerRadius = 20
        return gradientLayer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 20
    }
    
    func configure(with episode: Episode) {
        episodeLabel.text = episode.episode
        nameLabel.text = episode.name
        dateLabel.text = episode.airDate
    }
    
    private func setupSelf() {
        contentView.addSubview(stackView)
        stackView.setConstraints(top: topAnchor,
                                 right: rightAnchor,
                                 bottom: bottomAnchor,
                                 left: leftAnchor,
                                 pTop: 20, pRight: 10, pBottom: 20, pLeft: 10)
        contentView.layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension EpisodeCell: Reusable {}
