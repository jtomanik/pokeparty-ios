//
//  TextValidator.swift
//  Switchboard
//
//  Created by Jakub Warchoł on 19.05.2016.
//  Copyright © 2016 nowthisnews. All rights reserved.
//

import Foundation

final class TextValidator {

    private let pattern: String

    // MARK: - Init

    init(pattern: String) {
        self.pattern = pattern
    }

    // MARK: - Public

    func isValid(text: String?) -> Bool {
        guard let text = text where text != "" else {
            return false
        }
        
        let regex = try! NSRegularExpression(pattern: pattern, options: .CaseInsensitive)
        return regex.firstMatchInString(text, options: [], range: NSMakeRange(0, text.characters.count)) != nil
    }
}

