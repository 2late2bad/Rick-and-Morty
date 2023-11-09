//
//  CharacterDetailViewController.swift
//  Rick&Morty
//
//  Created by Alexander V. on 09.11.2023.
//

import UIKit

protocol CharacterDetailViewControllerCoordinator {
    
}

final class CharacterDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

private extension CharacterDetailViewController {
    
    func setupView() {
        view.backgroundColor = .systemBackground
    }
}
