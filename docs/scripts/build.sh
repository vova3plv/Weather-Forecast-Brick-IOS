#!/bin/bash
# Скрипт для автоматизації збірки та тестування iOS-додатку через термінал (xcodebuild)

SCHEME="WeatherBrick"
# Симулятор для тестування
DESTINATION="platform=iOS Simulator,name=iPhone 14 Pro,OS=latest"

echo "🚀 Починаємо очищення проєкту..."
xcodebuild clean -scheme "$SCHEME" -destination "$DESTINATION" | xcpretty

echo "🛠 Починаємо збірку та тестування..."
xcodebuild test -scheme "$SCHEME" -destination "$DESTINATION" | xcpretty

if [ ${PIPESTATUS[0]} -eq 0 ]; then
    echo "Збірка та тести пройшли успішно!"
else
    echo "Помилка збірки або тестів."
    exit 1
fi
