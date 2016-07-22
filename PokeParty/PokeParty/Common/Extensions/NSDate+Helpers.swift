//
//  NSDate+Helpers.swift
//  Switchboard
//
//  Created by Sebastian Osiński on 13/05/16.
//  Copyright © 2016 nowthisnews. All rights reserved.
//

import Foundation

extension NSDate {
    
    var startOfDay: NSDate {
        return NSCalendar.currentCalendar().startOfDayForDate(self)
    }
    
    var endOfDay: NSDate {
        let components = NSDateComponents()
        components.day = 1
        components.second = -1
        return NSCalendar.currentCalendar().dateByAddingComponents(
            components,
            toDate: startOfDay,
            options: []
        )!
    }
    
    private var startOfWeekAndInterval: (start: NSDate, interval: NSTimeInterval) {
        var startOfWeek: NSDate?
        var interval: NSTimeInterval = 0.0
        NSCalendar.currentCalendar().rangeOfUnit(.WeekOfYear, startDate: &startOfWeek, interval: &interval, forDate: self)
        return (startOfWeek!, interval)
    }
    
    var startOfWeek: NSDate {
        return startOfWeekAndInterval.start
    }
    
    var endOfWeek: NSDate {
        let (startOfWeek, interval) = startOfWeekAndInterval
        return startOfWeek.dateByAddingTimeInterval(interval)
    }
}