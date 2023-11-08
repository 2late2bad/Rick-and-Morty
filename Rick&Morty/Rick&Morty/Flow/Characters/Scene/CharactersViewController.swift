//
//  CharactersViewController.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

import UIKit

protocol CharactersViewControllerCoordinator: AnyObject {
    func didSelectCharacter(url: String)
}

final class CharactersViewController: UITableViewController {
    
    private weak var coordinator: CharactersViewControllerCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSelf()
    }
}

private extension CharactersViewController {
    
    func setupSelf() {
        tableView.separatorStyle = .none
        tableView.register(ItemCharacterTableViewCell.self,
                           forCellReuseIdentifier: ItemCharacterTableViewCell.reuseIdentifier)
    }
}

// MARK: - TableViewDataSource
extension CharactersViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ItemCharacterTableViewCell.reuseIdentifier,
            for: indexPath) as? ItemCharacterTableViewCell
        else {
            return UITableViewCell()
        }
        return cell
    }
}
