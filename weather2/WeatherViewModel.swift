//
//  WeatherViewModel.swift
//  weather2
//
//  Created by Mikita Tratseuski on 11.10.23.
//

import Foundation
import CoreLocation // Импортируем CoreLocation для использования CLLocationCoordinate2D

class WeatherViewModel: ObservableObject {
    @Published var weatherData: WeatherData?
    @Published var lastUpdate: Date? // Добавляем свойство для хранения времени последнего обновления
    var coordinate: CLLocationCoordinate2D? // Добавляем новое свойство для хранения координат
    
    func fetchWeatherData() {
        let apiKey = Keys.weatherAPIKey // API-ключ от OpenWeatherMap

        
        let latitude = 53.9045 // Широта Минска
        let longitude = 27.5615 // Долгота Минска

        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude) // передаем значение координат
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    if let weatherData = try? JSONDecoder().decode(WeatherData.self, from: data) {
                        DispatchQueue.main.async {
                            self.weatherData = weatherData
                            self.lastUpdate = Date() // Устанавливаем значение lastUpdate на текущую дату
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
