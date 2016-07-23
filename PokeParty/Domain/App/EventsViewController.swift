//
//  EventsViewController.swift
//  PokeParty
//
//  Created by Jakub Warchoł on 23.07.2016.
//  Copyright © 2016 tooploox. All rights reserved.
//

import Foundation

import UIKit
import PokePartyShared

class EventsViewController: UITableViewController {

    private var events: [Event]
    private let dateFormatter = NSDateFormatter()

    init(events: [Event], style: UITableViewStyle) {
        self.events = events
        super.init(style: style)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        events = [
            Event(name: "event", description: "Event description", latitude: 0, longitude: 0, ownerId: "asd"),
            Event(name: "event1", description: "Event description", latitude: 0, longitude: 0, ownerId: "asd"),
            Event(name: "event2", description: "Event description", latitude: 0, longitude: 0, ownerId: "asd")
        ]

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(onAddEvent))

        tableView.registerNib(
            UINib(nibName: "PokemonTableViewCell", bundle: nil),
            forCellReuseIdentifier: "pokemonCell"
        )
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("pokemonCell") as! PokemonTableViewCell
        let event = events[indexPath.row]
        cell.pokemonImage.image = UIImage()
        cell.pokemonNameLabel.text = event.name
        cell.pokemonCombatPowerLabel.text = dateFormatter.stringFromDate(NSDate())

        return cell
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 64.0
    }

    func onAddEvent() {

    }
    
}