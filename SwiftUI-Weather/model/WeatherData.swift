//
//  WeatherData.swift
//  SwiftUI-Weather
//
//  Created by roman on 16.06.2024.
//

import Foundation

struct WeatherResponse: Codable {
    let list: [Weather]
    let city: City
}

struct Weather: Codable, Identifiable, Hashable {
    let id = UUID()
    let dt: Int
    let main: Main
    let weather: [WeatherDetail]
    let dt_txt: String
  
    enum CodingKeys: String, CodingKey {
        case dt, main, weather
        case dt_txt = "dt_txt"
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(dt)
        hasher.combine(main)
        hasher.combine(weather)
        hasher.combine(dt_txt)
    
    }
}

struct Main: Codable,Hashable {
    let temp: Double
}

struct WeatherDetail: Codable,Hashable {
    let description: String
    let icon: String
}

struct City: Codable {
    let name: String
    let country: String
}
