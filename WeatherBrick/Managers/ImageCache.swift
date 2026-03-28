import UIKit

/// Менеджер для кешування зображень (Оптимізація продуктивності - Лаба 8)
class ImageCache {
    static let shared = ImageCache()
    
    // Використовуємо NSCache для автоматичного управління пам'яттю
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {
        // Оптимізація пам'яті: обмежуємо кеш до 50 зображень
        cache.countLimit = 50
    }
    
    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func saveImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
        LogManager.shared.log(.debug, "Зображення збережено в кеш: \(key)")
    }
}
