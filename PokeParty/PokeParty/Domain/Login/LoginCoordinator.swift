//
//  LoginCoordinator.swift
//  Switchboard
//
//  Created by Jakub Warchoł on 19.05.2016.
//  Copyright © 2016 nowthisnews. All rights reserved.
//

import UIKit

protocol LoginCoordinatorDelegate: class {
    func loginCoordinatorDidLogin(loginCoordinator: LoginCoordinator)
}


final class LoginCoordinator: Coordinator {

    private(set) var rootViewController: UIViewController
    var childCoordinators: [Coordinator]
    weak var delegate: LoginCoordinatorDelegate?

    private let accountService: AccountService

    init(accountService: AccountService) {
        let loginViewController = LoginViewController()
        rootViewController = loginViewController
        childCoordinators = []
        self.accountService = accountService
        loginViewController.delegate = self
    }
}


extension LoginCoordinator: LoginViewControllerDelegate {

    func loginViewController(loginViewController: LoginViewController, didLoginWithEmail email: String, andPassword password: String) {
//        accountService.logIn(
//            email,
//            password: password,
//            success: {
//                self.delegate?.loginCoordinatorDidLogin(self)
//            }, failure: { error in
//                loginViewController.reportFailure(error)
//            }
//        )
    }
}