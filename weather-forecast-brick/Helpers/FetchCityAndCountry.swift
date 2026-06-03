//
//  FetchCityAndCountry.swift
//  weather-forecast-brick
//
//  Created by Мария Анисович on 04.09.2024.
//

import CoreLocation
import Foundation

func fetchCityAndCountry(location: CLLocation) async throws -> [CLPlacemark] {
    let geocoder = CLGeocoder()

    let placemarks = try await geocoder.reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "en_US"))

    return placemarks
}
