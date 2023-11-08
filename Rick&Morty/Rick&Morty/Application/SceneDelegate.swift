//
//  SceneDelegate.swift
//  Rick&Morty
//
//  Created by Alexander V. on 23.10.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var appCoordinator: Coordinator?
    var appFactory: AppFactory?
    var appDIContainer: AppDIContainer?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        appDIContainer = AppDIContainer()
        appFactory = AppFactory(appDIContainer: appDIContainer)
        appCoordinator = AppCoordinator(
            router: RouterImp(rootViewController: .init()),
            window: window,
            factory: appFactory,
            auth: appDIContainer?.auth
        )
        appCoordinator?.start()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
