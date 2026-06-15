

import Foundation

struct WeatherData: Decodable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
}

struct Weather: Decodable {
    let description: String
}

struct Main: Decodable {
    let temp: Double
}

struct Wind: Decodable {
    let speed: Double
}
