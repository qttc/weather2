//
//  WeatherData.swift
//  weather2
//
//  Created by Mikita Tratseuski on 11.10.23.
//

struct WeatherData: Decodable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let name: String
    
    var description: String {
        weather.first?.description ?? ""
    }
    
    var temperature: Double {
        main.temp
    }
    
    var feelsLikeTemperature: Double {
        main.feels_like
    }
    
    var windSpeed: Double {
        wind.speed
    }
}

struct Weather: Decodable {
    let description: String
}

struct Main: Decodable {
    let temp: Double
    let feels_like: Double
}

struct Wind: Decodable {
    let speed: Double
}

struct Coord: Decodable {
    let lon: Double
    let lat: Double
}

struct Sys: Decodable {
    let country: String
    let sunrise: Int
    let sunset: Int
}
