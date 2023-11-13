//
//  CharacterDetailViewController.swift
//  Rick&Morty
//
//  Created by Alexander V. on 09.11.2023.
//

import UIKit
import Combine

protocol CharacterDetailViewControllerCoordinator {}

final class CharacterDetailViewController: UIViewController {
    
    private var cancellables = Set<AnyCancellable>()
    private let viewModel: CharacterDetailViewModel
    private let coordinator: CharacterDetailViewControllerCoordinator
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    private var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let itemWidth = (UIScreen.main.bounds.width - 60) / 2
        layout.itemSize = CGSize(width: itemWidth, height: 200)
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return layout
    }()
    
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
        setupViews()
        stateController()
        viewModel.viewDidLoad()
    }
}

private extension CharacterDetailViewController {
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.setConstraints(top: view.safeAreaLayoutGuide.topAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, left: view.leftAnchor)
        collectionView.register(EpisodeCell.self, forCellWithReuseIdentifier: EpisodeCell.reuseIdentifier)
    }

    func stateController() {
        viewModel
            .state
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                self?.hideSpinner()
                switch state {
                case .success:
                    self?.collectionView.reloadData()
                case .loading:
                    self?.showSpinner()
                case .fail(error: let error):
                    self?.presentAlert(message: error, title: "Error")
                }
            }
            .store(in: &cancellables)
    }
}

extension CharacterDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.episodes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: EpisodeCell.reuseIdentifier,
                for: indexPath) as? EpisodeCell
        else { return UICollectionViewCell() }
        let item = indexPath.row
        cell.configure(with: viewModel.episodes[item])
        return cell
    }
}

extension CharacterDetailViewController: SpinnerDisplayable {}
extension CharacterDetailViewController: MessageDisplayable {}
