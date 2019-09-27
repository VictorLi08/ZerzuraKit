#  Location Classes & Extensions
ZerzuraKit defines a variety of classes, extensions, and methods to help you deal with CLLocation data.

## Imports
``` swift
import CoreLocation
```

## CLGeocoder

### Quick Reverse Geocoding
CLGeocoder gains an extended method called "quickReverseGeocode". This reverse geocodes a location, prints any errors, and executes a completion handler IFF reverse geocoding succeeds in generating a valid placemark.

``` swift
let myLabel = UILabel()

let geocoder = CLGeocoder()
geocoder.quickReverseGeocode(myLocation) { placemark in
    myLabel.text = placemark.locality 
}
```

## CLPersister
CLPersister is a class that stores location data to and loads location data from the device, allowing for quick retrieval at a future time for persistence.

### Initialize
``` swift
let persister = CLPersister()
```

#### :warning: IMPORTANT :warning: ####
You should only have one instance of CLPersister active at any time. Having more than one declaration of CLPersister risks compromising database and connection integrity as all instances refer to the same database file.

### Store Location
Storing a CLLocation is a synchronous operation (happens in the main thread). As this operation is very quick, there is minimal impact to the UI.
``` swift
let result = persister.store(myLocation)
```

### Load Location
Like location storage, location loading is also a synchronous operation.

``` swift
let prevLocation = persister.load()
```



