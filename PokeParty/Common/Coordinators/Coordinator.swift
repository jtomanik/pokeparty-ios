//
//  Coordinator.swift
//  Switchboard
//
//  Created by Jakub Warchoł on 06.05.2016.
//  Copyright © 2016 nowthisnews. All rights reserved.
//

import UIKit


protocol Coordinator: class {
    var rootViewController: UIViewController { get }
    var childCoordinators: [Coordinator] { get set }
}


extension Coordinator {
    
    func removeChildCoordinator(coordinator: Coordinator) {
        if let index = childCoordinators.indexOf( {$0 === coordinator} ) {
            childCoordinators.removeAtIndex(index)
        }
    }
    
    func presentCoordinator(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
        rootViewController.presentViewController(coordinator.rootViewController, animated: true, completion: nil)
    }
    
    func dismissCoordinator(coordinator: Coordinator) {
        if rootViewController.presentedViewController != nil {
            rootViewController.dismissViewControllerAnimated(true, completion: nil)
            removeChildCoordinator(coordinator)
        }
    }
}


extension Coordinator where Self : NavigationCoordinator {

    func presentCoordinator(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
        navigationController.presentCoordinator(coordinator, animated: true)
    }

    // Reference handled by navigation controller
    func pushCoordinator(coordinator: Coordinator) {
        navigationController.pushCoordinator(coordinator, animated: true)
    }
}


extension Coordinator where Self : InNavigationCoordinator {

    func presentCoordinator(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
        navigationController.presentCoordinator(coordinator, animated: true)
    }

    // Reference handled by navigation controller
    func pushCoordinator(coordinator: Coordinator) {
        navigationController.pushCoordinator(coordinator, animated: true)
    }
}