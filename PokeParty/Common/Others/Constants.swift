//
//  Constants.swift
//  Switchboard
//
//  Created by Jakub Warchoł on 24.05.2016.
//  Copyright © 2016 nowthisnews. All rights reserved.
//

import UIKit

struct Constants {

    struct Layout {
        
        static let textMargin: CGFloat = 23.0
        static let formSeparatorHeight: CGFloat = 0.5
        static let listSeparatorHeight: CGFloat = 1.0
        static let contentMediumMargin: CGFloat = 17.0
        static let contentLowMargin: CGFloat = 12.0
        static let bottomButtonHeight: CGFloat = 48.0
        static let iconCornerRadius: CGFloat  = 2.0
    }

    struct Pitching {

        struct Validation {

            static let minimumValidEditorialCriteriaCount = 2
        }
    }
    
    struct Media {
        
        static let videoThumbnailPath = "thumbnail/medium"
    }

    struct Account {

        static let didLogoutByUserNotification = "com.tooploox.apps.PokeParty.account.didLogoutByUserNotification"
        static let didLogoutNotification = "com.tooploox.apps.PokeParty.account.didLogoutNotification"

        static let isLoggedInKey = "com.tooploox.apps.PokeParty.account.isLoggedIn"
        static let userDefaultsAccountDataKey = "com.tooploox.apps.PokeParty.account.accountData"
        static let accessTokenKey = "com.tooploox.apps.PokeParty.account.accessToken"
        static let refreshTokenKey = "com.tooploox.apps.PokeParty.account.refreshToken"
        static let idTokenKey = "com.tooploox.apps.PokeParty.account.idToken"
        static let keychainUserAccountKey = "com.tooploox.apps.PokeParty.account.keychainUserAccount"
    }
}
