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


final class MainCoordinator: NavigationCoordinator {
    
    private(set) var rootViewController: UIViewController
    var childCoordinators: [Coordinator]
    weak var delegate: MainCoordinatorDelegate?

    private let accountData: AccountDataProvider
    private let accountService: AccountService

    var homeViewController: HomeViewController!
    
    // MARK: - Init
    
    init(accountData: AccountDataProvider) {
        self.accountData = accountData
        self.accountService = AccountService(dataProvider: accountData)
        
        if accountData.isLoggedIn {
            homeViewController = HomeViewController()
            rootViewController = NavigationController(rootViewController: homeViewController)
            childCoordinators = []
            homeViewController.delegate = self
        } else {
            let onboardingCoordinator = OnboardingCoordinator(accountService: AccountService(dataProvider: accountData))
            rootViewController = onboardingCoordinator.rootViewController
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

    func onboardingCoordinatorFinishFlow(onboardingCoordinator: OnboardingCoordinator) {
        removeChildCoordinator(onboardingCoordinator)
        homeViewController = HomeViewController()
        homeViewController.delegate = self
        rootViewController = NavigationController(rootViewController: homeViewController)
        delegate?.mainCoordinator(self, hasNewRootViewController: rootViewController)
    }
}

extension MainCoordinator: HomeViewControllerDelegate {

    func homeViewControllerWantsToCreateNewParty(viewController: HomeViewController) {
        let createNewPartyCoordinator = CreateNewPartyCoordinator()
        presentCoordinator(createNewPartyCoordinator)
        createNewPartyCoordinator.onClose = {
            self.dismissCoordinator(createNewPartyCoordinator)
        }

        createNewPartyCoordinator.onCreate = { name in
            self.homeViewController.setupMyPartyButton()
        }
    }

    func homeViewControllerWantsToShowUserPokemonList(viewController: HomeViewController) {
        let myPokemonViewController = MyPokemonsViewController(pokemons: [], style: .Plain)
        navigationController.pushViewController(myPokemonViewController, animated: true)
    }

    func homeViewControllerWantsToShowUsersParty(viewController: HomeViewController) {
        let partyViewController = PartyViewController()
        partyViewController.delegate = self
        navigationController.pushViewController(partyViewController, animated: true)
    }
}

extension MainCoordinator: PartyViewControllerDelegate {

    func partyViewControllerWantsToShowEvents(viewController: PartyViewController) {
        let eventsViewController = EventsViewController(events: [], style: .Plain)
        navigationController.pushViewController(eventsViewController, animated: true)
    }

    func partyViewControllerWantsToAddTrainers(viewController: PartyViewController) {
        let activityViewController = UIActivityViewController(activityItems: ["http://pokeparty.rocks/"], applicationActivities: nil)
        viewController.presentViewController(activityViewController, animated: true, completion: nil)
        //a
    }
}