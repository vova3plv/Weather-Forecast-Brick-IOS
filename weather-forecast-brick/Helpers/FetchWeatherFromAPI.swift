//
//  FetchWeatherFromAPI.swift
//  weather-forecast-brick
//
//  Created by Мария Анисович on 04.09.2024.
//

import Foundation

func fetchWeatherFromAPI(lat: Double, lon: Double) async throws -> WeatherData {
    guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "WEATHER_API_KEY") as? String else {
        throw URLError(.badURL)
    }

    let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric"
    guard let url = URL(string: urlString) else {
        throw URLError(.badURL)
    }

    let (data, _) = try await URLSession.shared.data(from: url)

    let decoded = try JSONDecoder().decode(WeatherData.self, from: data)

    return decoded
}
