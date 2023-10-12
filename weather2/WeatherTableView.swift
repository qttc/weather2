//
//  WeatherTableView.swift
//  weather2
//
//  Created by Mikita Tratseuski on 11.10.23.
//
import SwiftUI
import MapKit

struct WeatherTableView: View {
    let weatherData: WeatherData
    let fetchWeatherData: () -> Void
    let lastUpdate: Date?
    @State private var isFetchingData = false
    let locationCoordinate: CLLocationCoordinate2D?
    @Binding var searchText: String
    @State private var isShowingSearchModal = false
    
    var body: some View {
        
        // Лейбл "поиск" по тапу на который вызывается модалка
        VStack {
            
            Label(
                title: {
                    Text(searchText.isEmpty ? "Введите город" : searchText)
                        .foregroundColor(searchText.isEmpty ? .gray : .black)
                },
                icon: {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                }
            )
            .frame(maxWidth: .infinity)
//            .frame(height: 15)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .padding(.horizontal)
            .onTapGesture {
                isShowingSearchModal = true
            }
            
        }.sheet(isPresented: $isShowingSearchModal) {
            LocationSearchView(isPresented: $isShowingSearchModal)
        }
        
        // Погода
        
        VStack {
            Text("Weather in \(weatherData.name)")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            
            VStack(spacing: 8) {
                Text("Temperature")
                    .font(.headline)
                
                Text("\(weatherData.temperature, specifier: "%.1f")°C")
                    .font(.system(size: 48))
                    .fontWeight(.semibold)
            }
            .padding()
            .background(Color.blue.opacity(0.2))
            .cornerRadius(10)
            
            VStack(spacing: 8) {
                Text("Weather Conditions")
                    .font(.headline)
                
                Text(weatherData.description)
                    .font(.subheadline)
                
                Text("Wind Speed")
                    .font(.headline)
                
                Text("\(weatherData.windSpeed, specifier: "%.1f") m/s")
                    .font(.subheadline)
            }
            .padding()
            
            
            // MapView локации
            
            if let coordinate = locationCoordinate {
                MapView(coordinate: coordinate)
                    .frame(height: 200)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 5)
        .padding()
        .onAppear {
            fetchWeatherData() // Вызываем загрузку данных при появлении представления
        }
        
        // Обновить и дата последнего обновления
        
        VStack {
            Button(action: {
                fetchWeatherData()
            }) {
                Text("Обновить")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .disabled(isFetchingData) // Блокируем кнопку, если идет загрузка данных
            
            Text("Last Update: \(lastUpdateText())")
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
    
    private func lastUpdateText() -> String {
        guard let lastUpdate = lastUpdate else {
            return "Never"
        }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        return formatter.string(from: lastUpdate)
    }
}
