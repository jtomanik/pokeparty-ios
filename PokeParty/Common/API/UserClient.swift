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
        let request = requestFor(action, queryItems: [NSURLQueryItem(name: "id", value: id)])

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
        let request = try! requestFor(action, payload: UserAdapter.encode(model: user)?.rawData())

        apiClient.send(request) { json, response, error in
            guard let json = json else {
                completion(nil, error ?? .UnknownError)
                return assertionFailure("No JSON")
            }
            let user = UserAdapter.decode(raw: json)
            completion(user, nil)
        }
    }

    func requestFor(action: Action, queryItems: [NSURLQueryItem]? = nil, payload: NSData? = nil) -> NSMutableURLRequest {
        let url = NSURL(string: action.absoluteString)!
        var request = NSMutableURLRequest(URL: url)

        switch action.method {
        case .get:
            guard let queryItems = queryItems else {
                assertionFailure("GET has to have Query Items (at least an empty array)")
                return request
            }
            request.HTTPMethod = "GET"

            let urlComponents = NSURLComponents(string: action.absoluteString)
            urlComponents?.queryItems = queryItems
            let url = urlComponents!.URL!

            request = NSMutableURLRequest(URL: url)
        case .post:
            guard let payload = payload else {
                assertionFailure("POST has to have Body")
                return request
            }
            request.HTTPMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")

            request.HTTPBody = payload
        default:
            assertionFailure("Unsupported Action Method")
        }

        return request
    }
}




