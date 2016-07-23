//
//  AccountDataProvider.swift
//  Switchboard
//
//  Created by Jakub Warchoł on 15.07.2016.
//  Copyright © 2016 nowthisnews. All rights reserved.
//

//import JWTDecode
import PokePartyShared


typealias AccountDataDictionary = [String: AnyObject]


protocol AccountDataProvider: class {
    var accountData: AccountDataDictionary? { get set }
    var accessToken: String? { get }
    var refreshToken: String? { get }
    var isLoggedIn: Bool { get }
    var userId: String? { get }
    var userTeam: Team? { get set }

    func set(data dataDictionary: AccountDataDictionary)
    func clear(asExplicitLogout byUser: Bool)
}


extension AccountDataProvider {

    var userId: String? {
        do {
//            return try idToken.map(JWTDecode.decode)?.subject
            return "fixme"
        } catch {
            fatalError("Erroneous JWT")
        }
    }

    var userTeam: Team? {
        get {
            if let string = accountData?["com.tooploox.apps.userTeam"] as? Int {
                return Team(rawValue: string)
            } else {
                return nil
            }
        }
        set {
            accountData?["com.tooploox.apps.userTeam"] = newValue?.rawValue
        }
    }

    var accessToken: String? {
        return accountData?[Constants.Account.accessTokenKey] as? String
    }

    var refreshToken: String? {
        return accountData?[Constants.Account.refreshTokenKey] as? String
    }

    var isLoggedIn: Bool {
        return accountData != nil
    }

    func set(data dataDictionary: AccountDataDictionary) {
        accountData = dataDictionary
    }

    func clear(asExplicitLogout logout: Bool) {
        accountData = nil
//        NSNotificationCenter.defaultCenter().postNotificationName(
//            logout ? Constants.Account.didLogoutByUserNotification : Constants.Account.didLogoutNotification,
//            object: nil
//        )
    }
}