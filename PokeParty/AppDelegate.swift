//
//  AppDelegate.swift
//  PokeParty
//
//  Created by Jakub Warchoł on 22.07.2016.
//  Copyright © 2016 tooploox. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private let mainCoordinator = MainCoordinator(
        accountData: AccountDataProviderFactory.userDefaultsAccountDataProvider()
    )


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        setupWindow()
        return true
    }

    private func setupWindow() {

        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        window?.rootViewController = mainCoordinator.rootViewController
        window?.makeKeyAndVisible()

        mainCoordinator.delegate = self
    }
}


extension AppDelegate: MainCoordinatorDelegate {
    func mainCoordinator(mainCooordinator: MainCoordinator, hasNewRootViewController rootViewController: UIViewController) {
        //
    }
}
