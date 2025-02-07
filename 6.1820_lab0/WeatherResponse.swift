//
//  WeatherResponse.swift
//  6.1820_lab0
//
//  Created by Maxwell Zetina on 2/7/25.
//

struct WeatherResponse: Codable {
    let coord: Coord
    let weather: [WeatherKey]
    let main: Main
    let visibility: Int
    let wind: Wind
    let name: String
}

struct Wind: Codable {
    let speed: Double
}

struct Main: Codable {
    let temp: Double
//    let feels_like: Double
//    let temp_min: Double
//    let temp_max: Double
//    let pressure: Int
    let humidity: Int
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}

struct WeatherKey: Codable {
//    let id: Int
//    let main: String
    let description: String
//    let icon: String
}
