//
//  WeatherManager.swift
//  SwiftUI-Weather
//
//  Created by roman on 16.06.2024.
//

import Foundation
import Combine
import CoreLocation
import SwiftUI


class WeatherViewModel: NSObject, ObservableObject {
    
    @Published var forecast: [Weather] = []
    @Published var city: City?
    
    private let apiKey = ""
    private let cityName = "Paris"
    private var cancellable: AnyCancellable?
    private var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self // Установка делегата
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func fetchWeatherForecast() {
        
        guard let location = locationManager.location else {
            print("Failed to get location")
            return
        }
        locationManager.requestWhenInUseAuthorization()
        /*let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=\(apiKey)&units=metric"*/
        
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(cityName)&appid=\(apiKey)&units=metric"
        print(urlString)
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching weather: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] response in
                self?.forecast = Array(response.list.prefix(6))
                self?.city = response.city
            })
    }
}

extension WeatherViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        print("Current location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
        fetchWeatherForecast()
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error requesting location: \(error.localizedDescription)")
    }
}
