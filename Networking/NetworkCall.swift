//
//  NetworkCall.swift
//  WeatherApp
//
//  Created by Simon Berntsson on 2024-02-03.
//

import Foundation
import WidgetKit


func getWeatherData(latitude: Double, longitude: Double) async throws -> WeatherData {
   // print("From getWeatherData, latitude:", latitude, "longitude:", longitude)

    let endpoint = "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&current=temperature_2m,is_day,weather_code&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=GMT"
    
    guard let url = URL(string: endpoint) else { throw WeatherDataError.invalidURL }
    
    let (data, response) = try await URLSession.shared.data(from: url)
   // print(String(data: data, encoding: .utf8) ?? "Unable to decode data")

    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw WeatherDataError.invalidResponse
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(WeatherData.self, from: data)
    } catch {
        print("invalidData")
        throw WeatherDataError.invalidData
    }
    
}

enum WeatherDataError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
