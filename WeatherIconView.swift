//
//  WeatherIconView.swift
//  WeatherApp
//
//  Created by Simon Berntsson on 2024-02-07.
//

import SwiftUI
import WidgetKit

/*
 struct WeatherIconView: View {
 @State var location = LocationData()
 
 var body: some View {
 ZStack {
 let backgroundColor: Color = {
 if let dayOrNight = location.weather?.current.is_day {
 return location.dayOrNight(value: dayOrNight)
 } else {
 return .blue
 }
 }()
 LinearGradient(gradient: Gradient(colors: [backgroundColor, .yellow]),
 startPoint: .topLeading,
 endPoint: .bottomTrailing)
 .ignoresSafeArea()
 
 
 VStack {
 Text(location.locationService.cityName ?? "City not available")
 .font(.system(size: 14))
 .foregroundColor(.yellow)
 .padding()
 
 HStack {
 Text(String(location.weather?.current.temperature_2m ?? 0.0))
 .font(.system(size: 12))
 .foregroundColor(.white)
 
 Text(location.weather?.current_units.temperature_2m ?? "Units not available")
 .foregroundColor(.white)
 .font(.system(size: 12))
 }
 if let weatherCode = location.weather?.current.weather_code {
 Image(systemName: location.weatherConditionDecoder(weatherCode).rawValue)
 .foregroundColor(.white)
 .padding(8)
 }
 else {
 Text("N/A")
 }
 
 }
 }
 .onAppear {
 Task {
 do {
 location.locationRequest()
 location.weather = try await location.setUpCoordinates()
 
 
 } catch {
 print("ERROR")
 }
 }
 }
 .refreshable {
 print("refreshing")
 location.locationRequest()
 }
 }
 }
 
 #Preview {
 WeatherIconView()
 }
 */
