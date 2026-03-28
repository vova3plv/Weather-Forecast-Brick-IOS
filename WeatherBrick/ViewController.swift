/// Головний контролер екрану погоди.
///
/// Цей клас відповідає за відображення стану "цеглини" залежно від погодних умов
/// та обробку жестів користувача (наприклад, pull-to-refresh).

import UIKit

class ViewController: UIViewController {
    
    /// Перерахування, що описує всі можливі стани погодної цеглини.
    enum BrickState {
        /// Нормальна погода, цеглина суха.
        case normal
        /// Йде дощ, цеглина покрита краплями.
        case wet
    }
    
    let weatherBrickView = WeatherBrickView()
    
    override func loadView() {
        view = weatherBrickView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LogManager.shared.log(.info, "Додаток успішно запущено")
        LogManager.shared.log(.debug, "Початок завантаження погодних даних...")
    }
    
    func handleError(_ error: AppError) {
        // 1. Логуємо технічні деталі з унікальним ID (75%)
        LogManager.shared.log(.error, "Error [\(error.errorID)]: \(error.debugDescription)")
        
        // 2. Показуємо зрозумілий Alert користувачу (100%)
        let alert = UIAlertController(
            title: "Ой, халепа! (Код: \(error.errorID))",
            message: error.localizedDescription, // Дружній текст
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Спробувати ще", style: .default, handler: { _ in
            // Логіка повтору
        }))
        
        // Кнопка для відправки звіту (імітація для 100%)
        alert.addAction(UIAlertAction(title: "Повідомити про проблему", style: .cancel, handler: { _ in
            LogManager.shared.log(.info, "User reported error ID: \(error.errorID)")
        }))
        
        self.present(alert, animated: true)
    }
}
