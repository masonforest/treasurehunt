//
//  LocationManager.swift
//  TreasureHunt
//
//  Created by Tim Colla on 05/11/2016.
//  Copyright © 2016 Marinosoftware. All rights reserved.
//

//
//  MCASLocationManager.swift
//  MCAS Demo
//
//  Created by Tim Colla on 10/10/2016.
//  Copyright © 2016 Marinosoftware. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate {
    func didUpdate(location: CLLocation)
    func didFail()
}

class LocationManager : NSObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var delegate : LocationManagerDelegate?
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        
        locationManager.requestWhenInUseAuthorization()
    }
    
    func requestLocation() {
        if #available(iOS 9.0, *) {
            locationManager.requestLocation()
        } else {
            // Fallback on earlier versions
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            delegate?.didUpdate(location: location)
        } else {
            delegate?.didFail()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.didFail()
    }
}
