//
//  ItemTabBarFactory.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

import UIKit

protocol ItemTabBarFactory {}

extension ItemTabBarFactory {
    func makeItemTabBar(
        router: Router,
        title: String,
        image: String,
        selectedImage: String
    ) {
        let tabBarItem = UITabBarItem(title: title,
                                      image: .init(systemName: image),
                                      selectedImage: .init(systemName: selectedImage))
        
        router.rootViewController.tabBarItem = tabBarItem
    }
}
