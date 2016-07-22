//
//  DateFormatter.swift
//  Switchboard
//
//  Created by Sebastian Osiński on 13/05/16.
//  Copyright © 2016 nowthisnews. All rights reserved.
//

import Foundation


// TODO: make this conditional taking into account localization
let dateFormat = "MM / dd / YYYY"
let dateAndTimeFormat = "MM / dd / YYYY  hh:mm a"


class DateFormatter {
    
    static let sharedFormatter = DateFormatter()
    
    private let dateFormatter: NSDateFormatter
    
    private init() {
        dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = dateFormat
    }
    
    func stringFromDate(date: NSDate, format: String = dateFormat) -> String {
        dateFormatter.dateFormat = format
        return dateFormatter.stringFromDate(date)
    }
}