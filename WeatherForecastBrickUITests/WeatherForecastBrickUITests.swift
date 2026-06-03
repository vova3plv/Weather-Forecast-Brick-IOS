//
//  WeatherForecastBrickUITests.swift
//  WeatherForecastBrickUITests
//
//  Created by Мария Анисович on 13.09.2024.
//

import XCTest

final class WeatherForecastBrickUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false

        let app = XCUIApplication()
        app.launch()
    }
    
    func testWeatherForecastBrick() throws {
        let app = XCUIApplication()
        
        let backgroundImageView = app.images["backgroundImageView"]
        XCTAssertTrue(backgroundImageView.exists, "Image View is not found.")
        
        let stoneImageView = app.images["stoneImageView"]
        XCTAssertTrue(stoneImageView.exists, "Image View is not found.")
        
        let temperatureLabel = app.staticTexts["temperatureLabel"]
        XCTAssertTrue(temperatureLabel.exists, "Label is not found.")
        
        let weatherLabel = app.staticTexts["weatherLabel"]
        XCTAssertTrue(weatherLabel.exists, "Label is not found.")
        
        let locationLabel = app.staticTexts["locationLabel"]
        XCTAssertTrue(locationLabel.exists, "Label is not found.")
        
        let infoButton = app.buttons["infoButton"]
        XCTAssertTrue(infoButton.exists, "Button is not found.")
        infoButton.tap()
        
        let infoAlertView = app.otherElements["infoAlertView"]
        XCTAssertTrue(infoAlertView.exists, "View is not found.")
    }
}
