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
    
    var error: Bool = false
        
    private let APP_ID = "547ea74c1786dfee3dc7a51738595d15"
    
    private let baseURL = "https://api.openweathermap.org/data/2.5"
    
    func GET<T: Codable>(endpoint: String, type: T.Type) async -> Result<T, NetworkError> {
        
        guard let url = URL(string: self.baseURL + endpoint) else { fatalError("Missing URL") }

        let urlRequest = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
            else { throw NetworkError.badRequest }
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedData)
        }
        catch {
            return .failure(NetworkError.badRequest)
        }
    }
    
    func fetchWeatherForZip(zip: String) async {
        let result = await GET(endpoint: "/weather?zip=\(zip)&units=imperial&appid=\(APP_ID)", type: WeatherResponse.self)
        
        switch result {
            case .success(let weatherData):
                self.name = weatherData.name
                self.currentTemp = weatherData.main.temp
                self.weatherDescription = weatherData.weather[0].description
                self.relativeHumidity = String(weatherData.main.humidity)
                self.windString = String(weatherData.wind.speed)
                self.visibilityKm = String(weatherData.visibility)
            
                self.error = false
            case .failure( _):
                self.error = true
        }
    }
}
