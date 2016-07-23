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
        button.setTitleColor(UIColor.appButtonBorderYellowColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(20.0, weight: UIFontWeightMedium)
        button.layer.cornerRadius = 9.0
        button.layer.borderWidth = 3.0
        button.backgroundColor = UIColor.appButtonBackgroundBlueColor()
        button.layer.borderColor = UIColor.appButtonBorderYellowColor().CGColor
        button.addTarget(self, action: #selector(onGoogleSignOn), forControlEvents: .TouchUpInside)
        return button
    }()

    private let logo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pokeParty")
        imageView.contentMode = .ScaleAspectFill
        
        return imageView
    }()

    weak var delegate: GoogleSignOnViewControllerDelegate?

    override func loadView() {
        view = UIView()

        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)

        view.addSubview(logo)
        view.addSubview(googleSignOnButton)

        logo.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activateConstraints([
            logo.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 120.0),
            logo.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor),
            logo.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor),
        ])

        setupGoogleSignOnButton()
        view.backgroundColor = UIColor.appSplashScreenBackgroundColor()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance().uiDelegate = self
    }

    private func setupGoogleSignOnButton() {
        googleSignOnButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints([
            googleSignOnButton.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 30.0),
            googleSignOnButton.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -30.0),
            googleSignOnButton.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -50.0),
            googleSignOnButton.heightAnchor.constraintEqualToConstant(60.0),
        ])
    }

    @objc private func onGoogleSignOn() {
        delegate?.googleSignOnViewControllerDidSignOn(self)
    }
}
