# Розгортання у Production середовищі (App Store / TestFlight)

Оскільки це iOS-застосунок, розгортання означає доставку збірки (бінарного файлу .ipa) до магазину додатків Apple.

## 1. Вимоги до середовища розгортання (Build Machine)
* **Апаратне забезпечення:** Mac (Apple Silicon/Intel), мінімум 8GB RAM, 40GB вільного місця на диску (для Xcode та Derived Data).
* **Програмне забезпечення:** macOS, Xcode, Fastlane (опціонально для автоматизації).
* **Доступи:** Apple Developer Program Account (з роллю Admin або App Manager).

## 2. Підготовка до розгортання
1. Оновіть `Version` та `Build` у налаштуваннях проєкту (Target -> General).
2. Переконайтеся, що всі модульні тести (`Cmd + U`) проходять успішно.
3. Перевірте налаштування Signing (має бути обраний Distribution Certificate та відповідний Provisioning Profile).

## 3. Процес розгортання (Manual)
1. У Xcode оберіть цільовий пристрій "Any iOS Device (arm64)".
2. У верхньому меню оберіть `Product` -> `Archive`.
3. Після завершення збірки відкриється вікно Organizer.
4. Натисніть **Distribute App** -> **App Store Connect** -> **Upload**.
5. Дочекайтеся завершення завантаження та обробки на серверах Apple (може зайняти до 30 хвилин).

## 4. Перевірка працездатності
1. Зайдіть на портал [App Store Connect](https://appstoreconnect.apple.com/).
2. Перейдіть у розділ TestFlight і переконайтеся, що збірка отримала статус "Ready to Submit" або "Testing".
3. Встановіть збірку на реальний пристрій через додаток TestFlight для фінального димового тестування (Smoke Testing).
