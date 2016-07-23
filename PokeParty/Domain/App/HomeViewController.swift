//
//  HomeViewController.swift
//  PokeParty
//
//  Created by Jakub Warchoł on 22.07.2016.
//  Copyright © 2016 tooploox. All rights reserved.
//

import UIKit

let pokemonString = "Pokémon"

protocol HomeViewControllerDelegate: class {
    func homeViewControllerWantsToCreateNewParty(viewController: HomeViewController)
    func homeViewControllerWantsToShowUserPokemonList(viewController: HomeViewController)
    func homeViewControllerWantsToShowUsersParty(viewController: HomeViewController)
}

class HomeViewController: UIViewController {

    weak var delegate: HomeViewControllerDelegate?

    private let headerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5.0
        view.backgroundColor = UIColor.whiteColor()
        return view
    }()
    

    private let avatarOuterCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.appLightBackgorundColor()
        view.layer.cornerRadius = 45.0
        view.layer.borderWidth = 3.0
        view.layer.borderColor = UIColor.appButtonBorderYellowColor().CGColor
        return view
    }()

    private let avatarInnerCircleImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "pokemon_25"))
        view.layer.cornerRadius = 40.0
        return view
    }()

    private let myPokemonButton: UIButton = {
        let button = UIButton()
        button.setTitle("My \(pokemonString) (N/D) >", forState: .Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(17.0)
        button.layer.cornerRadius = 9.0
        button.layer.borderWidth = 3.0
        button.backgroundColor = UIColor.appButtonBackgroundBlueColor()
        button.layer.borderColor = UIColor.appButtonBorderYellowColor().CGColor
        return button
    }()

    private lazy var myPartyButton: UIButton = {
        let button = UIButton()
        button.setTitle("My Party", forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(20.0, weight: UIFontWeightSemibold)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.backgroundColor = UIColor.appTeamColor()
        button.layer.cornerRadius = 3.0
        button.addTarget(self, action: #selector(onMyParty), forControlEvents: .TouchUpInside)
        return button
    }()

    private lazy var createNewPartyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create a new party", forState: .Normal)
        button.setTitleColor(UIColor.appButtonBorderYellowColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(20.0, weight: UIFontWeightMedium)
        button.layer.cornerRadius = 9.0
        button.layer.borderWidth = 3.0
        button.backgroundColor = UIColor.appButtonBackgroundBlueColor()
        button.layer.borderColor = UIColor.appButtonBorderYellowColor().CGColor
        button.addTarget(self, action: #selector(onCreateNewParty), forControlEvents: .TouchUpInside)
        return button
    }()
    
    private lazy var noPartyPlaceholderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "It's dangerous to go alone! Why don't you create a party?"
        label.numberOfLines = 0
        label.textAlignment = .Center
        label.textColor = UIColor.lightGrayColor()
        return label
    }()
    
    private lazy var helloLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello, Trainer!"
        label.textColor = UIColor.lightGrayColor()
        label.font = UIFont.systemFontOfSize(20.0)
        return label
    }()

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.appSplashScreenBackgroundColor()
        setupHeaderView()
        setupCircles()
        setupMyPokemonButton()
        setupCreateNewPartyButton()
//        setupMyPartyButton()
        setupNoPartyPlaceholderLabel()
        setupHelloLabel()
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
    }
    
    private func setupHelloLabel() {
        headerView.addSubview(helloLabel)
        NSLayoutConstraint.activateConstraints([
            helloLabel.leadingAnchor.constraintEqualToAnchor(avatarOuterCircleView.trailingAnchor, constant: 8.0),
            helloLabel.bottomAnchor.constraintEqualToAnchor(myPokemonButton.topAnchor, constant: -12.0)
        ])
    }
    
    private func setupNoPartyPlaceholderLabel() {
        view.addSubview(noPartyPlaceholderLabel)
        NSLayoutConstraint.activateConstraints([
            noPartyPlaceholderLabel.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor),
            noPartyPlaceholderLabel.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 12.0),
            noPartyPlaceholderLabel.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -12.0),
        ])
    }

    private func setupHeaderView() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints([
            headerView.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 70.0),
            headerView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -10.0),
            headerView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 10.0),
            headerView.heightAnchor.constraintEqualToConstant(74.0)
        ])
    }

    private func setupCircles() {
        avatarOuterCircleView.addSubview(avatarInnerCircleImageView)
        view.addSubview(avatarOuterCircleView)

        avatarOuterCircleView.translatesAutoresizingMaskIntoConstraints = false
        avatarInnerCircleImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activateConstraints([
            avatarOuterCircleView.leadingAnchor.constraintEqualToAnchor(headerView.leadingAnchor, constant: 20.0),
            avatarOuterCircleView.bottomAnchor.constraintEqualToAnchor(headerView.bottomAnchor, constant: -20.0),
            avatarOuterCircleView.heightAnchor.constraintEqualToConstant(90.0),
            avatarOuterCircleView.widthAnchor.constraintEqualToConstant(90.0)
        ])

        NSLayoutConstraint.activateConstraints([
            avatarInnerCircleImageView.centerXAnchor.constraintEqualToAnchor(avatarOuterCircleView.centerXAnchor),
            avatarInnerCircleImageView.centerYAnchor.constraintEqualToAnchor(avatarOuterCircleView.centerYAnchor),
            avatarInnerCircleImageView.heightAnchor.constraintEqualToConstant(80.0),
            avatarInnerCircleImageView.widthAnchor.constraintEqualToConstant(80.0)
        ])
    }

    private func setupMyPokemonButton() {
        view.addSubview(myPokemonButton)
        myPokemonButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activateConstraints([
            myPokemonButton.heightAnchor.constraintEqualToConstant(32.0),
            myPokemonButton.widthAnchor.constraintEqualToAnchor(headerView.widthAnchor, multiplier: 0.7),
            myPokemonButton.centerXAnchor.constraintEqualToAnchor(headerView.centerXAnchor),
            myPokemonButton.topAnchor.constraintEqualToAnchor(headerView.bottomAnchor, constant: -16.0)
        ])

        myPokemonButton.addTarget(self, action: #selector(onMyPokemonButtonTap), forControlEvents: .TouchUpInside)
    }

    private func setupMyPartyButton() {
        view.addSubview(myPartyButton)
        myPartyButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activateConstraints([
            myPartyButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor),
            myPartyButton.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor),
            myPartyButton.heightAnchor.constraintEqualToConstant(120.0),
            myPartyButton.widthAnchor.constraintEqualToConstant(120.0)
        ])
    }

    func onMyPokemonButtonTap() {
        delegate?.homeViewControllerWantsToShowUserPokemonList(self)
    }

    private func setupCreateNewPartyButton() {
        view.addSubview(createNewPartyButton)
        createNewPartyButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activateConstraints([
            createNewPartyButton.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 12.0),
            createNewPartyButton.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -12.0),
            createNewPartyButton.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -20.0),
            createNewPartyButton.heightAnchor.constraintEqualToConstant(60.0)
        ])
    }

    func onCreateNewParty() {
        delegate?.homeViewControllerWantsToCreateNewParty(self)
    }

    func onMyParty() {
        delegate?.homeViewControllerWantsToShowUsersParty(self)
    }

}
