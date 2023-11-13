//
//  ItemCharacterViewModel.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

import Foundation

struct ItemCharacterViewModel {
    
    // MARK: - Property
    private(set) var character: Character
    private(set) var dataImageUseCase: ImageDataUseCase
    
    var name: String {
        character.name
    }
    
    var specie: String {
        character.specie.description
    }
    
    var status: String {
        character.status?.description ?? ""
    }
    
    var gender: String {
        character.gender.description
    }
    
    var imageData: Data? {
        dataImageUseCase.getDataFromCache(url: character.urlImage)
    }
    
    // MARK: - Methods
    func getImageData() async -> Data? {
        let url = URL(string: character.urlImage ?? .empty)
        return await dataImageUseCase.getData(url: url)
    }
}
