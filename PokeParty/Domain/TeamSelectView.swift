//
//  TeamSelectView.swift
//  PokeParty
//
//  Created by Jakub Warchoł on 23.07.2016.
//  Copyright © 2016 tooploox. All rights reserved.
//

import UIKit
import PokePartyShared

class TeamSelectView: UIView {

    private let valorTeamView = TeamSelectButtonView()
    private let mysticTeamView = TeamSelectButtonView()
    private let instincteamView = TeamSelectButtonView()
    private let stackView = UIStackView()

    init() {
        super.init(frame: .zero)
        setup()
    }

    func setup() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activateConstraints([
            stackView.topAnchor.constraintEqualToAnchor(topAnchor),
            stackView.trailingAnchor.constraintEqualToAnchor(trailingAnchor),
            stackView.leadingAnchor.constraintEqualToAnchor(leadingAnchor),
            stackView.bottomAnchor.constraintEqualToAnchor(bottomAnchor),
        ])

        valorTeamView.team = .valor
        mysticTeamView.team = .mystic
        instincteamView.team = .instinct

        valorTeamView.delegate = self
        mysticTeamView.delegate = self
        instincteamView.delegate = self

        stackView.addArrangedSubviews([valorTeamView, mysticTeamView, instincteamView])

        stackView.axis = .Horizontal
        stackView.distribution = .FillEqually
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TeamSelectView: TeamSelectButtonViewDelegate {
    func didTap(button: TeamSelectButtonView) {
        let selected = button.selected

        valorTeamView.selected = false
        mysticTeamView.selected = false
        instincteamView.selected = false

        button.selected = !selected
    }
}

