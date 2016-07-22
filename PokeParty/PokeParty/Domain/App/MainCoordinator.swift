//
//  MainCoordinator.swift
//  Switchboard
//
//  Created by Jakub Warchoł on 09.05.2016.
//  Copyright © 2016 nowthisnews. All rights reserved.
//

import UIKit

protocol MainCoordinatorDelegate: class {
    func mainCoordinator(mainCooordinator: MainCoordinator, hasNewRootViewController rootViewController: UIViewController)
}


final class MainCoordinator: Coordinator {
    
    private(set) var rootViewController: UIViewController
    var childCoordinators: [Coordinator]
    weak var delegate: MainCoordinatorDelegate?

    private let accountData: AccountDataProvider
    private let accountService: AccountService
    
    // MARK: - Init
    
    init(accountData: AccountDataProvider) {
        self.accountData = accountData
        self.accountService = AccountService(dataProvider: accountData)
        
//        if accountData.isLoggedIn {
            let loginCoordinator = LoginCoordinator(accountService: AccountService(dataProvider: accountData))
            rootViewController = loginCoordinator.rootViewController
            childCoordinators = [loginCoordinator]
            loginCoordinator.delegate = self
//        }
    }

    // MARK: - Authentication Notification

    func showLogin() {
        let loginCoordinator = LoginCoordinator(accountService: AccountService(dataProvider: accountData))
        loginCoordinator.delegate = self

        childCoordinators.append(loginCoordinator)
        rootViewController = loginCoordinator.rootViewController
        
        delegate?.mainCoordinator(self, hasNewRootViewController: rootViewController)
    }
}


extension MainCoordinator: LoginCoordinatorDelegate {

    func loginCoordinatorDidLogin(loginCoordinator: LoginCoordinator) {
        removeChildCoordinator(loginCoordinator)
        // do something
    }
}