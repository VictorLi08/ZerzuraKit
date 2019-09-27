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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let l = locations.first {
            let myzl = ZLocation(location: l)
            cityLabel.text = myzl.city
            print(myzl.city)
        }
    }
}

