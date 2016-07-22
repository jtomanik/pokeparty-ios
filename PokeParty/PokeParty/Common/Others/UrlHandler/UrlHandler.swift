//
//  UrlHandler.swift
//  Switchboard
//
//  Created by Sebastian Osiński on 05/06/16.
//  Copyright © 2016 nowthisnews. All rights reserved.
//

import Foundation
import SafariServices

class UrlHandler {
    
    func handleUrl(url: NSURL) {
        switch url.type {
            case .Known(let scheme):
                handleCustomScheme(scheme, url: url)
            case .Other:
                showSafariViewController(for: url)
        }
    }
    
    private func handleCustomScheme(scheme: CustomScheme, url: NSURL) {
        guard let components = NSURLComponents(URL: url, resolvingAgainstBaseURL: false) else {
            showSafariViewController(for: url)
            return
        }
        components.scheme = scheme.rawValue
        
        let application = UIApplication.sharedApplication()
        
        guard let
            customUrl = components.URL
        where application.canOpenURL(customUrl) && application.openURL(customUrl)
        else {
            showSafariViewController(for: url)
            return
        }
    }
    
    private func showSafariViewController(for url: NSURL) {
        guard let components = NSURLComponents(URL: url, resolvingAgainstBaseURL: false) else {
            return assertionFailure("Couldn't create components from url!")
        }
        
        if components.scheme != "http" && components.scheme != "https" {
            components.scheme = "http"
        }
        
        guard let httpUrl = components.URL else {
            return assertionFailure("Couldn't create url!")
        }
        
        let safariViewController = SFSafariViewController(URL: httpUrl)
        let topViewController = UIApplication.sharedApplication().topViewController
        topViewController?.presentViewController(safariViewController, animated: true, completion: nil)
    }
}
