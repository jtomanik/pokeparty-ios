//
//  LoginCoordinator.swift
//  Switchboard
//
//  Created by Jakub Warchoł on 19.05.2016.
//  Copyright © 2016 nowthisnews. All rights reserved.
//

import UIKit

protocol OnboardingCoordinatorDelegate: class {
    func onboardingCoordinatorFinishFlow(onboardingCoordinator: OnboardingCoordinator)
}


final class OnboardingCoordinator: NSObject, NavigationCoordinator, GIDSignInDelegate {

    private(set) var rootViewController: UIViewController
    var childCoordinators: [Coordinator]
    weak var delegate: OnboardingCoordinatorDelegate?

    private let accountService: AccountService
    private let accountDataProvider = AccountDataProviderFactory.userDefaultsAccountDataProvider()

    init(accountService: AccountService) {
        accountDataProvider.clear(asExplicitLogout: true)
        self.accountService = accountService

        let googleSignOnViewController = GoogleSignOnViewController()
        rootViewController = NavigationController(rootViewController: googleSignOnViewController)
        childCoordinators = []

        super.init()

        googleSignOnViewController.delegate = self
        GIDSignIn.sharedInstance().delegate = self
    }

    @objc func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        if (error == nil) {
            let userId = user.userID                  // For client-side use only! (haha)


            // TODO: login request to backend


            let setupProfileViewController = SetupProfileViewController()
            setupProfileViewController.delegate = self
            navigationController.pushViewController(setupProfileViewController, animated: true)


//            accountDataProvider.set(data: [ Constants.Account.isLoggedInKey : true ])
//            delegate?.onboardingCoordinatorFinishFlow(self)
        } else {
            print("\(error.localizedDescription)")
        }
    }

    @objc func signIn(signIn: GIDSignIn!, didDisconnectWithUser user: GIDGoogleUser!, withError error: NSError!) {
        // unused, but required by GIDSignInDelegate
    }
}


extension OnboardingCoordinator: GoogleSignOnViewControllerDelegate {

    func googleSignOnViewControllerDidSignOn(viewController: GoogleSignOnViewController) {
        GIDSignIn.sharedInstance().signIn()
    }
}


extension OnboardingCoordinator: SetupProfileViewControllerDelegate {

    func setupProfileViewControllerWantsToAddPokemon(viewController: SetupProfileViewController) {
        let choosePokemonViewController = ChoosePokemonsViewController(teamColor: UIColor.appTeamColor())
        choosePokemonViewController.delegate = self
        navigationController.pushViewController(choosePokemonViewController, animated: true)
    }
}


extension OnboardingCoordinator: ChoosePokemonsViewControllerDelegate {

    func choosePokemonsViewControllerDidTapDoneButton(viewController: ChoosePokemonsViewController) {
        // do some stuff, update account etc
        delegate?.onboardingCoordinatorFinishFlow(self)
    }
}