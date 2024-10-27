//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Роман Каменский on 05.11.2023.
//

import SwiftUI


struct ContentView: View {
    
    // @ObservedObject var viewModel = WeatherViewModel()
    
    @State private var isNight = false
    var body: some View {
        
        ZStack{
            BackgroundView(isNight: $isNight)
            VStack {
                CityTextView()
                MainWeatherStatusView()
                NextFiveDays()
                
                Spacer()
                Button(action: {
                    isNight.toggle()
                }, label: {
                    WeatherButton(title: "Dart theme" , textColor: .blue, backgroundColor: .white)
                })
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}

struct WeatherDayView: View {
    
    var dayOffWeek: String
    var imageName: String
    var temperature: String
    
    var body: some View {
        VStack(alignment: .center) {
            Text(dayOffWeek)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.white)
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
            Text("\(temperature)°")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

struct BackgroundView: View {
    @Binding var isNight: Bool
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [isNight ? .black : .blue, isNight ? .gray : Color("lightBlue")]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
}

struct CityTextView: View {
    
    @ObservedObject var viewModel = WeatherViewModel()
    
    var body: some View{
        Text(viewModel.city?.name ?? "")
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}
struct MainWeatherStatusView: View {
    
    @ObservedObject var viewModel = WeatherViewModel()
    
    
    var body: some View{
        
        
        if let firstForecast = viewModel.forecast.first {
            ForEach([firstForecast], id: \.self) { weather in
                
                VStack(spacing: 8) {
                    Image(systemName: getWeatherIcon(weather.weather.first?.icon ?? "01d"))
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                    Text("\(weather.main.temp, specifier: "%.0f")°")
                        .font(.system(size: 50, weight: .medium))
                        .foregroundColor(.white)
                    Text("\(formatDate(weather.dt_txt))  ")
                        .font(.system(size: 30, weight: .medium))
                        .foregroundColor(.white)
                    
                }
                .padding(.bottom,40)
            }
        }
    
    }
    private func getWeatherIcon(_ icon: String) -> String {
        // Функция преобразования иконки Weatherbit в SystemName иконку
        switch icon {
        case "01d": return "sun.max.fill"
        case "01n": return "moon.stars.fill"
        case "02d", "02n": return "cloud.sun.fill"
        case "03d", "03n": return "cloud.fill"
        case "04d", "04n": return "cloud.fill"
        case "10d": return "cloud.rain.fill"
        default: return "cloud.fill"
        }
    }
    private func formatDate(_ dateStr: String) -> String {
        let dateFormatter = DateFormatter()
        // Укажите формат даты, который включает время
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: dateStr) else { return "" }
        // Измените формат для получения дня недели
        dateFormatter.dateFormat = "MMMM dd, HH:mm , E"
        return dateFormatter.string(from: date)
    }
}

struct NextFiveDays: View {

    @ObservedObject var viewModel = WeatherViewModel()
    var body: some View {
        HStack(spacing: 20){
            
            HStack(){
                ForEach(viewModel.forecast.dropFirst(), id: \.self) { weather in
                    VStack(alignment: .center) {
                        if let city = viewModel.city {
                           
                            WeatherDayView(dayOffWeek: formatDate(weather.dt_txt), imageName: getWeatherIcon(weather.weather.first?.icon ?? "01d"), temperature: String(format: "%.1f",(weather.main.temp)))
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchWeatherForecast()
            }
        }
    }
    
    private func formatDate(_ dateStr: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: dateStr) else { return "" }
        dateFormatter.dateFormat = "E, HH:mm "
        return dateFormatter.string(from: date)
    }
    
    private func getWeatherIcon(_ icon: String) -> String {
        switch icon {
        case "01d": return "sun.max.fill"
        case "01n": return "moon.stars.fill"
        case "02d", "02n": return "cloud.sun.fill"
        case "03d", "03n": return "cloud.fill"
        case "04d", "04n": return "cloud.fill"
        case "10d": return "cloud.rain.fill"
        default: return "cloud.fill"
        }
    }
}
