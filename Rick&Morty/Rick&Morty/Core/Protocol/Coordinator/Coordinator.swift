//
//  Coordinator.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

protocol Coordinator: AnyObject {
    var router: Router { get set }
    func start()
}
