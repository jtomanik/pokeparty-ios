//
//  CreateEventViewController.swift
//  PokeParty
//
//  Created by Karol Kubicki on 23.07.2016.
//  Copyright © 2016 tooploox. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController {

    lazy var eventNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Event name"
        textField.heightAnchor.constraintEqualToConstant(44.0).active = true
        textField.layer.borderColor = UIColor.grayColor().CGColor
        textField.layer.borderWidth = 2.0
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = .Always
        return textField
    }()
    
    lazy var eventDescriptionTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Event description"
        textField.heightAnchor.constraintEqualToConstant(44.0).active = true
        textField.layer.borderColor = UIColor.grayColor().CGColor
        textField.layer.borderWidth = 2.0
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = .Always
        return textField
    }()
    
    lazy var eventLocationButton: UIButton = {
        let button = UIButton(type: .System)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add location", forState: .Normal)
        button.tintColor = .grayColor()
        button.layer.borderColor = UIColor.grayColor().CGColor
        button.layer.borderWidth = 2.0
        button.heightAnchor.constraintEqualToConstant(44.0).active = true
        button.addTarget(self, action: #selector(showLocation), forControlEvents: .TouchUpInside)
        return button
    }()
    
    lazy var goButton: UIButton = {
        let button = UIButton(type: .System)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Go!", forState: .Normal)
        button.heightAnchor.constraintEqualToConstant(44.0).active = true
        button.backgroundColor = UIColor.grayColor()
        button.tintColor = .whiteColor()
        return button
    }()
    
    lazy var stackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.alignment = .Fill
        $0.axis = .Vertical
        $0.spacing = 10.0
        $0.addArrangedSubviews([
            self.eventNameTextField, self.eventDescriptionTextField, self.eventLocationButton, self.goButton
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
    
    @objc private func showLocation() {
        
    }

}
