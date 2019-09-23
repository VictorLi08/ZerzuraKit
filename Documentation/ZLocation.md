#  ZLocation
ZLocation is a class that stores CoreLocation data and decodes addresses.

## Imports
``` swift
import CoreLocation
```

## Initialization
ZLocation is an instanced class that only employs "useful instances", meaning you cannot initialize an empty ZLocation.

Create a ZLocation instance by initializing it with location data, either from a `CLLocation`, `CLLocationCoordinate2D`, or explicit latitude and longitude values supplied in `CLLocationDegrees` form.

``` swift
ZLocation.init(coordinates: CLLocationCoordinate2D)
ZLocation.init(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
ZLocation.init(location: CLLocation)
```

## Update
You can update an existing ZLocation's position by supplying it with new location data, either from a `CLLocation`, `CLLocationCoordinate2D`, or explicit latitude and longitude values supplied in `CLLocationDegrees` form.

``` swift
ZLocation.update(coordinates: CLLocationCoordinate2D)
ZLocation.update(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
ZLocation.update(location: CLLocation)
```

## Properties
When a ZLocation is initialized or updated, it will automatically decode the address data associated with its new position. This data is stored as read-only instance variables.

``` swift
let location = ZLocation(location: myLocation)

location.city: String
location.province: String
location.country: String
location.countryCode: String
location.postalCode: String
location.houseNumber: String
location.street: String
location.placeName: String
location.area: String
location.latitude: Double
location.longitude: Double
```

## Reproducing CLLocation Data
You can fetch the location data stored in a ZLocation as a `CLLocation` or `CLLocationCoordinate2D` by accessing the appropriate variable.

``` swift
let location = ZLocation(location: myLocation)

location.coordinates: CLLocationCoordinate2D
location.position: CLLocation
```

## Generating Strings
ZLocation generates an address string as a class member variable upon every initialization or update.

``` swift
let address = myLocation.string
```

You can define your own method for generating address strings by subclassing ZLocation and overriding its string var:

``` swift
class DerivedZLocation: ZLocation {
    override var string: String {
        // Your code here
    }
}
```

If you do this, remember to use your own ZLocation subclass instead of ZLocation.
