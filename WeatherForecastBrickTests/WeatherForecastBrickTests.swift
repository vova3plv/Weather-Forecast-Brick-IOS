//
//  WeatherForecastBrickTests.swift
//  WeatherForecastBrickTests
//
//  Created by Мария Анисович on 13.09.2024.
//

import SnapshotTesting
import XCTest

@testable import weather_forecast_brick

final class WeatherForecastBrickTests: XCTestCase {
    func testInfoAlertViewController() throws {
        let infoAlertViewController = InfoAlertViewController()

        assertSnapshot(of: infoAlertViewController, as: .image)
    }
}
