//
//  Reusable.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

protocol Reusable {}

extension Reusable {
    static var reuseIdentifier: String { String(describing: self) }
}
