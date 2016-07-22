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

        static let didLogoutByUserNotification = "com.nowthisnews.switchboard.account.didLogoutByUserNotification"
        static let didLogoutNotification = "com.nowthisnews.switchboard.account.didLogoutNotification"

        static let isLoggedInKey = "com.nowthisnews.switchboard.account.isLoggedIn"
        static let userDefaultsAccountDataKey = "com.nowthisnews.switchboard.account.accountData"
        static let accessTokenKey = "com.nowthisnews.switchboard.account.accessToken"
        static let refreshTokenKey = "com.nowthisnews.switchboard.account.refreshToken"
        static let idTokenKey = "com.nowthisnews.switchboard.account.idToken"
        static let keychainUserAccountKey = "com.nowthisnews.switchboard.account.keychainUserAccount"
    }
}
