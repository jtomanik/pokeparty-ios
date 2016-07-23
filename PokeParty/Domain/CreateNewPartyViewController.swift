//
//  File.swift
//  PokeParty
//
//  Created by Jakub Warchoł on 22.07.2016.
//  Copyright © 2016 tooploox. All rights reserved.
//

import UIKit

class CreateNewPartyViewController: UIViewController {

    private lazy var createNewTeamButton: UIButton = {
        let button = UIButton()
        button.setTitle("Go!", forState: .Normal)
        button.setTitleColor(UIColor.appButtonBorderYellowColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(20.0, weight: UIFontWeightMedium)
        button.layer.cornerRadius = 9.0
        button.layer.borderWidth = 3.0
        button.backgroundColor = UIColor.appButtonBackgroundBlueColor()
        button.layer.borderColor = UIColor.appButtonBorderYellowColor().CGColor
        button.addTarget(self, action: #selector(onCreateNewTeam), forControlEvents: .TouchUpInside)
        return button
    }()

    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setTitle("Share this", forState: .Normal)
        button.setTitleColor(UIColor.appButtonBorderYellowColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(20.0, weight: UIFontWeightMedium)
        button.layer.cornerRadius = 9.0
        button.layer.borderWidth = 3.0
        button.backgroundColor = UIColor.appButtonBackgroundBlueColor()
        button.layer.borderColor = UIColor.appButtonBorderYellowColor().CGColor
        button.addTarget(self, action: #selector(onShare), forControlEvents: .TouchUpInside)
        button.hidden = true
        return button
    }()

    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Provide party name"
        label.font = UIFont.systemFontOfSize(20.0, weight: UIFontWeightSemibold)
        label.textColor = UIColor.whiteColor()
        return label
    }()

    private let partyNameTextField: UITextField = {
        let textfield = UITextField()

        textfield.font = UIFont.boldSystemFontOfSize(17.0)
        textfield.textColor = UIColor.appButtonBorderYellowColor()
        textfield.backgroundColor = UIColor.appButtonBackgroundBlueColor()
        textfield.layer.borderColor = UIColor.appTextFieldBorderColor().CGColor
        textfield.layer.borderWidth = 2.0
        textfield.layer.cornerRadius = 8.0
        textfield.textAlignment = .Center
        return textfield
    }()

    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .Horizontal
        return stackView
    }()

    var onClose: (Void -> Void)?
    var onCreate: (String -> Void)?

    private let stackView = UIStackView()

    override func loadView() {
        view = UIView()
        view.addSubview(headerLabel)
        view.addSubview(partyNameTextField)
        view.addSubview(buttonsStackView)
        view.backgroundColor = UIColor.appSplashScreenBackgroundColor()

        setupHeader()
        setupButtons()
        setupPartyNameTextField()

        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(onCloseView))

    }

    func onCloseView() {
        onClose?()
    }

    private func setupHeader() {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints([
            headerLabel.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor),
            headerLabel.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 100.0)
        ])
    }

    private func setupPartyNameTextField() {
        partyNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints([
            partyNameTextField.topAnchor.constraintEqualToAnchor(headerLabel.bottomAnchor, constant: 25.0),
            partyNameTextField.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 50.0),
            partyNameTextField.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -50.0),
            partyNameTextField.heightAnchor.constraintEqualToConstant(50.0)
        ])
    }

    private func setupButtons() {
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.addArrangedSubviews([createNewTeamButton, shareButton])

        NSLayoutConstraint.activateConstraints([
            buttonsStackView.topAnchor.constraintEqualToAnchor(partyNameTextField.bottomAnchor, constant: 25.0),
            buttonsStackView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 50.0),
            buttonsStackView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -50.0),
            buttonsStackView.heightAnchor.constraintEqualToConstant(60.0)
        ])
    }


    func onCreateNewTeam() {
        //network

        if let text = partyNameTextField.text {
            onCreate?(text)
            onClose?()
        }

        shareButton.hidden = !shareButton.hidden
        createNewTeamButton.hidden = !createNewTeamButton.hidden

        // on success change label text to party is ready ...
    }

    func onShare() {
        // action sheet
//        createNewTeamButton.hidden = !createNewTeamButton.hidden
//        shareButton.hidden = !shareButton.hidden

        let activityViewController = UIActivityViewController(activityItems: ["asd"], applicationActivities: nil)
        navigationController?.presentViewController(activityViewController, animated: true, completion: nil)
    }
}