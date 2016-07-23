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
        return view
    }()

    private let avatarInnerCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        view.layer.cornerRadius = 40.0
        return view
    }()

    private let myPokemonButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 16.0
        button.layer.masksToBounds = true
        button.setTitle("My \(pokemonString)", forState: .Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(18.0, weight: UIFontWeightMedium)
        button.titleLabel?.textAlignment = .Center
        button.backgroundColor = UIColor.appTeamColor()
        return button
    }()

    private lazy var createNewPartyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create a new party", forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(20.0, weight: UIFontWeightSemibold)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.backgroundColor = UIColor.appTeamColor()
        button.layer.cornerRadius = 3.0
        button.addTarget(self, action: #selector(onCreateNewParty), forControlEvents: .TouchUpInside)
        return button
    }()

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.appLightBackgorundColor()
        setupHeaderView()
        setupCircles()
        setupPokemonLabel()
        setupCreateNewPartyButton()

        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
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
        avatarOuterCircleView.addSubview(avatarInnerCircleView)
        view.addSubview(avatarOuterCircleView)

        avatarOuterCircleView.translatesAutoresizingMaskIntoConstraints = false
        avatarInnerCircleView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activateConstraints([
            avatarOuterCircleView.leadingAnchor.constraintEqualToAnchor(headerView.leadingAnchor, constant: 20.0),
            avatarOuterCircleView.bottomAnchor.constraintEqualToAnchor(headerView.bottomAnchor, constant: -20.0),
            avatarOuterCircleView.heightAnchor.constraintEqualToConstant(90.0),
            avatarOuterCircleView.widthAnchor.constraintEqualToConstant(90.0)
        ])

        NSLayoutConstraint.activateConstraints([
            avatarInnerCircleView.centerXAnchor.constraintEqualToAnchor(avatarOuterCircleView.centerXAnchor),
            avatarInnerCircleView.centerYAnchor.constraintEqualToAnchor(avatarOuterCircleView.centerYAnchor),
            avatarInnerCircleView.heightAnchor.constraintEqualToConstant(80.0),
            avatarInnerCircleView.widthAnchor.constraintEqualToConstant(80.0)
        ])
    }

    private func setupPokemonLabel() {
        view.addSubview(myPokemonButton)
        myPokemonButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activateConstraints([
            myPokemonButton.heightAnchor.constraintEqualToConstant(32.0),
            myPokemonButton.widthAnchor.constraintEqualToConstant(140.0),
            myPokemonButton.centerXAnchor.constraintEqualToAnchor(headerView.centerXAnchor, constant: 15.0),
            myPokemonButton.topAnchor.constraintEqualToAnchor(headerView.topAnchor, constant: -16.0)
        ])

        myPokemonButton.addTarget(self, action: #selector(onMyPokemonButtonTap), forControlEvents: .TouchUpInside)
    }

    func onMyPokemonButtonTap() {
        delegate?.homeViewControllerWantsToShowUserPokemonList(self)
    }

    private func setupCreateNewPartyButton() {
        view.addSubview(createNewPartyButton)
        createNewPartyButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activateConstraints([
            createNewPartyButton.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 50.0),
            createNewPartyButton.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -50.0),
            createNewPartyButton.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -70.0),
            createNewPartyButton.heightAnchor.constraintEqualToConstant(60.0)
        ])
    }

    func onCreateNewParty() {
        delegate?.homeViewControllerWantsToCreateNewParty(self)
    }

}
