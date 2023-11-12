//
//  BaseViewModel.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

import Combine

protocol BaseViewModel {
    var state: PassthroughSubject<StateController, Never> { get }
    func viewDidLoad()
}
