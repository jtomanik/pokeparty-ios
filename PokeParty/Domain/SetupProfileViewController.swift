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

final class SetupProfileViewController: UIViewController {

    let teamSelectView = TeamSelectView()

    weak var delegate: SetupProfileViewControllerDelegate?

    private let userNameTextField: UITextField = {
        let textfield = UITextField()
        textfield.font = UIFont.boldSystemFontOfSize(17.0)
        textfield.textColor = UIColor.whiteColor()
        textfield.layer.borderColor = UIColor.appButtonBorderYellowColor().CGColor
        textfield.layer.borderWidth = 2.0
        textfield.textAlignment = .Center
        return textfield
    }()

    private lazy var addPokemonButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add \(pokemonString)", forState: .Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.layer.cornerRadius = 3.0
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
        addPokemonButton.translatesAutoresizingMaskIntoConstraints = false
        teamSelectView.translatesAutoresizingMaskIntoConstraints = false
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activateConstraints([
            userNameTextField.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor, constant: 20.0),
            userNameTextField.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -50.0),
            userNameTextField.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 50.0),
            userNameTextField.heightAnchor.constraintEqualToConstant(50.0)
        ])

        NSLayoutConstraint.activateConstraints([
            teamSelectView.topAnchor.constraintEqualToAnchor(userNameTextField.bottomAnchor, constant: 40.0),
            teamSelectView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor),
            teamSelectView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor)
        ])

        NSLayoutConstraint.activateConstraints([
            addPokemonButton.topAnchor.constraintEqualToAnchor(teamSelectView.bottomAnchor, constant: 30.0),
            addPokemonButton.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -50.0),
            addPokemonButton.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 50.0),
            addPokemonButton.heightAnchor.constraintEqualToConstant(50.0)
        ])
    }

    func onAddPokemon() {
        delegate?.setupProfileViewControllerWantsToAddPokemon(self)
    }
}