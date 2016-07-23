//
//  SetupProfileViewController.swift
//  PokeParty
//
//  Created by Jakub Warchoł on 23.07.2016.
//  Copyright © 2016 tooploox. All rights reserved.
//

import Foundation

protocol SetupProfileViewControllerDelegate: class {
    func setupProfileViewControllerWantsToAddPokemon(viewController: SetupProfileViewController)
}

final class SetupProfileViewController: UIViewController, UITextFieldDelegate {

    let teamSelectView = TeamSelectView()

    weak var delegate: SetupProfileViewControllerDelegate?

    private lazy var userNameTextField: UITextField = {
        let textfield = UITextField()
        textfield.font = UIFont.boldSystemFontOfSize(17.0)
        textfield.textColor = UIColor.appButtonBorderYellowColor()
        textfield.backgroundColor = UIColor.appButtonBackgroundBlueColor()
        textfield.layer.borderColor = UIColor.appTextFieldBorderColor().CGColor
        textfield.layer.borderWidth = 2.0
        textfield.layer.cornerRadius = 8.0
        textfield.textAlignment = .Center
        textfield.delegate = self
        return textfield
    }()

    private lazy var addPokemonButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add \(pokemonString)", forState: .Normal)
        button.setTitleColor(UIColor.appButtonBorderYellowColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(20.0, weight: UIFontWeightMedium)
        button.layer.cornerRadius = 9.0
        button.layer.borderWidth = 3.0
        button.backgroundColor = UIColor.appButtonBackgroundBlueColor()
        button.layer.borderColor = UIColor.appButtonBorderYellowColor().CGColor
        button.addTarget(self, action: #selector(onAddPokemon), forControlEvents: .TouchUpInside)
        return button
    }()

    override func loadView() {
        view = UIView()

        view.backgroundColor = UIColor.appSplashScreenBackgroundColor()
        
        view.addSubview(teamSelectView)
        view.addSubview(userNameTextField)
        view.addSubview(addPokemonButton)

        let label = UILabel()
        label.text = "Create Profile"
        label.font = UIFont.systemFontOfSize(30.0, weight: UIFontWeightLight)
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center

        view.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activateConstraints([
            label.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 40.0),
            label.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor),
            label.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor)
        ])

        let usernameLabel = UILabel()
        view.addSubview(usernameLabel)

        usernameLabel.text = "\(pokemonString) Go username"
        usernameLabel.font = UIFont.systemFontOfSize(18.0)
        usernameLabel.textColor = UIColor.whiteColor()
        usernameLabel.textAlignment = .Left


        usernameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activateConstraints([
            usernameLabel.topAnchor.constraintEqualToAnchor(label.bottomAnchor, constant: 35.0),
            usernameLabel.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 20.0),
            usernameLabel.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor)
        ])

        addPokemonButton.translatesAutoresizingMaskIntoConstraints = false
        teamSelectView.translatesAutoresizingMaskIntoConstraints = false
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activateConstraints([
            userNameTextField.topAnchor.constraintEqualToAnchor(usernameLabel.bottomAnchor, constant: 16.0),
            userNameTextField.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -20.0),
            userNameTextField.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 20.0),
            userNameTextField.heightAnchor.constraintEqualToConstant(50.0)
        ])

        NSLayoutConstraint.activateConstraints([
            teamSelectView.topAnchor.constraintEqualToAnchor(userNameTextField.bottomAnchor, constant: 40.0),
            teamSelectView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 20.0),
            teamSelectView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -20.0)
        ])

        NSLayoutConstraint.activateConstraints([
            addPokemonButton.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -30.0),
            addPokemonButton.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -30.0),
            addPokemonButton.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 30.0),
            addPokemonButton.heightAnchor.constraintEqualToConstant(60.0)
        ])
    }

    func onAddPokemon() {
        delegate?.setupProfileViewControllerWantsToAddPokemon(self)
    }

    @objc func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}