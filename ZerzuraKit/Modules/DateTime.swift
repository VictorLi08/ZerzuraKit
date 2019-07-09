//
//  DateTime.swift
//  ZerzuraKit
//
//  Created by Victor Li on 4/22/19.
//  Copyright © 2019 Mesarthim. All rights reserved.
//

import Foundation

/**
 A class that defines methods used for converting time values to user-readable strings.
*/
public class ZTime {
    /**
     Format for time interval strings.
     */
    public enum Style {
        /// Hours/Minutes/Seconds delineated with a colon (i.e. 3600 sec = 1:00)
        case short
        /// Hours/Minutes/Seconds delineated by name (i.e. 3661 sec = 1 hour, 1 minute, 1 second)
        case long
    }
    
    /**
     Generates a localized time string, i.e. 12:00 PM.
     
     - Parameter style: A DateFormatter.Style option that decides the string's brevity or length.
     - Parameter withSeconds: Whether or not the time string should include seconds (default no).
     - Parameter date: A Date() object representing the time to be displayed. If none is provided, the current date/time is used.
     - Parameter locale: The locale that the string should be formatted for. If none is provided, the device's current locale is used.
     
     - Returns: A String representing the current time.
     */
    public static func string(style: DateFormatter.Style, withSeconds: Bool? = false, date: Date? = Date(), locale: Locale? = ZSystem.locale()) -> String {
        let df = DateFormatter()
        
        df.locale = locale
        df.dateStyle = .none
        df.timeStyle = style
        
        return df.string(from: date!)
    }
    
    /**
     Generates a localized string representing a time interval between two dates.
     
     - Parameter from: A Date() object representing start reference date (e.g. some stored date).
     - Parameter to: A Date() object representing end reference date (typically a Date() representing now).
     
     - Returns: A localized string reprsenting the time between dates (e.g. 3 days, 10 hours, 30 minutes, etc.).
    */
    public static func string(from: Date, to: Date) -> String? {
        // extract time components from timeframe
        let calendar = Calendar.current
        let allowedComponents: Set<Calendar.Component> = [.year, .month, .weekOfMonth, .day, .hour, .minute, .second]
        let components = calendar.dateComponents(allowedComponents, from: from, to: to)
        
        // set time formatter
        let timeFormatter = DateComponentsFormatter()
        timeFormatter.unitsStyle = .full
        
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
            timeFormatter.allowedUnits = [.hour]
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
     Generates a time string formatted for UTC.
     
     - Parameter withSeconds: Whether or not the time string should include seconds (default no).
     - Parameter date: A Date() object representing the time to be displayed. If none is provided, the current date/time is used.
     
     - Returns: A String representing the current time in UTC.
     */
    public static func stringUTC(withSeconds: Bool? = true, date: Date? = Date()) -> String {
        let df = DateFormatter()
        
        df.locale = Locale.init(identifier: "en_GB")
        df.dateStyle = .none
        if withSeconds! {
            df.dateFormat = "HH:mm"
        }
        else {
            df.dateFormat = "HH:mm:ss"
        }
        
        return df.string(from: date!)
    }
    
    /**
     Breaks down a provided time into individual time components.
 
     - Parameter componentTypes: An array of Calendar.Component value types.
     - Parameter date: A Date() object representing the time to be displayed. If none is provided, the current date/time is used.
     
     - Returns: A dictionary containing time component integer values keyed by their component type.
    */
    public static func components(componentTypes: [Calendar.Component], date: Date? = Date()) -> [Calendar.Component:Int] {
        var componentValues: [Calendar.Component:Int] = [:]
        for c in componentTypes {
            componentValues.updateValue(Calendar.current.component(c, from: date!), forKey: c)
        }
        return componentValues
    }
}
