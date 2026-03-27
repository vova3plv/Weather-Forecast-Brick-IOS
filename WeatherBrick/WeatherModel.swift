import Foundation

struct Weather: Decodable {
    var temperature: Int
    var description: String
}

//class WeatherManager {
//    let apiKey = "73a1d668ef6798a19b923d5ddd1dd4fc"
//    func fetchWeatherFromAPI(nameOfSity: String) async throws -> Weather {
//        let url = URL(string: "http://api.openweathermap.org/geo/1.0/direct?q=\(nameOfSity)&limit=5&appid=\(apiKey)")!
//        let (data, _) = try await URLSession.shared.data(from: url)
//        let decoded = try JSONDecoder().decode(Weather.self, from: data)
//        return decoded
//    }
//}
