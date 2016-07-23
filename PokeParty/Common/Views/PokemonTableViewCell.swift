//
//  PokemonTableViewCell.swift
//  PokeParty
//
//  Created by Karol Kubicki on 22.07.2016.
//  Copyright © 2016 tooploox. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonCombatPowerLabel: UILabel!

    func setupLayout() {

        pokemonNameLabel.font = UIFont.systemFontOfSize(18.0, weight: UIFontWeightMedium)
        pokemonNameLabel.textColor = UIColor.whiteColor()

        pokemonCombatPowerLabel.font = UIFont.systemFontOfSize(12.0, weight: UIFontWeightMedium)
        pokemonCombatPowerLabel.textColor = UIColor.appButtonBorderYellowColor()

        pokemonImage.backgroundColor = UIColor.whiteColor()
        pokemonImage.layer.cornerRadius = 30.0
        pokemonImage.layer.borderWidth = 3.0
        pokemonImage.layer.borderColor = UIColor.appButtonBorderYellowColor().CGColor
        backgroundColor = UIColor.appSplashScreenBackgroundColor()
    }

//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setupLayout()
//    }
//
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        setupLayout()
//    }
}
