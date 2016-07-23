//
//  PartyViewController.swift
//  PokeParty
//
//  Created by Jakub Warchoł on 23.07.2016.
//  Copyright © 2016 tooploox. All rights reserved.
//

import UIKit

protocol PartyViewControllerDelegate: class {
    func partyViewControllerWantsToShowEvents(viewController: PartyViewController)
    func partyViewControllerWantsToAddTrainers(viewController: PartyViewController)
}

class PartyViewController: UIViewController {

    weak var delegate: PartyViewControllerDelegate?

    let tableView = UITableView()

    private lazy var addTrainersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add new trainers", forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(20.0, weight: UIFontWeightSemibold)
        button.backgroundColor = UIColor.appTeamColor()
        button.layer.cornerRadius = 3.0
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
        view.addSubview(eventsButton)
        view.addSubview(tableView)

        addTrainersButton.translatesAutoresizingMaskIntoConstraints = false
        eventsButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activateConstraints([
            eventsButton.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 50.0),
            eventsButton.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -50.0),
            eventsButton.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 50.0),
            eventsButton.heightAnchor.constraintEqualToConstant(50.0)
        ])

        NSLayoutConstraint.activateConstraints([
            tableView.topAnchor.constraintEqualToAnchor(eventsButton.bottomAnchor, constant: 20.0),
            tableView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -30.0),
            tableView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 30.0),
            tableView.bottomAnchor.constraintEqualToAnchor(eventsButton.topAnchor, constant: -30.0)
        ])

        NSLayoutConstraint.activateConstraints([
            addTrainersButton.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -50.0),
            addTrainersButton.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 50.0),
            addTrainersButton.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -30.0),
            addTrainersButton.heightAnchor.constraintEqualToConstant(50.0)
        ])

    }

    func onAddNewTrainers() {
        delegate?.partyViewControllerWantsToAddTrainers(self)
    }

    func onEvents() {
        delegate?.partyViewControllerWantsToShowEvents(self)
    }
}