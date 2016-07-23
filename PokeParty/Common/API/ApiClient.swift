//
//  ApiClient.swift
//  PokeParty
//
//  Created by Jaroslaw Gliwinski on 2016-07-23.
//  Copyright © 2016 tooploox. All rights reserved.
//

import Foundation
import PokePartyShared


enum ApiError: ErrorType {
    case NotHttp
    case NoDataReturned
    case WrongDataFormat
    case CannotDeserialize
    case UnderlyingDataTaskError(NSError)
    case AuthenticationInvalid
    case PermissionDenied
    case ServerInternalError
    case EndpointDoesNotExist(message: String)
    case UnknownError
}


typealias ApiUrlSessionTaskCompletion = (NSData?, NSURLResponse?, ApiError?) -> Void


extension NSURLSession {

    func startedTaskWith(request: NSURLRequest, completion: ApiUrlSessionTaskCompletion) -> NSURLSessionDataTask {
        let task = dataTaskWithRequest(request) { data, response, error in
            if let error = error {
                return completion(nil, response, .UnderlyingDataTaskError(error))
            }

            guard let httpResponse = response as? NSHTTPURLResponse else {
                return completion(nil, response, .NotHttp)
            }

            guard httpResponse.statusCode != 401 else {
                return completion(nil, response, .AuthenticationInvalid)
            }

            guard httpResponse.statusCode != 403 else {
                return completion(nil, response, .PermissionDenied)
            }

            guard httpResponse.statusCode != 500 else {
                return completion(nil, response, .ServerInternalError)
            }

            guard let data = data else {
                return completion(nil, response, .NoDataReturned)
            }

            completion(data, response, nil)
        }
        
        task.resume()
        return task
    }
}


typealias ApiClientCompletion = (JSON?, NSURLResponse?, ApiError?) -> Void


class ApiClient {

    static let sharedInstance = ApiClient()

    private let urlSession = NSURLSession.sharedSession()

    func send(request: NSURLRequest, completion: ApiClientCompletion) -> NSURLSessionDataTask {
        return urlSession.startedTaskWith(request) { data, response, error in

            guard let data = data else {
                return completion (nil, response, error)
            }

            completion(JSON(data: data), response, error)
        }
    }
}
