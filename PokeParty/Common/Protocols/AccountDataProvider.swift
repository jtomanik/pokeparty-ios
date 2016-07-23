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
    var userName: String? { get set }
    var userLevel: Int { get set }
    var userPokemons: [Pokemon]? { get set }
    var userParty: Party? { get set }

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

    var userName: String? {
        get {
            return accountData?["com.tooploox.apps.userName"] as? String
        }
        set {
            accountData?["com.tooploox.apps.userName"] = newValue
        }
    }

    var userLevel: Int {
        get {
            return accountData?["com.tooploox.apps.userLevel"] as? Int ?? 1
        }
        set {
            accountData?["com.tooploox.apps.userLevel"] = newValue
        }
    }

    var userPokemons: [Pokemon]? {
        get {
            let pokemonJsonStrings = accountData?["com.tooploox.apps.userPokemons"] as? [String]
            let pokemonJson = pokemonJsonStrings?
                .flatMap { $0.dataUsingEncoding(NSUTF8StringEncoding) }
                .map { JSON(data: $0) }
            let pokemons = pokemonJson?.flatMap({ PokemonAdapter.parse(body: PayloadType.json($0)) as Pokemon? }) ?? [Pokemon]()
            return pokemons
        }
        set {
            let pokemonJsonStrings = newValue?.flatMap { PokemonAdapter.encode(model: $0)?.description }
            accountData?["com.tooploox.apps.userPokemons"] = pokemonJsonStrings
        }
    }

    var userParty: Party? {
        get {
            let partyJsonString = accountData?["com.tooploox.apps.userParty"] as? String

            guard let partyData = partyJsonString?.dataUsingEncoding(NSUTF8StringEncoding) else {
                return nil
            }

            let partyJson = JSON(data: partyData)
            let pokemon = PartyAdapter.parse(body: PayloadType.json(partyJson)) as Party?
            return pokemon
        }
        set {
            let partyJsonString = PartyAdapter.encode(model: newValue)?.description
            accountData?["com.tooploox.apps.userParty"] = partyJsonString
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