//
//  NavigationController.swift
//  Switchboard
//
//  Created by Jakub Warchoł on 06.05.2016.
//  Copyright © 2016 nowthisnews. All rights reserved.
//

import UIKit

final class NavigationController: UINavigationController {

    private var viewControllersToChildCoordinators = [UIViewController: Coordinator]()
    
    // MARK: - Inits
    
    override init(rootViewController: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        super.pushViewController(rootViewController, animated: false)
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    
    func pushCoordinator(coordinator: Coordinator, animated: Bool) {
        viewControllersToChildCoordinators[coordinator.rootViewController] = coordinator
        pushViewController(coordinator.rootViewController, animated: animated)
    }

    // Reference handled by childCoordinators array in coordinator
    func presentCoordinator(coordinator: Coordinator, animated: Bool) {
        presentViewController(coordinator.rootViewController, animated: animated, completion: nil)
    }

    override func pushViewController(viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }

    func popViewController(animated: Bool) {
        popViewControllerAnimated(animated)
    }
}


extension NavigationController: UINavigationControllerDelegate {
    
    func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {
        cleanUpChildCoordinators()
    }
    
    private func cleanUpChildCoordinators() {
        for viewController in viewControllersToChildCoordinators.keys
            where !viewControllers.contains(viewController) {
                viewControllersToChildCoordinators.removeValueForKey(viewController)
        }
    }
}
