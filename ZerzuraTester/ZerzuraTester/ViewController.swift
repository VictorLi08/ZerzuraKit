//
//  ViewController.swift
//  ZerzuraTester
//
//  Created by Victor Li on 2019/9/26.
//  Copyright © 2019 Lucian Interactive. All rights reserved.
//

import UIKit
import CoreLocation
import ZerzuraKit_iOS

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var cityLabel: UILabel!
    
    private let locator = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locator.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locator.delegate = self
            locator.distanceFilter = kCLDistanceFilterNone
            locator.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            locator.startUpdatingLocation()
        }
    }
    
    private var currentLocation: CLPlacemark = CLPlacemark() {
        didSet {
            cityLabel.text = currentLocation.locality ?? ""
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
//            myzl.update(location: location)
//            cityLabel.text = myzl.city
//            print(myzl.string)
            
            let geocoder = CLGeocoder()
//            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
//                if let ps = placemarks, let placemark = ps.first {
//                    let city = String(placemark.locality ?? "")
//                    let province = String(placemark.administrativeArea ?? "")
//                    let country = String(placemark.country ?? "")
//                    let countryCode = String(placemark.isoCountryCode ?? "")
//                    let postalCode = String(placemark.postalCode ?? "")
//
//                    let houseNumber = String(placemark.subThoroughfare ?? "")
//                    let street = String(placemark.thoroughfare ?? "")
//
//                    let placeName = String(placemark.name ?? "")
//                    let area = String(placemark.subLocality ?? "")
//                    print(city)
//                }
//            }
            geocoder.quickReverseGeocode(location) { placemark in
                let city = String(placemark.locality ?? "")
//                let province = String(placemark.administrativeArea ?? "")
//                let country = String(placemark.country ?? "")
//                let countryCode = String(placemark.isoCountryCode ?? "")
//                let postalCode = String(placemark.postalCode ?? "")
//
//                let houseNumber = String(placemark.subThoroughfare ?? "")
//                let street = String(placemark.thoroughfare ?? "")
//
//                let placeName = String(placemark.name ?? "")
//                let area = String(placemark.subLocality ?? "")
                print(city)
            }
            
            let persister = CLPersister()
            print(persister.store(location))
            
//            persister.load { error, location in
//                if let l = location {
//                    print(l.coordinate.latitude)
//                }
//            }
            
            let loc = persister.load()
            if loc != nil {
                print(loc?.coordinate.latitude)
                geocoder.quickReverseGeocode(loc!) { placemark in
                    self.cityLabel.text = String(placemark.locality ?? "") + ", " + String(placemark.country ?? "")
                }
            }
        }
    }
}

