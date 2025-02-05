//
//  apiCall.swift
//  WeatherApp
//
//  Created by Simon Berntsson on 2024-02-03.
//

import Foundation
import WidgetKit


    struct WeatherData: Codable {
        struct Current_units: Codable {
            let time: String
            let interval: String
            let temperature_2m: String
            let is_day: String
            let weather_code: String
        }
        
        struct Current: Codable {
            let time: String
            let interval: Int
            let temperature_2m: Double
            let is_day: Int
            let weather_code: Int
        }
        
        struct Daily_units: Codable {
            let time: String
            let weather_code: String
            let temperature_2m_max: String
            let temperature_2m_min: String
        }
        
        struct Daily: Codable {
            let time: [String]
            let weather_code: [Int]
            let temperature_2m_max: [Double]
            let temperature_2m_min: [Double]
        }
        
        let latitude: Double
        let longitude: Double
        let generationtime_ms: Double
        let utc_offset_seconds: Int
        let timezone: String
        let timezone_abbreviation: String
        let elevation: Double
        let current_units: Current_units
        let current: Current
        let daily_units: Daily_units
        let daily: Daily
    }
