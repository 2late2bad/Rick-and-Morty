//
//  RMButton.swift
//  Rick&Morty
//
//  Created by Alexander V. on 13.11.2023.
//

import UIKit

public class RMButton: UIButton {
    
    enum ButtonStyle {
        case filled, plain
    }
    
    init(title: String,
         font: UIFont,
         style: ButtonStyle,
         cornerRadius: CGFloat = 12,
         height: CGFloat = 40)
    {
        super.init(frame: .zero)
        
        var configuration: UIButton.Configuration
        
        switch style {
        case .filled:
            configuration = UIButton.Configuration.filled()
            configuration.baseBackgroundColor = UIColor.systemGreen
            configuration.baseForegroundColor = .label
            configuration.background.cornerRadius = cornerRadius
        case .plain:
            configuration = UIButton.Configuration.plain()
            configuration.baseForegroundColor = .systemBlue
        }
        
        var container = AttributeContainer()
        container.font = font
        configuration.attributedTitle = AttributedString(title, attributes: container)
        
        self.configuration = configuration
        setHeightConstraint(with: height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
