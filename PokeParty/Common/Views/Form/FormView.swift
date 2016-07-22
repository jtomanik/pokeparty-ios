//
//  FormView.swift
//  Switchboard
//
//  Created by Jakub Warchoł on 19.05.2016.
//  Copyright © 2016 nowthisnews. All rights reserved.
//

import UIKit

protocol FormViewDelegate: class {
    func formViewDidValidate(formView: FormView)
}


final class FormView: UIView {

    weak var delegate: FormViewDelegate?

    private let stackView = UIStackView()
    private let inputTextField = UITextField()
    private let icon = UIImageView()
    private let validIcon: UIImage
    private let invalidIcon: UIImage

    private let placeholderAttributes = [
        NSFontAttributeName : UIFont.systemFontOfSize(14.0),
        NSForegroundColorAttributeName : UIColor.appTextColor20Alpha()
    ]

    var text: String? {
        get {
            return inputTextField.text
        }
        set {
            inputTextField.text = newValue
        }
    }

    var autocapitalizationType: UITextAutocapitalizationType = .Sentences {
        didSet {
            inputTextField.autocapitalizationType = autocapitalizationType
        }
    }

    var keyboardType: UIKeyboardType = .Default {
        didSet {
            inputTextField.keyboardType = keyboardType
        }
    }

    var secureTextEntry: Bool = false {
        didSet {
            inputTextField.secureTextEntry = secureTextEntry
        }
    }

    var validator: TextValidator?
    var valid = false

    // MARK: - Inits

    init(placeholder: String, validIcon: UIImage, invalidIcon: UIImage) {
        self.validIcon = validIcon
        self.invalidIcon = invalidIcon
        self.icon.image = invalidIcon
        super.init(frame: .zero)
        setupViewHierarchy()
        setupStackView()
        setupIcon()
        setupInputTextField(placeholder)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Setup

    private func setupViewHierarchy() {
        addSubview(stackView)
    }

    private func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints([
            stackView.topAnchor.constraintEqualToAnchor(topAnchor),
            stackView.trailingAnchor.constraintEqualToAnchor(trailingAnchor),
            stackView.leadingAnchor.constraintEqualToAnchor(leadingAnchor),
            stackView.bottomAnchor.constraintEqualToAnchor(bottomAnchor),
            stackView.heightAnchor.constraintEqualToConstant(51.0)
        ])
        stackView.axis = .Horizontal
        stackView.addArrangedSubviews([icon, inputTextField])
    }

    private func setupIcon() {
        icon.setContentHuggingPriority(UILayoutPriorityDefaultHigh, forAxis: .Horizontal)
        icon.contentMode = .ScaleAspectFit
    }

    private func setupInputTextField(placeholder: String) {
        inputTextField.textColor = UIColor.appTextColor60Alpha()
        inputTextField.font = UIFont.systemFontOfSize(14.0)
        inputTextField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: placeholderAttributes)
        inputTextField.textAlignment = .Center
        inputTextField.inputAccessoryView = defaultAccessoryView(#selector(finishEditing))
        inputTextField.addTarget(self, action: #selector(afterTextChange), forControlEvents: .EditingChanged)
    }

    @objc private func afterTextChange() {
        valid = validator?.isValid(inputTextField.text) ?? true
        delegate?.formViewDidValidate(self)
    }

    @objc private func finishEditing() {
        inputTextField.resignFirstResponder()
    }

    // MARK: - Public 

    func setInvalidColors() {
        icon.image = invalidIcon
        inputTextField.textColor = UIColor.appTextColor60Alpha()
    }

    func setValidColors() {
        icon.image = validIcon
        inputTextField.textColor = UIColor.appDodgerBlueTwoColor()
    }

    override func resignFirstResponder() -> Bool {
        inputTextField.resignFirstResponder()
        return true
    }
}