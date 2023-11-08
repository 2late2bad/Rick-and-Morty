//
//  CharactersViewController.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

import UIKit
import Combine

protocol CharactersViewControllerCoordinator: AnyObject {
    func didSelectCharacter(url: String)
}

final class CharactersViewController: UITableViewController {
    
    private weak var coordinator: CharactersViewControllerCoordinator?
    private let viewModel: CharacterViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: CharacterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        setupSelf()
        stateController()
    }
}

private extension CharactersViewController {
    
    func setupSelf() {
        tableView.separatorStyle = .none
        tableView.register(ItemCharacterTableViewCell.self,
                           forCellReuseIdentifier: ItemCharacterTableViewCell.reuseIdentifier)
        addSpinnerLastCell()
    }
    
    func stateController() {
        viewModel
            .state
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                switch state {
                case .success:
                    self?.tableView.reloadData()
                case .loading:
                    break
                case .fail(error: let error):
                    print("Error here", error)
                }
            }
            .store(in: &cancellables)
    }
}

// MARK: - TableViewDataSource
extension CharactersViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.itemCharacterCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ItemCharacterTableViewCell.reuseIdentifier,
            for: indexPath) as? ItemCharacterTableViewCell
        else {
            return UITableViewCell()
        }
        let row = indexPath.row
        let itemViewModel = viewModel.getItemMenuViewModel(row: row)
        cell.configure(viewModel: itemViewModel)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !viewModel.lastPage {
            tableView.tableFooterView?.isHidden = false
        } else {
            tableView.tableFooterView?.isHidden = true
        }
    }
}
