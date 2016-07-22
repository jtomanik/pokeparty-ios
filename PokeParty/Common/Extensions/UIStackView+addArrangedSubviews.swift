//
//  UIStackView+addArrangedSubviews.swift
//  PokeParty
//
//  Created by Jakub Warchoł on 22.07.2016.
//  Copyright © 2016 tooploox. All rights reserved.
//

import UIKit

extension UIStackView {

    func addArrangedSubviews(views: [UIView]) {
        views.forEach(addArrangedSubview)
    }
}