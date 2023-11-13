//
//  AppDIContainer.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

protocol AppContainer {
    var auth: SessionCheckerAuth & LoginAuth & LogoutAuth { get }
    var keychain: Keychain { get }
    var networkService: Network & RemoteImageDataService { get }
    var localDataService: LocalDataImageService { get }
    func getDataImageUseCase() -> ImageDataUseCase
}

struct AppDIContainer: AppContainer {
    
    var auth: LoginAuth & LogoutAuth & SessionCheckerAuth = Auth()
    var keychain: Keychain = KeychainImp()
    
    var networkService: Network & RemoteImageDataService = NetworkService()
    var localDataService: LocalDataImageService = LocalDataImageServiceImp()
    
    func getDataImageUseCase() -> ImageDataUseCase {
        let imageDataRepository = ImageDataRepositoryImp(
            remoteDataService: networkService,
            localDataCache: localDataService)
        return ImageDataUseCaseImp(imageDataRepository: imageDataRepository)
    }
}
