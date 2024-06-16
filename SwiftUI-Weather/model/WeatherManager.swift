//
//  WeatherManager.swift
//  SwiftUI-Weather
//
//  Created by roman on 16.06.2024.
//

import SwiftUI
import Combine

class WeatherViewModel: ObservableObject {
    @Published var temperature: String = ""
    @Published var description: String = ""
    @Published var cityName: String = ""
    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchWeatherData()
    }

    func fetchWeatherData() {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=London&appid=7fbcbe374af7e624756feceb8d7d88a0&units=metric") else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching weather data: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] weatherResponse in
                self?.temperature = "\(weatherResponse.main.temp)°C"
                self?.description = weatherResponse.weather.first?.description ?? "No description"
                self?.cityName = weatherResponse.name
            })
            .store(in: &cancellables)
    }
}
