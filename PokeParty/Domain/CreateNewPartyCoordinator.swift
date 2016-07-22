//
//  CreateNewPartyCoordinator.swift
//  PokeParty
//
//  Created by Jakub Warchoł on 22.07.2016.
//  Copyright © 2016 tooploox. All rights reserved.
//

import UIKit


class CreateNewPartyCoordinator: NavigationCoordinator {

    private(set) var rootViewController: UIViewController
    var childCoordinators: [Coordinator] = []

    init() {
        rootViewController = CreateNewPartyViewController()
    }
}