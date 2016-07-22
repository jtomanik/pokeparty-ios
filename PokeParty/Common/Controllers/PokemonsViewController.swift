//
//  PokemonsView.swift
//  PokeParty
//
//  Created by Karol Kubicki on 22.07.2016.
//  Copyright © 2016 tooploox. All rights reserved.
//

import UIKit
import PokePartyShared


struct PokemonsLists {
    
    let pokemons: [Pokemon]
    
    init() {
        pokemons = (1..<152).map { Pokemon(number: $0, combatPower: 0) }
    }
}

class PokemonsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{

    private var collectionView: UICollectionView!
    
    private let pokemonsLists = PokemonsLists()
    
    var onPokemonSelected: (Pokemon -> Void)?
    var onPokemonDeselected: (Pokemon -> Void)?
    
    var teamColor: UIColor
    
    init(teamColor: UIColor) {        
        self.teamColor = teamColor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerNib(
            UINib(nibName: "PokemonCell", bundle: nil),
            forCellWithReuseIdentifier: "pokemonCell"
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        collectionView.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor).active = true
        collectionView.bottomAnchor.constraintEqualToAnchor(bottomLayoutGuide.topAnchor).active = true
        collectionView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
        collectionView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonsLists.pokemons.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("pokemonCell", forIndexPath: indexPath) as! PokemonCell
        let pokemon = pokemonsLists.pokemons[indexPath.row]
        cell.pokemonImageView.image = pokemon.image
        cell.pokemonNameLabel.text = pokemon.name
        cell.choosedPokemonColor = teamColor
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = view.bounds.width
        let cellWidth = width / 6.0
        return CGSize(width: cellWidth , height: cellWidth * 1.4)
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let pokemon = pokemonsLists.pokemons[indexPath.row]
        onPokemonSelected?(pokemon)        
        collectionView.reloadData()
    }
}
