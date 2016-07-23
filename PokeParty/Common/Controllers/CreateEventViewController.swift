//
//  CreateEventViewController.swift
//  PokeParty
//
//  Created by Karol Kubicki on 23.07.2016.
//  Copyright © 2016 tooploox. All rights reserved.
//

import UIKit
import PokePartyShared

class CreateEventViewController: UIViewController {
    
    var onCreateEvent: ((name: String, description: String) -> Void)?
    
    lazy var eventTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Create event for party"
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(18.0)
        label.textColor = .whiteColor()
        return label
    }()

    lazy var eventNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Event name"
        textField.heightAnchor.constraintEqualToConstant(44.0).active = true
        
        textField.font = UIFont.boldSystemFontOfSize(17.0)
        textField.textColor = UIColor.appButtonBorderYellowColor()
        textField.backgroundColor = UIColor.appButtonBackgroundBlueColor()
        textField.layer.borderColor = UIColor.appTextFieldBorderColor().CGColor
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = 8.0
        textField.textAlignment = .Center
        textField.attributedPlaceholder = NSAttributedString(
            string: "Event name...",
            attributes: [NSForegroundColorAttributeName : UIColor(white: 1.0, alpha: 0.5)]
        )
        return textField
    }()
    
    lazy var eventDescriptionTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraintEqualToConstant(44.0).active = true
        
        textField.font = UIFont.boldSystemFontOfSize(17.0)
        textField.textColor = UIColor.appButtonBorderYellowColor()
        textField.backgroundColor = UIColor.appButtonBackgroundBlueColor()
        textField.layer.borderColor = UIColor.appTextFieldBorderColor().CGColor
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = 8.0
        textField.textAlignment = .Center
        textField.attributedPlaceholder = NSAttributedString(
            string: "Event description...",
            attributes: [NSForegroundColorAttributeName : UIColor(white: 1.0, alpha: 0.5)]
        )
        return textField
    }()
    
    lazy var eventLocationButton: UIButton = {
        let button = UIButton(type: .System)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add location", forState: .Normal)
        
        button.setTitleColor(UIColor.appButtonBorderYellowColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(20.0, weight: UIFontWeightMedium)
        button.layer.cornerRadius = 9.0
        button.layer.borderWidth = 3.0
        button.backgroundColor = UIColor.appButtonBackgroundBlueColor()
        button.layer.borderColor = UIColor.appButtonBorderYellowColor().CGColor

        button.heightAnchor.constraintEqualToConstant(44.0).active = true
        return button
    }()
    
    lazy var goButton: UIButton = {
        let button = UIButton(type: .System)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Go!", forState: .Normal)
        button.heightAnchor.constraintEqualToConstant(44.0).active = true
        
        button.setTitleColor(UIColor.appButtonBorderYellowColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(20.0, weight: UIFontWeightMedium)
        button.layer.cornerRadius = 9.0
        button.layer.borderWidth = 3.0
        button.backgroundColor = UIColor.appButtonBackgroundBlueColor()
        button.layer.borderColor = UIColor.appButtonBorderYellowColor().CGColor
        
//        button.backgroundColor = UIColor.grayColor()
//        button.tintColor = .whiteColor()
        button.addTarget(self, action: #selector(goButtonPressed), forControlEvents: .TouchUpInside)
        return button
    }()
    
    lazy var stackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.alignment = .Fill
        $0.axis = .Vertical
        $0.spacing = 10.0
        $0.addArrangedSubviews([
            self.eventTitleLabel, self.eventNameTextField, self.eventDescriptionTextField, self.goButton
            ])
        return $0
    }(UIStackView())
    
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(self.stackView)
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.appSplashScreenBackgroundColor()
        view.addSubview(scrollView)
        
        scrollView.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor).active = true
        scrollView.bottomAnchor.constraintEqualToAnchor(bottomLayoutGuide.topAnchor).active = true
        scrollView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
        scrollView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
        
        stackView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 12.0).active = true
        stackView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -12.0).active = true
        stackView.topAnchor.constraintEqualToAnchor(scrollView.topAnchor).active = true
        stackView.bottomAnchor.constraintEqualToAnchor(scrollView.bottomAnchor).active = true
    }
    
    @objc private func goButtonPressed() {
        guard let name = eventNameTextField.text, description = eventDescriptionTextField.text where name != "" && description != "" else {
            return
        }
        onCreateEvent?(name: name, description: description)
    }

}
