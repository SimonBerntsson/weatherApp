//
//  LocationData.swift
//  WeatherApp
//
//  Created by Simon Berntsson on 2024-02-04.
//
import Observation
import Foundation
import SwiftUI
import WidgetKit

@Observable
class LocationData {
    var locationService = LocationManager()
    var weather: WeatherData?
    static let WeatherSharedStorage: String = "group.io.simon.demo.weatherappsimondmp"
    
    func writeToSharedContainer(temperature: Double, cityName: String, condition: String) {
        print("Writing to shared container - Temperature: \(temperature), City: \(cityName)")
        let dataToStore = [
            "temperature": temperature,
            "cityName": cityName,
            "weatherSymbol": condition
        
        ] as [String: Any]
        
        let sharedDefaults = UserDefaults(suiteName: LocationData.WeatherSharedStorage)
        sharedDefaults?.set(dataToStore, forKey: "weatherData")
        WidgetCenter.shared.reloadAllTimelines()
    }

    func readFromSharedContainer() -> [String: Any]? {
        let sharedDefaults = UserDefaults(suiteName: LocationData.WeatherSharedStorage)
        return sharedDefaults?.dictionary(forKey: "weatherData")
    }
    
    func locationRequest(){
        locationService.requestLocation()
    }
    
    func setUpCoordinates() async throws -> WeatherData {
        guard let latitude = locationService.location?.coordinate.latitude,
               let longitude = locationService.location?.coordinate.longitude
         else {
             print("error in setUpCoordinates")
             throw WeatherDataError.invalidData
         }
        print("latitude:", latitude, "longitude:", longitude)
        let weatherData = try await getWeatherData(latitude: latitude, longitude: longitude)
        return weatherData
    }
    
    func dayOrNight(value: Int) -> Color {
        if value == 0 {
            return .black
        } else {
            return .blue
        }
    }
    
    enum WeatherCondition: String {
        case clearSky = "sun.max"
        case mainlyClear = "sun.max.fill"
        case partlyCloudy = "cloud"
        case overcast = "cloud.sun"
        case fog = "cloud.fog"
        case drizzleLight = "cloud.drizzle"
        case drizzle = "cloud.drizzle.fill"
        case rain = "cloud.rain"
        case heavyRain = "cloud.heavyrain"
        case rainFreeze = "cloud.sleet"
        case snow = "cloud.snow"
        case snowWind = "wind.snow"
        case thunder = "cloud.bolt"
        case thunderRain = "cloud.bolt.rain"
        case dataError = "person.slash"
        

    }
    
    func weatherConditionDecoder(_ weatherCode: Int) -> WeatherCondition {
        switch weatherCode {
        case 0:
            return .clearSky
        case 1:
            return .mainlyClear
        case 2:
            return .partlyCloudy
        case 3:
            return .overcast
        case 45, 48:
            return .fog
        case 51:
            return .drizzleLight
        case 53:
            return .drizzleLight
        case 55:
            return .drizzle
        case 56, 57:
            return .rainFreeze
        case 61, 63, 65:
            return .rain
        case 66, 67:
            return .rainFreeze
        case 71, 73, 75, 77:
            return .snow
        case 80, 81, 82:
            return .heavyRain
        case 85, 86:
            return .snowWind
        case 95, 96:
            return .thunder

        case 99:
            return .thunderRain
        default:
            return .dataError
        }
    }
}

