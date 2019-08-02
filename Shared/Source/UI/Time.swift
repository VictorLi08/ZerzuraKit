//
//  DateTime.swift
//  ZerzuraKit
//
//  Created by Victor Li on 4/22/19.
//  Copyright © 2019 Mesarthim. All rights reserved.
//

/**
 A class that defines methods used for converting time values to user-readable strings.
*/
public class ZTime {
    /**
     Generates a localized time string, i.e. 12:00 PM.
     
     - Parameter style: A DateFormatter.Style option that decides the string's brevity or length.
     - Parameter withSeconds: Whether or not the time string should include seconds (default no).
     - Parameter date: A Date() object representing the time to be displayed. If none is provided, the current date/time is used.
     - Parameter locale: The locale that the string should be formatted for. If none is provided, the device's current locale is used.
     
     - Returns: A String representing the current time.
     */
    public static func string(style: DateFormatter.Style, withSeconds: Bool? = false, date: Date? = Date(), locale: Locale? = ZDevice.preferredLocale()) -> String {
        let df = DateFormatter()
        
        df.locale = locale
        df.dateStyle = .none
        df.timeStyle = style
        
        return df.string(from: date!)
    }
    
    /**
     Generates a localized string representing the time interval between two dates.
     
     - Parameter from: A Date() representing the start reference date.
     - Parameter to: A Date() representing the end reference date.
     
     - Returns: A localized string representing the time between dates (e.g. 3 days; 10 hours; 30 minutes; etc.).
    */
    public static func string(from: Date, to: Date) -> String? {
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
    
    /**
     Generates a localized string representing a time interval.
     
     - Parameter timeInterval: The time (in seconds) to be converted.
     
     - Returns: A localized string representing the time between dates (e.g. 3 days; 10 hours; 30 minutes; etc.).
     */
    public static func string(timeInterval: TimeInterval) -> String? {
        // prepare abstract dates
        let to = Date()
        let from = Date(timeIntervalSince1970: to.timeIntervalSince1970 - timeInterval)
        
        return self.string(from: from, to: to)
    }
    
    /**
     Generates a time string for the specified date in UTC.
     
     - Parameter style: A DateFormatter.Style option that decides the string's brevity or length.
     - Parameter date: A Date() object representing the time to be displayed. If none is provided, the current date/time is used.
     
     - Returns: A String representing the current time in UTC.
     */
    public static func utc(style: DateFormatter.Style, date: Date? = Date()) -> String {
        let df = DateFormatter()
        df.locale = ZDevice.preferredLocale()
        df.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        df.timeStyle = style
        df.dateStyle = .none
        return df.string(from: date!)
    }
    
    /**
     Breaks down a provided time into a dictionary of component values keyed by time components.
 
     - Parameter date: A Date() object representing the time to be processed. If none is provided, the current date/time is used.
     
     - Returns: A dictionary containing time component integer values keyed by their component type.
    */
    public static func components(date: Date? = Date()) -> [Calendar.Component:Int] {
        let componentTypes: [Calendar.Component] = [.era, .year, .quarter, .month, .weekOfYear, .weekOfMonth, .weekday, .hour, .minute, .second, .nanosecond]
        var componentValues: [Calendar.Component:Int] = [:]
        for c in componentTypes {
            componentValues.updateValue(Calendar.current.component(c, from: date!), forKey: c)
        }
        return componentValues
    }
}
