//
//  PokemonCellCollectionViewCell.swift
//  PokeParty
//
//  Created by Karol Kubicki on 22.07.2016.
//  Copyright © 2016 tooploox. All rights reserved.
//

import UIKit
import CoreGraphics
class PokemonCell: UICollectionViewCell {
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    var choosedPokemonColor = UIColor(red: 0.878, green: 0.8763, blue: 0.9262, alpha: 1.0)
    
    var choosedPokemon: Bool = false {
        didSet {
            setupLayout()            
        }
    }
    
    override var highlighted: Bool {
        didSet {
            alpha = highlighted ? 0.5 : 1.0
        }
    }
    
    override var selected: Bool {
        didSet {
            alpha = selected ? 0.5 : 1.0
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setupLayout()
    }
    
    private func setupLayout() {
        layer.cornerRadius = 10.0
        layer.borderWidth = choosedPokemon ? 2.0 : 0.0
        layer.borderColor = choosedPokemonColor.CGColor
    }

}
