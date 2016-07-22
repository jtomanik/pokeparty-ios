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
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("pokemonCell") as! PokemonTableViewCell
        let pokemon = pokemons[indexPath.row]
        cell.pokemonImage.image = pokemon.image
        cell.pokemonNameLabel.text = pokemon.name
        cell.pokemonCombatPowerLabel.text = "\(pokemon.combatPower)"
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 64.0
    }

}
