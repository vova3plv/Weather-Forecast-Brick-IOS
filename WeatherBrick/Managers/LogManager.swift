import Foundation
import os

enum LogLevel: Int {
    case debug = 0, info, warning, error, critical
    
    var prefix: String {
        switch self {
        case .debug: return "#DEBUG#"
        case .info: return "#INFO#"
        case .warning: return "#WARNING#"
        case .error: return "#ERROR#"
        case .critical: return "#CRITICAL#"
        }
    }
}

class LogManager {
    static let shared = LogManager()
    
    // 65%: Рівень логування читається з UserDefaults (Launch Arguments)
    // Це дозволяє змінити рівень без перекомпіляції, просто додавши "-LogLevel 1" при запуску
    private var currentLevel: LogLevel {
        let levelRaw = UserDefaults.standard.integer(forKey: "LogLevel")
        return LogLevel(rawValue: levelRaw) ?? .info
    }
    
    private let osLogger = os.Logger(subsystem: Bundle.main.bundleIdentifier ?? "WeatherBrick", category: "App")
    
    func log(_ level: LogLevel, _ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        guard level.rawValue >= currentLevel.rawValue else { return }
        
        let fileName = (file as NSString).lastPathComponent
        let logMessage = "[\(fileName):\(line)] \(function) -> \(message)"
        
        // Вивід у консоль Xcode та системний лог macOS/iOS
        osLogger.log(level: osLogType(for: level), "\(level.prefix) \(logMessage)")
        
        // Для етапу 85% - запис у файл
        writeToFile("\(Date().ISO8601Format()) | \(level.prefix) | \(logMessage)")
    }
    
    private func osLogType(for level: LogLevel) -> OSLogType {
        switch level {
        case .debug: return .debug
        case .info: return .info
        case .warning: return .default
        case .error: return .error
        case .critical: return .fault
        }
    }
    
    // MARK: - 85% Ротація та запис у файл
    private func writeToFile(_ text: String) {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        guard let documentDirectory = urls.first else { return }
        
        let logFileURL = documentDirectory.appendingPathComponent("app_logs.txt")
        
        // Ротація логів: якщо файл більше 1 МБ, очищуємо його (або перейменовуємо)
        if let attributes = try? fileManager.attributesOfItem(atPath: logFileURL.path),
           let fileSize = attributes[.size] as? UInt64, fileSize > 1_000_000 {
            try? fileManager.removeItem(at: logFileURL) // Проста ротація (видалення старого)
        }
        
        let logText = text + "\n"
        if let data = logText.data(using: .utf8) {
            if fileManager.fileExists(atPath: logFileURL.path) {
                if let fileHandle = try? FileHandle(forWritingTo: logFileURL) {
                    fileHandle.seekToEndOfFile()
                    fileHandle.write(data)
                    fileHandle.closeFile()
                }
            } else {
                try? data.write(to: logFileURL)
            }
        }
    }
}
