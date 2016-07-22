//
//  FormViewFactory.swift
//  Switchboard
//
//  Created by Jakub Warchoł on 19.05.2016.
//  Copyright © 2016 nowthisnews. All rights reserved.
//

import UIKit

enum FormViewType {
    case Email
    case Password
}

final class FormViewFactory {

    class func view(ofType type: FormViewType) -> FormView {
        switch type {
            case .Email:
                let emailForm = FormViewFactory.emailForm()
                emailForm.keyboardType = .EmailAddress
                emailForm.autocapitalizationType = .None
                emailForm.validator = TextValidatorFactory.textValidator(ofType: .NonEmptyValidator)
                return emailForm
            case .Password:
                let passwordForm = FormViewFactory.passwordForm()
                passwordForm.secureTextEntry = true
                passwordForm.validator = TextValidatorFactory.textValidator(ofType: .NonEmptyValidator)
                return passwordForm
        }
    }

    private class func emailForm() -> FormView {
         return FormView(
            placeholder: NSLocalizedString("LOGIN_EMAIL_PLACEHOLDER", comment: "Email placeholder"),
            validIcon: UIImage(named: "emailIconBlue")!,
            invalidIcon: UIImage(named: "emailIcon")!
        )
    }

    private class func passwordForm() -> FormView {
        return FormView(
            placeholder: NSLocalizedString("LOGIN_PASSWORD_PLACEHOLDER", comment: "Password placeholder"),
            validIcon: UIImage(named: "passwordIconBlue")!,
            invalidIcon: UIImage(named: "passwordIcon")!
        )
    }
}
