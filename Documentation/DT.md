#  Date and Time
ZerzuraKit's extensions for Date and TimeInterval simplify the process of processing and presenting time values in natural language.

## Imports
``` swift
import Foundation
```

## Stringifying Dates and Times
ZerzuraKit provides multiple methods for quickly generating a string from a date. Date.string() and Date.utc() present print the date and time associated with a Date value (i.e. "12:00 PM"), whereas Date.stringBetween() can be used to print the amount of time that separates two Dates with loose precision (i.e. "3 days", "10 hours", etc.).

``` swift
func string(style: DateFormatter.Style, withSeconds: Bool?, locale: Locale?) -> String
func utc(style: DateFormatter.Style) -> String
static func stringBetween(from: Date, to: Date) -> String?
```

TimeInterval also gains a .string() method that uses Date.stringBetween() to produce a time interval in natural language.

## Time Intervals
ZerzuraKit's Date extension also provides methods for computing TimeIntervals between dates, useful when time comparisons are necessary.

``` swift
func timeIntervalSince1970(until: Date)
func timeIntervalBetween(from: Date, to: Date)
```

## Components
ZerzuraKit's Date extension can be used to produce a dictionary of time components associated with a Date.

``` swift
let someDate = Date()
let month = someDate.components[.month]
```
