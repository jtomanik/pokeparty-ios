//
//  UIStackView+AddArrangedSubviews.swift
//  Switchboard
//
//  Created by Jakub Warchoł on 28.04.2016.
//  Copyright © 2016 nowthisnews. All rights reserved.
//

import UIKit


class StackViewSectionHeader: UIView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFontOfSize(12.0)
        label.textColor = UIColor.appTextColor40Alpha()
        return label
    }()

    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        addSubview(titleLabel)
        NSLayoutConstraint.activateConstraints([
            titleLabel.topAnchor.constraintEqualToAnchor(topAnchor, constant: 8.0),
            titleLabel.bottomAnchor.constraintEqualToAnchor(bottomAnchor, constant: -8.0),
            titleLabel.leadingAnchor.constraintEqualToAnchor(leadingAnchor, constant: 8.0),
            titleLabel.trailingAnchor.constraintEqualToAnchor(trailingAnchor, constant: -8.0)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension UIStackView {
    
    func addArrangedSubviews(views: [UIView]) {
        views.forEach(addArrangedSubview)
    }

    func addArrangedSubviewSections(viewSections: [[UIView]], sectionTitles titles: [String]? = nil, withSectionBackground color: UIColor = UIColor.whiteColor(), addAutomaticSectionSeparators: Bool = true) {
        viewSections.forEach { subviews in
            let sectionStackView = UIStackView(arrangedSubviews: subviews)
            sectionStackView.axis = axis

            if addAutomaticSectionSeparators {
                sectionStackView.insertArrangedSubview(
                    SeparatorLine(type: .Form),
                    atIndex: sectionStackView.arrangedSubviews.startIndex
                )
                sectionStackView.insertArrangedSubview(
                    SeparatorLine(type: .Form),
                    atIndex: sectionStackView.arrangedSubviews.endIndex
                )
            }

            subviews.forEach { $0.backgroundColor = color }

            addArrangedSubview(sectionStackView)
        }

        if let titles = titles {
            for index in 0..<titles.count {
                addSectionTitle(titles[index], atIndex: index)
            }
        }
    }

    func addSectionTitle(title: String, atIndex index: Int) {
        guard let sectionStackView = arrangedSubviews[index] as? UIStackView else {
            return
        }

        let headerView = StackViewSectionHeader(title: title)
        sectionStackView.insertArrangedSubview(headerView, atIndex: 0)
    }
}