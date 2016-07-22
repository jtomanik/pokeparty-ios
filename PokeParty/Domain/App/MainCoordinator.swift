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
        
        if accountData.isLoggedIn {
            rootViewController = UIViewController()
            childCoordinators = []
        } else {
            let onboardingCoordinator = OnboardingCoordinator(accountService: AccountService(dataProvider: accountData))
            rootViewController = NavigationController(rootViewController: CreateNewPartyViewController())
            childCoordinators = [onboardingCoordinator]
            onboardingCoordinator.delegate = self
        }
    }

    // MARK: - Authentication Notification

    func showSignOn() {
        let loginCoordinator = OnboardingCoordinator(accountService: AccountService(dataProvider: accountData))
        loginCoordinator.delegate = self

        childCoordinators.append(loginCoordinator)
        rootViewController = loginCoordinator.rootViewController
        
        delegate?.mainCoordinator(self, hasNewRootViewController: rootViewController)
    }
}


extension MainCoordinator: OnboardingCoordinatorDelegate {

    func onboardingCoordinatorDidLogin(onboardingCoordinator: OnboardingCoordinator) {
        removeChildCoordinator(onboardingCoordinator)
        // do something
    }
}