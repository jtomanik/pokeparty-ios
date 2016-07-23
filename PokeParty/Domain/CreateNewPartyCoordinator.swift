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

    var onClose: (Void -> Void)?
    var onCreate: (String -> Void)?

    init() {
        let asd = CreateNewPartyViewController()

        rootViewController = NavigationController(rootViewController: asd)

        asd.onClose = { [unowned self] in
            self.onClose?()
        }

        asd.onCreate = { [unowned self] name in
            self.onCreate?(name)
        }
    }
}