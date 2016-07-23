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
            NSOperationQueue.mainQueue().addOperationWithBlock {
                guard let data = data else {
                    return completion (nil, response, error)
                }

                completion(JSON(data: data), response, error)
            }
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

            if let queryItems = queryItems {
                let urlComponents = NSURLComponents(string: action.absoluteString)
                urlComponents?.queryItems = queryItems
                let url = urlComponents!.URL!

                request = NSMutableURLRequest(URL: url)
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
