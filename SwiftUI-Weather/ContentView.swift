//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Роман Каменский on 05.11.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            BackgroundView(topColor: .blue, bottomColor: Color("lightblue"))
            VStack {
                CityTextView(cityName: "Cupertino, CA")
                MainWeatherStatusView(imageName: "cloud.sun.fill", temperature: 76)
                HStack(spacing: 20){
                    WeatherDayView(dayOffWeek: "TUE", imageName: "cloud.sun.fill", temperature: 74)
                    WeatherDayView(dayOffWeek: "WD", imageName: "sunrise.fill", temperature: 74)
                    WeatherDayView(dayOffWeek: "TUE", imageName: "cloud.sun.fill", temperature: 74)
                    WeatherDayView(dayOffWeek: "TUE", imageName: "cloud.sun.fill", temperature: 74)
                    WeatherDayView(dayOffWeek: "TUE", imageName: "cloud.sun.fill", temperature: 77)
                }
                Spacer()
                Button(action: {
                    print("Tapped")
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
    var topColor: Color
    var bottomColor: Color
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [topColor, bottomColor]), startPoint: .topLeading, endPoint: .bottomTrailing)
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

