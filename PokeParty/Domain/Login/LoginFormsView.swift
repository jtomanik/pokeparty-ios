    //
//  LoginFormsView.swift
//  Switchboard
//
//  Created by Jakub Warchoł on 19.05.2016.
//  Copyright © 2016 nowthisnews. All rights reserved.
//

import UIKit

protocol LoginFormsViewDelegate: class {
    func loginFormsView(loginFormsView: LoginFormsView, didLoginWithEmail email: String, andPassword password: String)
}


class LoginFormsView: UIView {

    private let formsStackView = UIStackView()
    private let email = FormViewFactory.view(ofType: .Email)
    private let password = FormViewFactory.view(ofType: .Password)
    private let separator = SeparatorLine(color: UIColor.appOnboardingSeparatorColor(), height: 2.0)
    private let login = UIButton()

    weak var delegate: LoginFormsViewDelegate?

    var formsAreValid: Bool {
        return email.valid && password.valid
    }

    // MARK: - Inits

    init() {
        super.init(frame: .zero)
        setupViewHierarchy()
        setupView()
        setupFormsStackView()
        setupLogin()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View Setup

    private func setupViewHierarchy() {
        addSubview(formsStackView)
        addSubview(login)
    }

    private func setupView() {
        email.delegate = self
        password.delegate = self
    }

    private func setupFormsStackView() {
        formsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints([
            formsStackView.topAnchor.constraintEqualToAnchor(topAnchor),
            formsStackView.trailingAnchor.constraintEqualToAnchor(trailingAnchor),
            formsStackView.leadingAnchor.constraintEqualToAnchor(leadingAnchor),
        ])
        formsStackView.axis = .Vertical
        formsStackView.addArrangedSubviews([email, separator, password])
    }

    private func setupLogin() {
        login.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints([
            login.topAnchor.constraintEqualToAnchor(formsStackView.bottomAnchor, constant: 40.0),
            login.trailingAnchor.constraintEqualToAnchor(trailingAnchor),
            login.leadingAnchor.constraintEqualToAnchor(leadingAnchor),
            login.bottomAnchor.constraintEqualToAnchor(bottomAnchor, constant: -20.0),
            login.heightAnchor.constraintEqualToConstant(44.0)
        ])
        login.setTitle(NSLocalizedString("LOGIN_BUTTON_TITLE", comment: "Login button title"), forState: .Normal)
        login.setTitleColor(UIColor.appTextColor60Alpha(), forState: .Normal)
        
        login.setBackgroundImage(UIImage.withColor(UIColor.appDodgerBlueTwoColor()), forState: .Normal)
        login.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        login.setBackgroundImage(UIImage.withColor(UIColor.whiteColor()), forState: .Disabled)
        login.setTitleColor(UIColor.appTextColor60Alpha(), forState: .Disabled)
        
        login.layer.cornerRadius = 13.0
        login.layer.borderWidth = 1
        login.layer.borderColor = UIColor.appLightSeparatorColor().CGColor
        login.clipsToBounds = true
        login.enabled = false
        login.addTarget(self, action: #selector(onLogin), forControlEvents: .TouchUpInside)
    }

    @objc private func onLogin() {
        guard let email = email.text, password = password.text else {
            return
        }
        delegate?.loginFormsView(self, didLoginWithEmail: email, andPassword: password)
    }

    override func resignFirstResponder() -> Bool {
        self.email.resignFirstResponder()
        self.password.resignFirstResponder()
        return true
    }
}


extension LoginFormsView: FormViewDelegate {

    func formViewDidValidate(formView: FormView) {
        if formsAreValid {
            email.setValidColors()
            password.setValidColors()
            separator.backgroundColor = UIColor.appDodgerBlueTwoColor()
            login.enabled = true
        } else {
            email.setInvalidColors()
            password.setInvalidColors()
            separator.backgroundColor = UIColor.appLightSeparatorColor()
            login.enabled = false
        }
    }
}

    
extension LoginFormsView: ComfortableViewingAreaView {
}