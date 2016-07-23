//
//  PartyViewController.swift
//  PokeParty
//
//  Created by Jakub Warchoł on 23.07.2016.
//  Copyright © 2016 tooploox. All rights reserved.
//

import UIKit
import PokePartyShared

protocol PartyViewControllerDelegate: class {
    func partyViewControllerWantsToShowEvents(viewController: PartyViewController)
    func partyViewControllerWantsToAddTrainers(viewController: PartyViewController)
}

class PartyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    weak var delegate: PartyViewControllerDelegate?

    let tableView = UITableView()

    var partyMember = [User]()

    private lazy var addTrainersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add new trainers", forState: .Normal)
        button.setTitleColor(UIColor.appButtonBorderYellowColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(20.0, weight: UIFontWeightMedium)
        button.layer.cornerRadius = 9.0
        button.layer.borderWidth = 3.0
        button.backgroundColor = UIColor.appButtonBackgroundBlueColor()
        button.layer.borderColor = UIColor.appButtonBorderYellowColor().CGColor
        button.addTarget(self, action: #selector(onAddNewTrainers), forControlEvents: .TouchUpInside)
        return button
    }()

    private lazy var eventsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Events", forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(20.0, weight: UIFontWeightSemibold)
        button.backgroundColor = UIColor.appTeamColor()
        button.layer.cornerRadius = 3.0
        button.addTarget(self, action: #selector(onEvents), forControlEvents: .TouchUpInside)
        return button
    }()

    override func loadView() {
        view = UIView()
        setup()
    }

    func setup() {
        view.addSubview(addTrainersButton)
//        view.addSubview(eventsButton)
        view.addSubview(tableView)

        addTrainersButton.translatesAutoresizingMaskIntoConstraints = false
//        eventsButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

//        NSLayoutConstraint.activateConstraints([
//            eventsButton.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 50.0),
//            eventsButton.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -50.0),
//            eventsButton.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 50.0),
//            eventsButton.heightAnchor.constraintEqualToConstant(50.0)
//        ])

        NSLayoutConstraint.activateConstraints([
            tableView.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 80.0),
            tableView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -30.0),
            tableView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 30.0),
            tableView.bottomAnchor.constraintEqualToAnchor(addTrainersButton.topAnchor, constant: -30.0)
        ])

        NSLayoutConstraint.activateConstraints([
            addTrainersButton.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -30.0),
            addTrainersButton.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 30.0),
            addTrainersButton.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -30.0),
            addTrainersButton.heightAnchor.constraintEqualToConstant(60.0)
        ])

        view.backgroundColor = UIColor.appSplashScreenBackgroundColor()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Events", style: .Plain, target: self, action: #selector(onEvents))

        tableView.registerNib(
            UINib(nibName: "PokemonTableViewCell", bundle: nil),
            forCellReuseIdentifier: "pokemonCell"
        )

        tableView.separatorColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.15)
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.backgroundColor = UIColor.appSplashScreenBackgroundColor()
        tableView.dataSource = self
        tableView.delegate = self

    }

    func onAddNewTrainers() {
        delegate?.partyViewControllerWantsToAddTrainers(self)
    }

    func onEvents() {
        delegate?.partyViewControllerWantsToShowEvents(self)
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partyMember.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("pokemonCell", forIndexPath: indexPath) as! PokemonTableViewCell
        let user = partyMember[indexPath.row]
        cell.pokemonImage.image = UIImage()
        cell.pokemonNameLabel.text = user.username
        cell.setupLayout()
        return cell
    }
}