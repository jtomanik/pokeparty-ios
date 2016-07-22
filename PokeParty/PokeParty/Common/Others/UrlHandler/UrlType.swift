//
//  UrlType.swift
//  Switchboard
//
//  Created by Sebastian Osiński on 05/06/16.
//  Copyright © 2016 nowthisnews. All rights reserved.
//

import Foundation

enum UrlType {
    case Known(scheme: CustomScheme)
    case Other
}

extension NSURL {
    
    var type: UrlType {
        guard let
            components = NSURLComponents(URL: self, resolvingAgainstBaseURL: false),
            path = components.path
        where components.host == "docs.google.com"
        else {
            return .Other
        }
        
        if path.hasPrefix("/document") {
            return .Known(scheme: .GoogleDocs)
        }
            
        if path.hasPrefix("/spreadsheets") {
            return .Known(scheme: .GoogleSheets)
        }
        
        return .Other
    }
}