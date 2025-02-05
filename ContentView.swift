//
//  ContentView.swift
//  WeatherApp
//
//  Created by Simon Berntsson on 2024-01-30.
//

import SwiftUI

struct ContentView: View {
    @State private var location = LocationData()

    

    
    
    var body: some View {
        
        ZStack() {
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
                Text(location.locationService.cityName ?? "Cant get city")
                    .font(.system(size: 60))
                    .foregroundColor(.yellow)
                    .padding()
        
                HStack{
                    Text(String(location.weather?.current.temperature_2m ?? 0.0))
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                    Text(location.weather?.current_units.temperature_2m ?? "doesnt work")
                        .foregroundColor(.white)
                        .font(.title)
                }
                if let currentCondition = location.weather?.current.weather_code {
                    Image(systemName: location.weatherConditionDecoder(currentCondition).rawValue)
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                        .padding(30)
                }
                    
                    
                List {
                    Text(" Date                  Min      Max       ")
                        .foregroundColor(.yellow)
                        .listRowBackground(Color.clear)
                    ForEach(0..<7) { index in
                        HStack {
                            Text(location.weather?.daily.time[index] ?? "N/A")
                            
                            if let temperatureMin = location.weather?.daily.temperature_2m_min[index] {
                                Text(String(format: "%.1f", temperatureMin))
                                    .padding(8)
                            } else {
                                Text("N/A")
                            }
                            if let temperaturMax =
                                location.weather?.daily.temperature_2m_max[index] {
                                Text(String(format: "%.1f", temperaturMax))
                                    .padding(8)
                            } else {
                                Text("N/A")
                            }
                            if let weatherCode = location.weather?.daily.weather_code[index] {
                                Image(systemName: location.weatherConditionDecoder(weatherCode).rawValue)
                                    .padding(8)
                            }
                            else {
                                Text("N/A")
                            }


                        }
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparatorTint(Color.black)
                }
                .scrollContentBackground(.hidden)
                
                
            }
            .padding()
            .onAppear {
                location.locationRequest()
            }

            .onChange(of: location.locationService.location){
                Task {
                    do {
                        location.weather = try await location.setUpCoordinates()
                        
                        if let temperature = location.weather?.current.temperature_2m,
                           let weatherCondition = location.weather?.current.weather_code,
                           let cityName = location.locationService.cityName {
                            
                            let weatherSymbol = location.weatherConditionDecoder(weatherCondition)
                            location.writeToSharedContainer(temperature: temperature, cityName: cityName, condition: weatherSymbol.rawValue)
                        }
                        
                    } catch {
                        print("ERROR: locationRequest and location.weather = setUpCoordinates")
                    }
                }
            }
        }
    }
}
#Preview {
    ContentView()
}
