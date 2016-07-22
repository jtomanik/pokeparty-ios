//
//  GoogleSignOnViewController.swift
//  PokeParty
//
//  Created by Jakub Warchoł on 22.07.2016.
//  Copyright © 2016 tooploox. All rights reserved.
//

import UIKit

protocol GoogleSignOnViewControllerDelegate: class {
    func googleSignOnViewControllerDidSignOn(viewController: GoogleSignOnViewController)
}

class GoogleSignOnViewController: UIViewController, GIDSignInUIDelegate {

    private lazy var googleSignOnButton: UIButton = {
        let button = UIButton()
        button.setTitle("Google sign on", forState: .Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.layer.cornerRadius = 3.0
        button.layer.borderWidth = 3.0
        button.backgroundColor = UIColor.appButtonBackgroundBlueColor()
        button.layer.borderColor = UIColor.appButtonBorderYellowColor().CGColor
        button.addTarget(self, action: #selector(onGoogleSignOn), forControlEvents: .TouchUpInside)
        return button
    }()

    weak var delegate: GoogleSignOnViewControllerDelegate?

    override func loadView() {
        view = UIView()
        setupGoogleSignOnButton()
        view.backgroundColor = UIColor.appSplashScreenBackgroundColor()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance().uiDelegate = self
    }

    private func setupGoogleSignOnButton() {
        view.addSubview(googleSignOnButton)
        googleSignOnButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints([
            googleSignOnButton.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 50.0),
            googleSignOnButton.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -50.0),
            googleSignOnButton.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -50.0),
            googleSignOnButton.heightAnchor.constraintEqualToConstant(60.0),
        ])
    }

    @objc private func onGoogleSignOn() {
        delegate?.googleSignOnViewControllerDidSignOn(self)
    }
}
