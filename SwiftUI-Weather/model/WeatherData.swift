//
//  WeatherData.swift
//  SwiftUI-Weather
//
//  Created by roman on 16.06.2024.
//

import Foundation

struct WeatherResponse: Codable {
    let main: Main
    let weather: [Weather]
    let name: String
    
    struct Main: Codable {
        let temp: Double
    }
    
    struct Weather: Codable {
        let description: String
    }
}
