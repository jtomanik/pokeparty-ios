//
//  TextValidatorFactory.swift
//  Switchboard
//
//  Created by Jakub Warchoł on 19.05.2016.
//  Copyright © 2016 nowthisnews. All rights reserved.
//

enum TextValidatorType {
    case EmailValidator
    case PasswordValidator
    case NonEmptyValidator
}

final class TextValidatorFactory {

    private static let validEmailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    private static let validPasswordPattern = "^\\S{6,}$"
    private static let validNonEmptyPattern = ".+"

    // MARK: - Public

    class func textValidator(ofType type: TextValidatorType) -> TextValidator {
        switch type {
            case .EmailValidator:
                return TextValidator(pattern: TextValidatorFactory.validPasswordPattern)
            case .PasswordValidator:
                return TextValidator(pattern: TextValidatorFactory.validPasswordPattern)
            case .NonEmptyValidator:
                return TextValidator(pattern: TextValidatorFactory.validNonEmptyPattern)
        }
    }
}
