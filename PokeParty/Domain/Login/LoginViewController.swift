//
//  LoginViewController.swift
//  Switchboard
//
//  Created by Jakub Warchoł on 19.05.2016.
//  Copyright © 2016 nowthisnews. All rights reserved.
//

import UIKit


protocol LoginViewControllerDelegate: class {
    func loginViewController(loginViewController: LoginViewController, didLoginWithEmail email: String, andPassword password: String)
}


class LoginViewController: UIViewController {

    private let logo = UIImageView(image: UIImage(named: "logo"))
    private let loginForms = LoginFormsView()
    private let scrollView = UIScrollView()
    private let helpTextsContainer = UIView()
    private let helpLabelsContainer = UIView()
    private let helpHeader = UILabel()
    private let helpText = UITextView()

    weak var delegate: LoginViewControllerDelegate?

    // MARK: - View Lifecycle

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        scrollView.startKeyboardAvoidance()
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        scrollView.stopKeyboardAvoidance()
        loginForms.resignFirstResponder()
    }

    // MARK: - View Setup

    override func loadView() {
        view = UIView()
        setupViewHierachy()
        setupView()
        setupScrollView()
        setupLogo()
        setupLoginForms()
        setupHelpHeader()
        setupHelpText()
        setupHelpLabelsContainer()
        setupHelpTextsContainer()
    }

    private func setupViewHierachy() {
        view.addSubview(scrollView)
        view.addSubview(helpTextsContainer)
        helpTextsContainer.addSubview(helpLabelsContainer)
        helpLabelsContainer.addSubview(helpHeader)
        helpLabelsContainer.addSubview(helpText)
        scrollView.addSubview(logo)
        scrollView.addSubview(loginForms)
    }

    private func setupView() {
        view.backgroundColor = UIColor.whiteColor()
    }

    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints([
            scrollView.topAnchor.constraintEqualToAnchor(view.topAnchor),
            scrollView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor),
            scrollView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor),
            scrollView.bottomAnchor.constraintEqualToAnchor(helpTextsContainer.topAnchor),
            scrollView.heightAnchor.constraintEqualToConstant(392.0)
        ])
    }

    private func setupLogo() {
        logo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints([
            logo.centerXAnchor.constraintEqualToAnchor(scrollView.centerXAnchor),
            logo.topAnchor.constraintEqualToAnchor(scrollView.topAnchor, constant: 60.0),
        ])
    }

    private func setupLoginForms() {
        loginForms.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints([
            loginForms.topAnchor.constraintEqualToAnchor(logo.bottomAnchor, constant: 60.0),
            loginForms.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -37.0),
            loginForms.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 37.0),
            loginForms.bottomAnchor.constraintEqualToAnchor(scrollView.bottomAnchor),
        ])
        loginForms.delegate = self
    }

    private func setupHelpHeader() {
        helpHeader.font = UIFont.systemFontOfSize(12.0)
        helpHeader.textColor = UIColor.appTextColor60Alpha()
        helpHeader.text = NSLocalizedString("LOGIN_HELP_TITLE", comment: "Login help title")
        helpHeader.textAlignment = .Center
        helpHeader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints([
            helpHeader.topAnchor.constraintEqualToAnchor(helpLabelsContainer.topAnchor),
            helpHeader.trailingAnchor.constraintEqualToAnchor(helpLabelsContainer.trailingAnchor),
            helpHeader.leadingAnchor.constraintEqualToAnchor(helpLabelsContainer.leadingAnchor),
            helpHeader.bottomAnchor.constraintEqualToAnchor(helpText.topAnchor, constant: -12.0)
        ])
    }

    private func setupHelpText() {
        helpText.font = UIFont.systemFontOfSize(14.0)
        helpText.textColor = UIColor.appTextColor60Alpha()
        helpText.textContainerInset = UIEdgeInsetsZero
        helpText.text = NSLocalizedString("LOGIN_HELP_TEXT", comment: "Login help text")
        helpText.textAlignment = .Center
        helpText.editable = false
        helpText.scrollEnabled = false
        helpText.dataDetectorTypes = .Link
        helpText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints([
            helpText.trailingAnchor.constraintEqualToAnchor(helpLabelsContainer.trailingAnchor),
            helpText.leadingAnchor.constraintEqualToAnchor(helpLabelsContainer.leadingAnchor),
            helpText.bottomAnchor.constraintEqualToAnchor(helpLabelsContainer.bottomAnchor)
        ])
    }

    private func setupHelpLabelsContainer() {
        helpLabelsContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints([
            helpLabelsContainer.centerXAnchor.constraintEqualToAnchor(helpTextsContainer.centerXAnchor),
            helpLabelsContainer.centerYAnchor.constraintEqualToAnchor(helpTextsContainer.centerYAnchor),
            helpLabelsContainer.heightAnchor.constraintEqualToConstant(56.0)
        ])
    }

    private func setupHelpTextsContainer() {
        helpTextsContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints([
            helpTextsContainer.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor),
            helpTextsContainer.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor),
            helpTextsContainer.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor),
        ])
    }
}


extension LoginViewController: LoginFormsViewDelegate  {

    func loginFormsView(loginFormsView: LoginFormsView, didLoginWithEmail email: String, andPassword password: String) {
        delegate?.loginViewController(self, didLoginWithEmail: email, andPassword: password)
    }
}
