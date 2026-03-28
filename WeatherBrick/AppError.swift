import Foundation

enum AppError: Error, LocalizedError {
    case networkError(statusCode: Int)
    case locationDenied
    case parsingFailed
    
    // 75%: Унікальний ідентифікатор помилки для трекінгу
    var errorID: String {
        return UUID().uuidString.components(separatedBy: "-").first ?? "UNKNOWN"
    }
    
    // 100%: Локалізовані повідомлення (зрозумілі користувачу, без технічних деталей)
    var errorDescription: String? {
        switch self {
        case .networkError:
            // В ідеалі тут використовується NSLocalizedString("network_error", comment: "")
            return "Не вдалося з'єднатися з сервером погоди. Перевірте підключення до інтернету."
        case .locationDenied:
            return "Нам потрібен доступ до вашої геопозиції, щоб показати точну погоду."
        case .parsingFailed:
            return "Щось пішло не так при обробці даних. Ми вже працюємо над цим!"
        }
    }
    
    // Технічний опис для логів
    var debugDescription: String {
        switch self {
        case .networkError(let code): return "HTTP Error with status code: \(code)"
        case .locationDenied: return "User denied CLAuthorizationStatus"
        case .parsingFailed: return "JSONDecoder failed to decode WeatherResponse"
        }
    }
}
