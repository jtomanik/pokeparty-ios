//
//  LoginCoordinator.swift
//  Switchboard
//
//  Created by Jakub Warchoł on 19.05.2016.
//  Copyright © 2016 nowthisnews. All rights reserved.
//

import UIKit
import PokePartyShared


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

            UserClient.sharedInstance.googleAuth(userId) { user, error in
                if let _ = error {
                    let alert = UIAlertController(title: "Error", message: "Login Error, real Error", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "OK, I guess", style: .Default, handler: nil))
                    self.rootViewController.presentViewController(alert, animated: true, completion: nil)
                }

                guard let _ = user else {
                    let alert = UIAlertController(title: "Error", message: "Login Error, no User", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "OK, I guess", style: .Default, handler: nil))
                    self.rootViewController.presentViewController(alert, animated: true, completion: nil)
                    return
                }

                let setupProfileViewController = SetupProfileViewController()
                setupProfileViewController.delegate = self
                self.navigationController.pushViewController(setupProfileViewController, animated: true)
            }
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
        accountDataProvider.set(data: [ Constants.Account.isLoggedInKey : true ])
        delegate?.onboardingCoordinatorFinishFlow(self)
    }
}