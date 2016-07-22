//
//  AccountDataProviderFactory.swift
//  Switchboard
//
//  Created by Jakub Warchoł on 15.07.2016.
//  Copyright © 2016 nowthisnews. All rights reserved.
//

import Foundation

final class AccountDataProviderFactory {

    class func userDefaultsAccountDataProvider() -> AccountDataProvider {
        return UserDefaultsAccountDataProvider.sharedInstance
    }
}