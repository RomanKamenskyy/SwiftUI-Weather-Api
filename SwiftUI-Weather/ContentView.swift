//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Роман Каменский on 05.11.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isNight = false
    var body: some View {
        ZStack{
            BackgroundView(isNight: $isNight)
            VStack {
                CityTextView(cityName: "Cupertino, CA")
                MainWeatherStatusView(imageName: "cloud.sun.fill", temperature: 76)
                NextFiveDays()
                Spacer()
                Button(action: {
                    isNight.toggle()
                }, label: {
                    WeatherButton(title: "Change Day Time" , textColor: .blue, backgroundColor: .white)
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
    var temperature: Int
    
    var body: some View {
        VStack {
            Text(dayOffWeek)
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.white)
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 45, height: 45)
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
    var cityName: String
    var body: some View{
        Text(cityName)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}
struct MainWeatherStatusView: View {
    var imageName: String
    var temperature: Int
    var body: some View{
        VStack(spacing: 8) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            Text("\(temperature)°")
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(.bottom,40)
    }
}


struct NextFiveDays: View {
    let days = ["TUE", "WED", "THU", "FRI","SAT" ]
    let degree = [72, 74, 76, 78,72 ]
    let sfSymbols = ["cloud.sun.fill", "cloud.rain.fill", "sun.max.fill",
    "sun.max.fill", "sun.rain.fill"]
    var body: some View {
        HStack(spacing: 20){
            ForEach(days.indices, id: \.self){ index in
                WeatherDayView(dayOffWeek: days[index], imageName: sfSymbols[index], temperature: degree[index])
               
            }
        }
    }
}
