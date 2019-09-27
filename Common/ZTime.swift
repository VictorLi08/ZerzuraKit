//
//    DateTime.swift
//    ZerzuraKit
//
//    Copyright (c) 2019 Victor Li
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.

import Foundation

public extension Date {
    /**
     Generates a localized time string, i.e. 12:00 PM.
     
     - Parameter style: A DateFormatter.Style option that decides the string's brevity or length.
     - Parameter withSeconds: Whether or not the time string should include seconds (default no).
     - Parameter locale: The locale that the string should be formatted for. If none is provided, the device's current locale is used.
     
     - Returns: A String representing the current time.
     */
    func string(style: DateFormatter.Style, withSeconds: Bool? = false, locale: Locale? = ZDevice.preferredLocale()) -> String {
        let df = DateFormatter()
        
        df.locale = locale
        df.dateStyle = .none
        df.timeStyle = style
        
        return df.string(from: self)
    }
    
    /**
     Generates a time string in UTC.
     
     - Parameter style: A DateFormatter.Style option that decides the string's brevity or length.
     
     - Returns: A String representing the current time in UTC.
     */
    func utc(style: DateFormatter.Style) -> String {
        let df = DateFormatter()
        df.locale = ZDevice.preferredLocale()
        df.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        df.timeStyle = style
        df.dateStyle = .none
        return df.string(from: self)
    }
    
    /**
     A dictionary containing the Date's time component integer values keyed by component type.
    */
    var components: [Calendar.Component:Int] {
       let componentTypes: [Calendar.Component] = [.era, .year, .quarter, .month, .weekOfYear, .weekOfMonth, .weekday, .hour, .minute, .second, .nanosecond]
       var componentValues: [Calendar.Component:Int] = [:]
       for c in componentTypes {
           componentValues.updateValue(Calendar.current.component(c, from: self), forKey: c)
       }
       return componentValues
    }
    
    /**
     Produces a TimeInterval between this date and the given date.
     
     - Parameter until: A future date that will be referenced.
    
     - Returns: A TimeInterval representing the number of seconds between dates.
     */
    func timeIntervalSince1970(until: Date) -> TimeInterval {
        return TimeInterval(until.timeIntervalSince1970 - self.timeIntervalSince1970)
    }
    
    /**
     Produces a TimeInterval between two dates.
    
     - Returns: A TimeInterval representing the number of seconds between dates.
     */
    func timeIntervalBetween(from: Date, to: Date) -> TimeInterval {
        return TimeInterval(to.timeIntervalSince1970 - from.timeIntervalSince1970)
    }
    
    /**
     Generates a localized string representing the time interval between two dates.
     
     - Parameter from: A Date() representing the start reference date.
     - Parameter to: A Date() representing the end reference date.
     
     - Returns: A localized string representing the time between dates (e.g. 3 days; 10 hours; 30 minutes; etc.).
    */
    static func stringBetween(from: Date, to: Date) -> String? {
        // prepare the time formatter based on locale
        var systemCalendar = Calendar.current
        systemCalendar.locale = ZDevice.preferredLocale()
        
        let timeFormatter = DateComponentsFormatter()
        timeFormatter.calendar = systemCalendar
        timeFormatter.unitsStyle = .full
        
        // extract time components from timeframe
        let allowedComponents: Set<Calendar.Component> = [.year, .month, .weekOfMonth, .day, .hour, .minute, .second]
        let components = systemCalendar.dateComponents(allowedComponents, from: from, to: to)
        
        // prepare time formatter from components
        if components.year ?? 0 > 0 {
            timeFormatter.allowedUnits = .year
        }
        else if components.month ?? 0 > 0 {
            timeFormatter.allowedUnits = .month
        }
        else if components.weekOfMonth ?? 0 > 0 {
            timeFormatter.allowedUnits = .weekOfMonth
        }
        else if components.day ?? 0 > 0 {
            timeFormatter.allowedUnits = .day
        }
        else if components.hour ?? 0 > 0 {
            timeFormatter.allowedUnits = .hour
        }
        else if components.minute ?? 0 > 0 {
            timeFormatter.allowedUnits = .minute
        }
        else {
            timeFormatter.allowedUnits = .second
        }
        
        return timeFormatter.string(for: components)
    }
}

public extension TimeInterval {
    /**
     Generates a localized string representing a time interval (e.g. 3 days; 10 hours; 30 minutes; etc.)..
     
     - Parameter timeInterval: The time (in seconds) to be converted.
     */
    var string: String? {
        // prepare abstract dates
        let to = Date()
        let from = Date(timeIntervalSince1970: to.timeIntervalSince1970 - self.advanced(by: 0))
        
        return Date.stringBetween(from: from, to: to)
    }
}
