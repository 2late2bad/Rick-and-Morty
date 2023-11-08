//
//  CharactersViewController.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

import UIKit

protocol CharactersViewControllerCoordinator: AnyObject {
    func didSelectCharacter(id: Int)
}

final class CharactersViewController: UICollectionViewController {
    
    private weak var coordinator: CharactersViewControllerCoordinator?
    
    init(
        collectionViewLayout: UICollectionViewLayout,
        coordinator: CharactersViewControllerCoordinator
    ) {
        self.coordinator = coordinator
        super.init(collectionViewLayout: collectionViewLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configCollection()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configCollection() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "idqc")
        collectionView.backgroundColor = .systemGroupedBackground
    }
}

extension CharactersViewController {
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "idqc", for: indexPath)
        var contentConfiguration = UIListContentConfiguration.cell()
        contentConfiguration.text = "Rick"
        contentConfiguration.secondaryText = "Старый пердун"
        contentConfiguration.image = UIImage(systemName: "photo")
        cell.contentConfiguration = contentConfiguration
        cell.backgroundColor = .systemBackground
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        coordinator?.didSelectCharacter(id: indexPath.row)
    }
}
