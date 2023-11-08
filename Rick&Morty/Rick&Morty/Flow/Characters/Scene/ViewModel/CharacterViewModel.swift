//
//  CharacterViewModel.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

import Combine

protocol CharacterViewModel: BaseViewModel {
    var itemCharacterCount: Int { get }
    var lastPage: Bool { get }
    func getItemMenuViewModel(row: Int) -> ItemCharacterViewModel
    func getUrlList(row: Int) -> String
}

final class CharacterViewModelImp: CharacterViewModel {
   
    var state: PassthroughSubject<StateController, Never>
    
    var lastPage: Bool = false
    
    var itemCharacterCount: Int {
        characters.count
    }
    
    private var characters: [Character] = []
    private let loadCharactersUseCase: LoadCharacterUseCase
    
    init(
        loadCharactersUseCase: LoadCharacterUseCase,
        state: PassthroughSubject<StateController, Never>
    ) {
        self.loadCharactersUseCase = loadCharactersUseCase
        self.state = state
    }

    func viewDidLoad() {
        state.send(.loading)
        Task {
            await loadCharactersUseCase()
        }
    }
    
    func getItemMenuViewModel(row: Int) -> ItemCharacterViewModel {
        let character = characters[row]
        let itemCharacterViewModel = ItemCharacterViewModel(character: character)
        return itemCharacterViewModel
    }
    
    func getUrlList(row: Int) -> String {
        let character = characters[row]
        return character.urlCharacter
    }
    
    private func loadCharactersUseCase() async {
        let resultUseCase = await loadCharactersUseCase.execute()
        updateStateUI(resultUseCase: resultUseCase)
    }
    
    private func updateStateUI(resultUseCase: Result<[Character], Error>) {
        switch resultUseCase {
        case .success(let char):
            characters.append(contentsOf: char)
            state.send(.success)
        case .failure(let error):
            state.send(.fail(error: error.localizedDescription))
        }
    }
}
