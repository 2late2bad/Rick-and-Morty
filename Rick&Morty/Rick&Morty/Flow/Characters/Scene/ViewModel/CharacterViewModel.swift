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
    func getListEpisodes(row: Int) -> [String]
}

final class CharacterViewModelImp: CharacterViewModel {
   
    // MARK: - Public property
    var state: PassthroughSubject<StateController, Never>
    
    var lastPage: Bool {
        lastPageValidationUseCase.lastpage
    }
    
    var itemCharacterCount: Int {
        characters.count
    }
    
    // MARK: - Private property
    private var characters: [Character] = []
    private let loadCharactersUseCase: LoadCharacterUseCase
    private var lastPageValidationUseCase: LastPageValidationUseCase
    private var imageDataUseCase: ImageDataUseCase
    
    // MARK: - Init
    init(
        loadCharactersUseCase: LoadCharacterUseCase,
        state: PassthroughSubject<StateController, Never>,
        lastPageValidationUseCase: LastPageValidationUseCase,
        imageDataUseCase: ImageDataUseCase
    ) {
        self.loadCharactersUseCase = loadCharactersUseCase
        self.state = state
        self.lastPageValidationUseCase = lastPageValidationUseCase
        self.imageDataUseCase = imageDataUseCase
    }
    
    // MARK: - Public methods
    func viewDidLoad() {
        state.send(.loading)
        Task {
            await loadCharactersUseCase()
        }
    }
    
    func getItemMenuViewModel(row: Int) -> ItemCharacterViewModel {
        checkAndLoadMoreCharacters(row: row)
        return makeItemCharacterViewModel(row: row)
    }
    
    func getListEpisodes(row: Int) -> [String] {
        let character = characters[row]
        return character.episode
    }
}

// MARK: - Private methods
private extension CharacterViewModelImp {
    
    func loadCharactersUseCase() async {
        let resultUseCase = await loadCharactersUseCase.execute()
        updateStateUI(resultUseCase: resultUseCase)
    }
    
    func updateStateUI(resultUseCase: Result<[Character], Error>) {
        switch resultUseCase {
        case .success(let char):
            lastPageValidationUseCase.updateLastPage(itemsCount: char.count)
            characters.append(contentsOf: char)
            state.send(.success)
        case .failure(let error):
            state.send(.fail(error: error.localizedDescription))
        }
    }
    
    func makeItemCharacterViewModel(row: Int) -> ItemCharacterViewModel {
        let character = characters[row]
        return ItemCharacterViewModel(character: character, dataImageUseCase: imageDataUseCase)
    }
    
    func checkAndLoadMoreCharacters(row: Int) {
        lastPageValidationUseCase.checkAndLoadMoreItems(
            row: row,
            actualItems: characters.count,
            action: viewDidLoad)
    }
}
