//
//  SeparatorLine.swift
//  Switchboard
//
//  Created by Jakub Warchoł on 13.05.2016.
//  Copyright © 2016 nowthisnews. All rights reserved.
//

import UIKit

enum SeparatorLineType {
    case Form
    case List
}


class SeparatorLine: UIView {
    
    private let color: UIColor
    private let leftMargin: CGFloat
    private let height: CGFloat
    private let separatorLine =  UIView()
    
    // MARK: - Inits
    
    init(color: UIColor, height: CGFloat, leftMargin: CGFloat = 0.0) {
        self.color = color
        self.height = height
        self.leftMargin = leftMargin
        super.init(frame: .zero)
        setupViewHierarchy()
        setupView()
    }

    init(type: SeparatorLineType, leftMargin: CGFloat = 0.0) {
        switch type {
            case .Form:
                color = UIColor.appDarkSeparatorColor()
                height = 23.0
            case .List:
                color = UIColor.appLightSeparatorColor()
                height = 21.0
        }
        self.leftMargin = leftMargin
        super.init(frame: .zero)
        setupViewHierarchy()
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Setup
    
    private func setupViewHierarchy() {
        addSubview(separatorLine)
    }
    
    private func setupView() {
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        separatorLine.backgroundColor = color
        let heightConstraint = separatorLine.heightAnchor.constraintEqualToConstant(height)
        heightConstraint.priority = UILayoutPriorityDefaultHigh
        NSLayoutConstraint.activateConstraints([
            separatorLine.topAnchor.constraintEqualToAnchor(topAnchor),
            separatorLine.bottomAnchor.constraintEqualToAnchor(bottomAnchor),
            separatorLine.leadingAnchor.constraintEqualToAnchor(leadingAnchor, constant: leftMargin),
            separatorLine.trailingAnchor.constraintEqualToAnchor(trailingAnchor),
            heightConstraint
        ])
    }
}