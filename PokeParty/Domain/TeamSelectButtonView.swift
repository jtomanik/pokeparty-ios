//
//  TeamSelectButtonView.swift
//  PokeParty
//
//  Created by Jakub Warchoł on 22.07.2016.
//  Copyright © 2016 tooploox. All rights reserved.
//

import UIKit
import PokePartyShared

protocol TeamSelectButtonViewDelegate: class {
    func didTap(button: TeamSelectButtonView)
}

class TeamSelectButtonView: UIView {

    weak var delegate: TeamSelectButtonViewDelegate?

    var selected: Bool {
        get {
            return button.selected
        }
        set {
            button.selected = newValue
            if selected {
                backgroundColor = UIColor.appButtonBorderYellowColor().colorWithAlphaComponent(0.2)
            } else {
                backgroundColor = nil
            }
        }
    }

    var team: Team? = nil {
        didSet {
            if let team = team {
                switch team {
                    case .Mystic:
                        teamColorView.backgroundColor = UIColor.appMysticColor()
                    case .Valor:
                        teamColorView.backgroundColor = UIColor.appValorColor()
                    case .Instinct:
                        teamColorView.backgroundColor = UIColor.appInstinctColor()
                }
                teamNameLabel.text = team.rawValue
            }

        }
    }

    private lazy var button: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(onTap), forControlEvents: .TouchUpInside)
        button.backgroundColor = UIColor.clearColor()
        return button
    }()

    private let teamColorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25.0
        return view
    }()

    private let teamNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(16.0, weight: UIFontWeightMedium)
        label.textColor = UIColor.whiteColor()
        return label
    }()

    init() {
        super.init(frame: .zero)
        setup()
    }

    private func setup() {
        layer.cornerRadius = 3.0


        addSubview(teamColorView)
        addSubview(teamNameLabel)
        addSubview(button)

        button.translatesAutoresizingMaskIntoConstraints = false
        teamColorView.translatesAutoresizingMaskIntoConstraints = false
        teamNameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activateConstraints([
            button.topAnchor.constraintEqualToAnchor(topAnchor),
            button.trailingAnchor.constraintEqualToAnchor(trailingAnchor),
            button.leadingAnchor.constraintEqualToAnchor(leadingAnchor),
            button.bottomAnchor.constraintEqualToAnchor(bottomAnchor)
        ])

        NSLayoutConstraint.activateConstraints([
            teamColorView.topAnchor.constraintEqualToAnchor(topAnchor, constant: 10.0),
            teamColorView.centerXAnchor.constraintEqualToAnchor(centerXAnchor),
            teamColorView.heightAnchor.constraintEqualToConstant(50.0),
            teamColorView.widthAnchor.constraintEqualToConstant(50.0)
        ])

        NSLayoutConstraint.activateConstraints([
            teamNameLabel.topAnchor.constraintEqualToAnchor(teamColorView.bottomAnchor, constant: 15.0),
            teamNameLabel.centerXAnchor.constraintEqualToAnchor(centerXAnchor),
            teamNameLabel.bottomAnchor.constraintEqualToAnchor(bottomAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func onTap() {
        delegate?.didTap(self)
    }

}