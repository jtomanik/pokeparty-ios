//
//  MyPokemonsViewController.swift
//  PokeParty
//
//  Created by Karol Kubicki on 22.07.2016.
//  Copyright © 2016 tooploox. All rights reserved.
//

import UIKit
import PokePartyShared

class MyPokemonsViewController: UITableViewController {
    
    private var pokemons: [Pokemon]
    
    init(pokemons: [Pokemon], style: UITableViewStyle) {
        self.pokemons = pokemons
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerNib(
            UINib(nibName: "PokemonTableViewCell", bundle: nil),
            forCellReuseIdentifier: "pokemonCell"
        )

        view.backgroundColor = UIColor.appSplashScreenBackgroundColor()
        title = pokemonString
        tableView.separatorColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.15)
        tableView.separatorInset = UIEdgeInsetsZero
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("pokemonCell", forIndexPath: indexPath) as! PokemonTableViewCell
        let pokemon = pokemons[indexPath.row]
        cell.pokemonImage.image = pokemon.image
        cell.pokemonNameLabel.text = pokemon.name
        cell.pokemonCombatPowerLabel.text = "\(pokemon.combatPower)"
        cell.setupLayout()
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0
    }

}
