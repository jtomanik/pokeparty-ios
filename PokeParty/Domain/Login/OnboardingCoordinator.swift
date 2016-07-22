//
//  LoginCoordinator.swift
//  Switchboard
//
//  Created by Jakub Warchoł on 19.05.2016.
//  Copyright © 2016 nowthisnews. All rights reserved.
//

import UIKit

protocol OnboardingCoordinatorDelegate: class {
    func onboardingCoordinatorDidLogin(onboardingCoordinator: OnboardingCoordinator)
}


final class OnboardingCoordinator: Coordinator {

    private(set) var rootViewController: UIViewController
    var childCoordinators: [Coordinator]
    weak var delegate: OnboardingCoordinatorDelegate?

    private let accountService: AccountService
    private let accountDataProvider = AccountDataProviderFactory.userDefaultsAccountDataProvider()

    init(accountService: AccountService) {
        self.accountService = accountService

        let googleSignOnViewController = GoogleSignOnViewController()
        rootViewController = googleSignOnViewController
        childCoordinators = []
        googleSignOnViewController.delegate = self
    }
}


extension OnboardingCoordinator: GoogleSignOnViewControllerDelegate {

    func googleSignOnViewControllerDidSignOn(viewController: GoogleSignOnViewController) {
        // networking
    }
}