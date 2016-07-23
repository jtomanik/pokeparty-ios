//
//  PartyClient.swift
//  PokeParty
//
//  Created by Jaroslaw Gliwinski on 2016-07-23.
//  Copyright © 2016 tooploox. All rights reserved.
//

import Foundation
import PokePartyShared


typealias PartyClientCompletion = (Party?, ApiError?) -> Void
typealias PartyClientDetailedCompletion = (DetailedParty?, ApiError?) -> Void


class PartyClient {

    static let sharedInstance = PartyClient()

    let apiClient = ApiClient.sharedInstance
    let accountData = AccountDataProviderFactory.userDefaultsAccountDataProvider()

    func create(name: String, completion: PartyClientCompletion) {
        let request = apiClient.requestFor(
            PartyAction.create,
            queryItems: [
                NSURLQueryItem(name: "name", value: name),
                NSURLQueryItem(name: "owner", value: accountData.userId)
            ]
        )

        apiClient.send(request) { json, response, error in
            guard let json = json else {
                completion(nil, error ?? .UnknownError)
                return assertionFailure("No Party JSON")
            }
            completion(PartyAdapter.decode(raw: json), nil)
        }
    }

    func join(hash: String, completion: PartyClientCompletion) {
        let request = apiClient.requestFor(
            PartyAction.join,
            queryItems: [
                NSURLQueryItem(name: "hash", value: hash),
                NSURLQueryItem(name: "user", value: accountData.userId)
            ]
        )

        apiClient.send(request) { json, response, error in
            guard let json = json else {
                completion(nil, error ?? .UnknownError)
                return assertionFailure("No Party JSON")
            }
            completion(PartyAdapter.decode(raw: json), nil)
        }
    }

    func update(party: Party, completion: PartyClientCompletion) {
        let request = apiClient.requestFor(
            PartyAction.update,
            queryItems: [
                NSURLQueryItem(name: "id", value: party.id)
            ]
        )

        apiClient.send(request) { json, response, error in
            guard let json = json else {
                completion(nil, error ?? .UnknownError)
                return assertionFailure("No Party JSON")
            }
            completion(PartyAdapter.decode(raw: json), nil)
        }
    }

    func details(id: String, completion: PartyClientDetailedCompletion) {
        let request = apiClient.requestFor(
            PartyAction.details,
            queryItems: [
                NSURLQueryItem(name: "id", value: id)
            ]
        )

        apiClient.send(request) { json, response, error in
            guard let json = json else {
                completion(nil, error ?? .UnknownError)
                return assertionFailure("No DetailedParty JSON")
            }
            completion(DetailedPartyAdapter.decode(raw: json), nil)
        }
    }
}
