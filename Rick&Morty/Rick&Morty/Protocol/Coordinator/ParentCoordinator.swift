//
//  ParentCoordinator.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

protocol ParentCoordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
}

extension ParentCoordinator {
    
    func addChild(_ childCoordinator: Coordinator?) {
        guard let childCoordinator else { return }
        childCoordinators.append(childCoordinator)
        childCoordinator.start()
    }
    
    func removeChild(_ childCoordinator: Coordinator?) {
        childCoordinators = childCoordinators.filter { $0 !== childCoordinator }
    }
    
    func clearAllChilds() {
        childCoordinators = []
    }
}
