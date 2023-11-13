//
//  Router.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

import UIKit

protocol Router {
    var rootViewController: UINavigationController { get }
    var viewControllers: [UIViewController] { get set }
    var navigationBar: UINavigationBar { get }
    func present(_ viewControllerToPresent: UIViewController, animated: Bool)
    func pushViewController(_ viewControllerToPush: UIViewController,
                            animated: Bool,
                            backCompletion: (() -> Void)?)
    func dismiss(animated: Bool)
    var dismissNavigation: (() -> Void)? { get set }
}

extension Router {
    func pushViewController(_ viewControllerToPush: UIViewController, animated: Bool) {
        pushViewController(viewControllerToPush, animated: animated, backCompletion: nil)
    }
}

final class RouterImp: NSObject {
    var rootViewController: UINavigationController
    var dismissNavigation: (() -> Void)?
    
    private var backCompletions: [UIViewController: () -> Void] = [:]
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
        super.init()
        rootViewController.delegate = self
        rootViewController.presentationController?.delegate = self
    }
}

extension RouterImp: Router {
    
    var viewControllers: [UIViewController] {
        get {
            rootViewController.viewControllers
        }
        set {
            rootViewController.viewControllers = newValue
        }
    }
    
    var navigationBar: UINavigationBar {
        rootViewController.navigationBar
    }
    
    func present(_ viewControllerToPresent: UIViewController, animated: Bool) {
        rootViewController.present(viewControllerToPresent, animated: animated)
    }
    
    func pushViewController(_ viewControllerToPush: UIViewController, animated: Bool, backCompletion: (() -> Void)?) {
        if let backCompletion {
            backCompletions[viewControllerToPush] = backCompletion
        }
        rootViewController.pushViewController(viewControllerToPush, animated: animated)
    }
    
    func dismiss(animated: Bool) {
        rootViewController.dismiss(animated: animated)
    }
}

extension RouterImp: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let controller = navigationController.transitionCoordinator?.viewController(forKey: .from),
              !navigationController.viewControllers.contains(controller)
        else { return }
        
        guard let completion = backCompletions[controller] else { return }
        completion()
        backCompletions.removeValue(forKey: controller)
    }
}

extension RouterImp: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        dismissNavigation?()
        dismissNavigation = nil
    }
}
