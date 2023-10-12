import SwiftUI

struct ContentView: View {
    @StateObject private var weatherDataProvider = WeatherDataProvider()
    @State private var searchText = ""

    
    var body: some View {
        VStack {
            if let weatherData = weatherDataProvider.weatherData {
                WeatherTableView(
                    weatherData: weatherData,
                    fetchWeatherData: weatherDataProvider.fetchWeatherData,
                    lastUpdate: weatherDataProvider.lastUpdate,
                    locationCoordinate: weatherDataProvider.coordinate,
                    searchText: $searchText
                ) // Pass the lastUpdate property from WeatherViewModel
            } else {
                ProgressView()
            }
        }
        .onAppear {
            weatherDataProvider.fetchWeatherData()
        }
    }
}
