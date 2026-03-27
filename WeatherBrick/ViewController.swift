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
    }
    
    
}
