# Weather forecast brick

Application that works with the location and weather API.

## Functionality

 - The app detects the user's current location and shows/display the weather
 - The weather display is a brick on a rope
   1 if it's raining outside, the brick is wet
   2 if it's sunny outside, the brick is dry
   3 if there is fog outside, the brick is hard to see
   4 if it is very hot outside, the brick is covered with cracks
   5 if it snows outside, the brick is covered with snow
   6 in strong winds, the brick is deflected on the rope
   7 if there is no internet connection and the data is not updated, the brick disappears from the rope

- Pull-to-refresh behavior when pulling the rope down a visual response
- iPhone device only
- Portrait device only

## Stack

 - Swift
 - UIKit
 - Auto Layout
 - URLSession
 - Codable
 - Gesture Recognizers
 - MVC
 - Third-party API
 - Design instruments: Figma
 - XCTests
 - SnapshotTesting

## Usage

### Application launch

https://github.com/vova3plv/Weather-Forecast-Brick/assets/156924040/4af9aa09-ef16-4364-ba41-7daa9c68acf0

### Application performance

https://github.com/vova3plv/Weather-Forecast-Brick/assets/156924040/af6e4d3f-f834-4d7d-b387-bc07133bae91

### No internet connection

https://github.com/vova3plv/Weather-Forecast-Brick/assets/156924040/8b3fdae4-bec9-40ea-a242-9867c8f3c550

## Інструкція для розробників (Developer Onboarding)

Цей посібник допоможе розгорнути проєкт на "чистій" машині macOS для подальшої розробки.

### 1. Вимоги до апаратного та програмного забезпечення
* Комп'ютер: Mac на базі процесорів Apple Silicon (M1/M2/M3) або Intel.
* ОС: macOS Monterey (12.0) або новіша.
* ПЗ: Xcode (завантажується безкоштовно з Mac App Store). Рекомендована версія 14.0+.
* Обліковий запис Apple ID.

### 2. Клонування репозиторію
Відкрийте Terminal та виконайте команду:
`git clone https://github.com/vova3plv/Weather-Forecast-Brick.git`
`cd Weather-Forecast-Brick`

### 3. Налаштування середовища розробки
Проєкт не використовує зовнішніх залежностей (CocoaPods або SPM), оскільки базується виключно на нативних фреймворках (UIKit, URLSession).
1. Відкрийте файл `WeatherBrick.xcodeproj` подвійним кліком.
2. У Xcode перейдіть у налаштування (Cmd + ,) -> Accounts і додайте свій Apple ID.
3. У навігаторі проєкту виберіть основний Target (`WeatherBrick`), перейдіть у вкладку **Signing & Capabilities** і оберіть свій Personal Team у полі Team.

### 4. Запуск проєкту
1. У верхній панелі Xcode оберіть симулятор (наприклад, iPhone 14 Pro).
2. Натисніть кнопку **Run** (або комбінацію клавіш `Cmd + R`).
3. Для запуску модульних тестів (XCTests) натисніть `Cmd + U`.

## 📝 Правила документування коду
Усі розробники, що долучаються до проєкту, повинні дотримуватись стандарту написання документації для Swift:
1. Використовувати `///` для документування класів, структур, протоколів та публічних методів.
2. Для методів обов'язково описувати параметри (ключове слово `- Parameter`) та значення, що повертається (`- Returns`).
3. Використовувати вбудований інструмент **DocC** для генерації та перегляду документації (в Xcode: `Product` -> `Build Documentation`).
