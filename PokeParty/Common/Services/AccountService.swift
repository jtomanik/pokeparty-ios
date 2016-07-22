//
//  AccountService.swift
//  Switchboard
//
//  Created by Jakub Warchoł on 20.05.2016.
//  Copyright © 2016 nowthisnews. All rights reserved.
//

import Foundation

typealias LoginSuccessCallback = Void -> Void


final class AccountService {

    private let dataProvider: AccountDataProvider

    init(dataProvider: AccountDataProvider) {
        self.dataProvider = dataProvider
    }

//    func logIn(username: String, password: String, success: LoginSuccessCallback, failure: FailureCallback) {
//        ApiClient().request(
//            TokenRequest.SignOn(username: username, password: password),
//            completion: { results, _, error in
//                NSOperationQueue.mainQueue().addOperationWithBlock {
//                    if let error = error {
//                        failure(error)
//                        return
//                    }
//
//                    guard let tokens: [TokenRequestResponse] = results?.concreteResults() else {
//                        failure(ApiError.WrongDataFormat)
//                        return assertionFailure("No auth data in Token Message Response")
//                    }
//
//                    guard let accessToken = tokens.first?.accessToken else {
//                        failure(ApiError.WrongDataFormat)
//                        return assertionFailure("No accessToken in Token Message Response")
//                    }
//
//                    guard let refreshToken = tokens.first?.refreshToken else {
//                        failure(ApiError.WrongDataFormat)
//                        return assertionFailure("No refreshToken in Token Message Response")
//                    }
//
//                    guard let idToken = tokens.first?.idToken else {
//                        failure(ApiError.WrongDataFormat)
//                        return assertionFailure("No idToken in Token Message Response")
//                    }
//
//                    self.dataProvider.set(data: [
//                        Constants.Account.accessTokenKey: accessToken,
//                        Constants.Account.refreshTokenKey: refreshToken,
//                        Constants.Account.idTokenKey: idToken
//                    ])
//                    success()
//                }
//            }
//        )
//    }
//
//    func logOut() {
//        dataProvider.clear(asExplicitLogout: true)
//    }
//    
//    func getCurrentUser(success: User -> (), failure: FailureCallback) {
//        guard let id = dataProvider.userId else {
//            return
//        }
//    
//        ApiMessageService().send(Query.User(id: id), success: { results in
//            let users: [User] = results.concreteResults()
//            guard let user = users.first else {
//                return
//            }
//            success(user)
//        }, failure: failure)
//    }
}