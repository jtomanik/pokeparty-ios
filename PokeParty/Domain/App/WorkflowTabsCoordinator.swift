//
//  WorkflowTabsCoordinator.swift
//  Switchboard
//
//  Created by Sebastian Osiński on 25/05/16.
//  Copyright © 2016 nowthisnews. All rights reserved.
//

import UIKit

protocol WorfklowTabsCoordinatorDelegate: class {
    func worfklowTabsCoordinatorAskedToShowDrawerMenu(workflowTabsCoordinator: WorkflowTabsCoordinator)
}

final class WorkflowTabsCoordinator: TabBarCoordinator {
    
    weak var delegate: WorfklowTabsCoordinatorDelegate?
    
    private(set) var rootViewController: UIViewController
    var childCoordinators = [Coordinator]()
    
    init() {
        rootViewController = UITabBarController()
        tabBarController.tabBar.barTintColor = UIColor.appDarkColor()
        tabBarController.tabBar.tintColor = UIColor.whiteColor()
        
        tabBarController.setViewControllers(childCoordinators.map { $0.rootViewController }, animated: false)
    }
}