//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Simon Berntsson on 2024-01-30.
//

import Foundation
import CoreLocation
import Observation
import WidgetKit


@Observable
class LocationManager: NSObject, CLLocationManagerDelegate{
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    var location: CLLocation?
    var adress: CLPlacemark?
    var cityName: String?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocation() {
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.requestLocation()
        }
    }
    
    func reverseGeocodeLocation(_ location: CLLocation) {
        Task {
            let placemarks = try? await geocoder.reverseGeocodeLocation(location)
            adress = placemarks? .last
            
            if let city = adress?.locality {
                cityName = city
            }
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if locationManager.authorizationStatus != .denied {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
        if let location {
            reverseGeocodeLocation(location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //add error handling
    }
}
