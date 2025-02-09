//
//  Weather.swift
//  6.1820_lab0
//
//  Created by Maxwell Zetina on 2/6/25.
//

import SwiftUI
import Foundation

enum NetworkError: Error {
    case badRequest
}

@Observable class Weather {
    var currentTemp: Double = 0.0
    var weatherDescription: String = "--"
    var relativeHumidity: String = "--"
    var windString: String = "--"
    var visibilityKm: String = "--"
    var name: String = "--"
        
    let APP_ID = "547ea74c1786dfee3dc7a51738595d15"
    
    let baseURL = "https://api.openweathermap.org/data/2.5"
    
    func GET<T: Codable>(endpoint: String, type: T.Type) async -> T {
        
        guard let url = URL(string: self.baseURL + endpoint) else { fatalError("Missing URL") }

        let urlRequest = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
            else { throw NetworkError.badRequest }
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        }
        catch {
            return WeatherResponse(coord: Coord(lon: 0, lat: 0), weather: [WeatherKey(description: "")], main: Main(temp: 0, humidity: 0), visibility: 0, wind: Wind(speed: 0), name: "no name") as! T
        }
    }
    
    func fetchWeatherForZip(zip: String) async {
        let weatherData = await GET(endpoint: "/weather?zip=\(zip)&units=imperial&appid=\(APP_ID)", type: WeatherResponse.self)
        
        self.name = weatherData.name
        self.currentTemp = (weatherData.main.temp)
        self.weatherDescription = weatherData.weather[0].description
        self.relativeHumidity = String(weatherData.main.humidity)
        self.windString = String(weatherData.wind.speed)
        self.visibilityKm = String(weatherData.visibility)
    }
}
