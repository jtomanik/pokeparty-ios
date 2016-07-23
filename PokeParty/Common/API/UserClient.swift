//
//  UserClient.swift
//  PokeParty
//
//  Created by Jaroslaw Gliwinski on 2016-07-23.
//  Copyright © 2016 tooploox. All rights reserved.
//

import Foundation
import PokePartyShared


typealias UserClientCompletion = (User?, ApiError?) -> Void


class UserClient {

    static let sharedInstance = UserClient()

    let apiClient = ApiClient.sharedInstance

    func googleAuth(id: String, completion: UserClientCompletion) {
        let action = SignupAction.googleAuth
        let request = apiClient.requestFor(action, queryItems: [NSURLQueryItem(name: "id", value: id)])

        apiClient.send(request) { json, response, error in
            guard let json = json else {
                completion(nil, error ?? .UnknownError)
                return assertionFailure("No JSON")
            }
            let user = UserAdapter.decode(raw: json)
            completion(user, nil)
        }
    }

    func userSetup(user: User, completion: UserClientCompletion) {
        let action = SignupAction.userSetup
        let request = try! apiClient.requestFor(action, payload: UserAdapter.encode(model: user)?.rawData())

        apiClient.send(request) { json, response, error in
            guard let json = json else {
                completion(nil, error ?? .UnknownError)
                return assertionFailure("No JSON")
            }
            let user = UserAdapter.decode(raw: json)
            completion(user, nil)
        }
    }
}




