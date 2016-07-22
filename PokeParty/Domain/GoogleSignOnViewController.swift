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

class GoogleSignOnViewController: UIViewController {

    private lazy var googleSignOnButton: UIButton = {
        let button = UIButton()
        button.setTitle("Google sign on", forState: .Normal)
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button.addTarget(self, action: #selector(onGoogleSignOn), forControlEvents: .TouchUpInside)
        return button
    }()

    weak var delegate: GoogleSignOnViewControllerDelegate?

    override func loadView() {
        view = UIView()
        setupGoogleSignOnButton()
    }

    private func setupGoogleSignOnButton() {
        view.addSubview(googleSignOnButton)
        googleSignOnButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints([
            googleSignOnButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor),
            googleSignOnButton.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor),
            googleSignOnButton.heightAnchor.constraintEqualToConstant(100.0),
            googleSignOnButton.widthAnchor.constraintEqualToConstant(100.0)
        ])
    }

    @objc private func onGoogleSignOn() {
        delegate?.googleSignOnViewControllerDidSignOn(self)
    }
}
