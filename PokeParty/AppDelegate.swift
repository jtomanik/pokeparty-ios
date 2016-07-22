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
        setupGoogleLogin()
        return true
    }

    private func setupGoogleLogin() {
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
    }

    func application(application: UIApplication, openURL url: NSURL, options: [String: AnyObject]) -> Bool {
        return GIDSignIn.sharedInstance().handleURL(
            url,
            sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey] as? String,
            annotation: options[UIApplicationOpenURLOptionsAnnotationKey]
        )
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
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
        guard let window = window else {
            fatalError("Window not found")
        }

        UIView.transitionWithView(window, duration: 0.4, options: .TransitionFlipFromLeft, animations: {
            window.rootViewController = rootViewController
        }, completion: nil)
    }
}
