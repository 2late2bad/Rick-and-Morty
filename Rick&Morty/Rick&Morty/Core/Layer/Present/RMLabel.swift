//
//  RMLabel.swift
//  Rick&Morty
//
//  Created by Alexander V. on 13.11.2023.
//

import UIKit

open class RMLabel: UILabel {
    
    // MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupSelf()
    }
    
    convenience init(text: String,
                     font: UIFont,
                     color: UIColor = .label,
                     alignment: NSTextAlignment = .center,
                     lines: Int = 1) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.textColor = color
        self.textAlignment = alignment
        self.numberOfLines = lines
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setupSelf() {
        translatesAutoresizingMaskIntoConstraints = false
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.8
        lineBreakMode = .byTruncatingTail
    }
}
