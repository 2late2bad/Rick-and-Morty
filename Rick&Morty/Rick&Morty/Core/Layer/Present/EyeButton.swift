//
//  EyeButton.swift
//  Rick&Morty
//
//  Created by Alexander V. on 12.11.2023.
//

import UIKit

// MARK: - BAEyeButton
public final class EyeButton: UIButton {

    // MARK: - Public override init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    private func setup() {
        setImage(UIImage(systemName: "eye.slash"), for: .normal)
        tintColor = UIColor.systemGray
        widthAnchor.constraint(equalToConstant: 40).isActive = true
        isEnabled = false
    }
}
