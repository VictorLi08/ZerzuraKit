//
//    Location.swift
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

import CoreLocation

/**
 An object used to decode addresses from CoreLocation data structures.
 
 ### Notes ###
 * Location Services must be enabled.
 * Properties are only refreshed when instantiated or calling update() with a new location.
*/
class ZLocation {
    /// The city name of the stored location.
    private(set) var city: String = ""
    
    /// The state or province the stored location is located in.
    private(set) var province: String = ""
    
    /// The country the stored location is located in.
    private(set) var country: String = ""
    
    /// The isoCountryCode of the stored location.
    private(set) var countryCode: String = ""
    
    /// The postal code of the stored location.
    private(set) var postalCode: String = ""
    
    /// The house number of the stored location. Not all locations retrieved by CoreLocation have an associated house number.
    private(set) var houseNumber: String = ""
    
    /// The street name of the stored location. Not all locations retrieved by CoreLocation have an associated street name.
    private(set) var street: String = ""
    
    /// A landmark associated with the stored location.
    private(set) var placeName: String = ""
    
    /// The neighborhood or area the stored location is located in.
    private(set) var area: String = ""
    
    // The latitude coordinate of the stored location.
    private(set) var latitude: Double = 0.0
    
    // The longitude coordinate of the stored location.
    private(set) var longitude: Double = 0.0
    
    /**
     Initializes a ZLocation from a CLLocationCoordinate2D.
     
     - Parameter coordinates: A CLLocationCoordinate2D representing the location to be stored.
     
     ### Usage Example ###
     ````
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         if CLLocationManager.locationServicesEnabled() {
             if let currentLocation = locations.first {
                let c = ZLocation.init(coordinates: currentLocation.coordinate)
             }
         }
     }
     ````
    */
    init(coordinates: CLLocationCoordinate2D) {
        self.update(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
    
    /**
     Initializes a ZLocation from a latitude and longitude value.
     
     - Parameter latitude: Latitude in degrees (positive for North and negative for South).
     - Parameter longitude: Longitude in degrees (negative for West and positive for East).
     
     ### Usage Example ###
     ````
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         if CLLocationManager.locationServicesEnabled() {
             if let currentLocation = locations.first {
                let c = ZLocation.init(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
             }
         }
     }
     ````
    */
    init(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        self.update(latitude: latitude, longitude: longitude)
    }
    
    /**
     Initializes a ZLocation from a CLLocation.
     
     - Parameter location: A CLLocation representing the location to be stored.
     
     ### Usage Example ###
     ````
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         if CLLocationManager.locationServicesEnabled() {
             if let currentLocation = locations.first {
                let c = ZLocation.init(location: currentLocation)
             }
         }
     }
     ````
    */
    init(location: CLLocation) {
        let coords = location.coordinate
        self.update(latitude: coords.latitude, longitude: coords.longitude)
    }
    
    /**
     Resets an existing ZLocation instance using CLLocationCoordinate2D coodinates.
     
     - Parameter coordinates: A CLLocationCoordinate2D representing the location to be stored.
     */
    func update(coordinates: CLLocationCoordinate2D) {
        self.update(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
    
    /**
     Resets an existing ZLocation instance using a CLLocation.
     
     - Parameter location: A CLLocation representing the location to be stored.
    */
    func update(location: CLLocation) {
        let coords = location.coordinate
        self.update(latitude: coords.latitude, longitude: coords.longitude)
    }
    
    /**
     Resets an existing ZLocation instsance using a latitude and longitude value.
     
     - Parameter latitude: Latitude in degrees (positive for North and negative for South).
     - Parameter longitude: Longitude in degrees (negative for West and positive for East).
    */
    func update(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        self.latitude = latitude
        self.longitude = longitude
        
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()
        var placemark: CLPlacemark?
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            let gpm = placemarks
            if ((gpm != nil) && (gpm?.count)! > 0) {
                placemark = CLPlacemark(placemark: (gpm?.first)!)
                self.city = String(placemark?.locality ?? "")
                self.province = String(placemark?.administrativeArea ?? "")
                self.country = String(placemark?.country ?? "")
                self.countryCode = String(placemark?.isoCountryCode ?? "")
                self.postalCode = String(placemark?.postalCode ?? "")
                
                self.houseNumber = String(placemark?.subThoroughfare ?? "")
                self.street = String(placemark?.thoroughfare ?? "")
                
                self.placeName = String(placemark?.name ?? "")
                self.area = String(placemark?.subLocality ?? "")
            }
        }
    }
    
    /**
     The CLLocation coordinates of the stored location.
     
     - Returns: A CLLocationCoordinate2D containing the coordinates of the currently stored location.
    */
    var coordinates: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
    
    /**
     The CLLocation of the stored location.
     
     - Returns: A CLLocation representing the currently stored location.
    */
    var position: CLLocation {
        return CLLocation.init(latitude: self.latitude, longitude: self.longitude)
    }
    
    /**
     Experimental: generates a searchable address string using the stored location data.
     
     - Returns: A formatted String for the location stored.
     */
    open var string: String {
        let address1 = self.houseNumber + " " + self.street
        let address2 = self.placeName + ", " + self.area
        let address3 = self.city + ", " + self.province + " " + self.postalCode
        return address1 + "\n" + address2 + "\n" + address3 + "\n" + self.country
    }
}
