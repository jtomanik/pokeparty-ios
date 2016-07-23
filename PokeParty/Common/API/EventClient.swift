//
//  EventClient.swift
//  PokeParty
//
//  Created by Jaroslaw Gliwinski on 2016-07-23.
//  Copyright © 2016 tooploox. All rights reserved.
//

import Foundation
import PokePartyShared


typealias EventClientCompletion = (Event?, ApiError?) -> Void
typealias EventClientDetailedCompletion = (DetailedEvent?, ApiError?) -> Void


class EventClient {

    static let sharedInstance = EventClient()

    let apiClient = ApiClient.sharedInstance
    let accountData = AccountDataProviderFactory.userDefaultsAccountDataProvider()

    func create(name: String, description: String? = nil, latitude: Double, longitude: Double, completion: EventClientCompletion) {
        let request = apiClient.requestFor(
            EventAction.create,
            queryItems: [
                NSURLQueryItem(name: "name", value: name),
                NSURLQueryItem(name: "description", value: description),
                NSURLQueryItem(name: "latitude", value: "\(51.108056)"),
                NSURLQueryItem(name: "longitude", value: "\(17.020278)"),
                NSURLQueryItem(name: "owner", value: accountData.userId)
            ]
        )

        apiClient.send(request) { json, response, error in
            guard let json = json else {
                completion(nil, error ?? .UnknownError)
                return assertionFailure("No Event JSON")
            }
            completion(EventAdapter.decode(raw: json), nil)
        }
    }

    func join(hash: String, completion: EventClientCompletion) {
        let request = apiClient.requestFor(
            EventAction.join,
            queryItems: [
                NSURLQueryItem(name: "hash", value: hash),
                NSURLQueryItem(name: "user", value: accountData.userId)
            ]
        )

        apiClient.send(request) { json, response, error in
            guard let json = json else {
                completion(nil, error ?? .UnknownError)
                return assertionFailure("No Event JSON")
            }
            completion(EventAdapter.decode(raw: json), nil)
        }
    }

    func update(event: Event, completion: EventClientCompletion) {
        let request = apiClient.requestFor(
            EventAction.update,
            queryItems: [
                NSURLQueryItem(name: "id", value: event.id)
            ]
        )

        apiClient.send(request) { json, response, error in
            guard let json = json else {
                completion(nil, error ?? .UnknownError)
                return assertionFailure("No Event JSON")
            }
            completion(EventAdapter.decode(raw: json), nil)
        }
    }

    func details(id: String, completion: EventClientDetailedCompletion) {
        let request = apiClient.requestFor(
            EventAction.details,
            queryItems: [
                NSURLQueryItem(name: "id", value: id)
            ]
        )

        apiClient.send(request) { json, response, error in
            guard let json = json else {
                completion(nil, error ?? .UnknownError)
                return assertionFailure("No DetailedEvent JSON")
            }
            completion(DetailedEventAdapter.decode(raw: json), nil)
        }
    }
}