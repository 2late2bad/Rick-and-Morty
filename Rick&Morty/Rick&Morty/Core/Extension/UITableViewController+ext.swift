//
//  UITableViewController+ext.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

import UIKit.UITableViewController

extension UITableViewController {
    func addSpinnerLastCell() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: .zero,
                               y: .zero,
                               width: tableView.bounds.width,
                               height: CGFloat(R.ViewValues.defaultHeightCell))
        tableView.tableFooterView = spinner
    }
}
