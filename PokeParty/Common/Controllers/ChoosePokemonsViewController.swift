//
//  ChoosePokemonsViewController.swift
//  PokeParty
//
//  Created by Karol Kubicki on 22.07.2016.
//  Copyright © 2016 tooploox. All rights reserved.
//

import UIKit
import PokePartyShared


protocol ChoosePokemonsViewControllerDelegate: class {
    func choosePokemonsViewControllerDidTapDoneButton(viewController: ChoosePokemonsViewController)
}

class ChoosePokemonsViewController: UIViewController {

    weak var delegate: ChoosePokemonsViewControllerDelegate?

    private var selectedPokemons = [Pokemon]()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Select your pokemons"
        return label
    }()
    
    private lazy var countBadge: UIView = {
        let countBadge = UIView()
        countBadge.translatesAutoresizingMaskIntoConstraints = false
        countBadge.backgroundColor = UIColor.redColor()
        return countBadge
    }()
    
    private lazy var countBadgeLabel: UILabel = {
        let countBadgeLabel = UILabel()
        countBadgeLabel.text = "0"
        countBadgeLabel.translatesAutoresizingMaskIntoConstraints = false
        countBadgeLabel.textColor = UIColor.whiteColor()
        countBadgeLabel.textAlignment = .Center
        return countBadgeLabel
    }()
    
    private lazy var myPokemonsButton: UIControl = {
        let button = UIControl()
        button.layer.borderColor = UIColor.lightGrayColor().CGColor
        button.layer.borderWidth = 1.0
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .Center
        label.text = "My \(pokemonString)"
        
        self.countBadge.addSubview(self.countBadgeLabel)
        self.countBadgeLabel.topAnchor.constraintEqualToAnchor(self.countBadge.topAnchor).active = true
        self.countBadgeLabel.bottomAnchor.constraintEqualToAnchor(self.countBadge.bottomAnchor).active = true
        self.countBadgeLabel.leadingAnchor.constraintEqualToAnchor(self.countBadge.leadingAnchor).active = true
        self.countBadgeLabel.trailingAnchor.constraintEqualToAnchor(self.countBadge.trailingAnchor).active = true
        
        button.addSubview(label)
        label.centerXAnchor.constraintEqualToAnchor(button.centerXAnchor).active = true
        label.centerYAnchor.constraintEqualToAnchor(button.centerYAnchor).active = true
        
        button.addSubview(self.countBadge)
        self.countBadge.trailingAnchor.constraintEqualToAnchor(button.trailingAnchor, constant: -8.0).active = true
        self.countBadge.centerYAnchor.constraintEqualToAnchor(button.centerYAnchor).active = true
        self.countBadge.widthAnchor.constraintEqualToConstant(30.0).active = true
        self.countBadge.heightAnchor.constraintEqualToConstant(30.0).active = true
        self.countBadge.layer.cornerRadius = 15.0
        
        return button
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .System)
        button.tintColor = UIColor.whiteColor()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("I'm done", forState: .Normal)
        button.backgroundColor = UIColor.darkGrayColor()
        button.addTarget(self, action: #selector(onDoneButton), forControlEvents: .TouchUpInside)
        return button
    }()

    func onDoneButton() {
        delegate?.choosePokemonsViewControllerDidTapDoneButton(self)
    }
    
    var pokemonsController: PokemonsViewController
    
    var teamColor: UIColor
    
    init(teamColor: UIColor) {
        self.teamColor = teamColor
        self.pokemonsController = PokemonsViewController(teamColor: teamColor)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(titleLabel)
        view.addSubview(myPokemonsButton)
        view.addSubview(pokemonsController.view)
        view.addSubview(doneButton)

        titleLabel.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor, constant: 12.0).active = true
        titleLabel.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        
        myPokemonsButton.topAnchor.constraintEqualToAnchor(titleLabel.bottomAnchor, constant: 20.0).active = true
        myPokemonsButton.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 12.0).active = true
        myPokemonsButton.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -12.0).active = true
        myPokemonsButton.heightAnchor.constraintEqualToConstant(44.0).active = true
        
        pokemonsController.view.translatesAutoresizingMaskIntoConstraints = false
        addChildViewController(pokemonsController)
        pokemonsController.didMoveToParentViewController(self)
        pokemonsController.view.topAnchor.constraintEqualToAnchor(myPokemonsButton.bottomAnchor, constant: 12.0).active = true
        pokemonsController.view.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 12.0).active = true
        pokemonsController.view.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -12.0).active = true
        
        doneButton.topAnchor.constraintEqualToAnchor(pokemonsController.view.bottomAnchor, constant: 12.0).active = true
        doneButton.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 12.0).active = true
        doneButton.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -12.0).active = true
        doneButton.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -12.0).active = true
        doneButton.heightAnchor.constraintEqualToConstant(44.0).active = true
        
        myPokemonsButton.addTarget(self, action: #selector(onMyPokemonsSelected), forControlEvents: .TouchUpInside)
        
        pokemonsController.onPokemonSelected = { [unowned self] pokemon in
            self.showInsertCPAlert(pokemon)
        }
    }
    
    private func showInsertCPAlert(pokemon: Pokemon) {
        let alertController = UIAlertController(
            title: "Pokemon power",
            message: "Give us \(pokemon.name) Combat Power (CP)",
            preferredStyle: .Alert
        )
        alertController.addTextFieldWithConfigurationHandler { textField in
            textField.keyboardType = .DecimalPad
        }
        alertController.addAction(UIAlertAction(title: "Add", style: .Default) { _ in
            let text = alertController.textFields![0].text! as NSString
            self.selectedPokemons.append(Pokemon(number: pokemon.number, combatPower: text.integerValue))
            self.countBadgeLabel.text = "\(self.selectedPokemons.count)"
        })
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    @objc func onMyPokemonsSelected() {
        let myPokemonsVC = MyPokemonsViewController(pokemons: self.selectedPokemons, style: .Plain)
        navigationController?.pushViewController(myPokemonsVC, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
