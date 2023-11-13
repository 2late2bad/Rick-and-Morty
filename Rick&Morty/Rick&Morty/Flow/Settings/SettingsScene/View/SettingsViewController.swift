//
//  SettingsViewController.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

import UIKit

protocol SettingsViewControllerCoordinator: AnyObject {
    func didSelectCell(settingsViewNavigation: SettingsViewNavigation)
}

final class SettingsViewController: UITableViewController {
    
    private let viewModel: SettingsViewModel
    private weak var coordinator: SettingsViewControllerCoordinator?
    
    init(viewModel: SettingsViewModel, coordinator: SettingsViewControllerCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "idqd")
        tableView.backgroundColor = .systemGroupedBackground
    }
}

extension SettingsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.settingCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModel.getItemSettingsViewModel(row: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "idqd", for: indexPath)
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = viewModel.title
        contentConfiguration.image = UIImage(systemName: viewModel.icon)
        cell.contentConfiguration = contentConfiguration
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let navigation = viewModel.cellSelected(row: indexPath.row)
        coordinator?.didSelectCell(settingsViewNavigation: navigation)
    }
}
