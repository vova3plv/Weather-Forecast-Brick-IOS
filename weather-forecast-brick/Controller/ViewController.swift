//
//  ViewController.swift
//  weather-forecast-brick
//
//  Created by Мария Анисович on 07.08.2024.
//

import CoreLocation
import UIKit

final class ViewController: UIViewController {
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "image_background"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "Ubuntu-Regular", size: 83)
        label.textColor = UIColor(hex: "#2D2D2D")
        return label
    }()

    private lazy var weatherLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "Ubuntu-Light", size: 36)
        label.textColor = UIColor(hex: "#2D2D2D")
        return label
    }()

    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "Ubuntu-Medium", size: 17)
        label.textColor = UIColor(hex: "#2D2D2D")
        return label
    }()

    private lazy var infoButton: ShadowedGradientButton = {
        let button = ShadowedGradientButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("INFO", for: .normal)
        button.setTitleColor(UIColor(hex: "#2D2D2D"), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "Ubuntu-Bold", size: 18)
        return button
    }()

    private let locationManager = CLLocationManager()

    private var stoneImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        setupBackgroundImageView()

        setupTemperatureLabel()

        setupWeatherLabel()

        setupLocationLabel()

        setupInfoButton()
    }

    private func setupBackgroundImageView() {
        view.addSubview(backgroundImageView)

        backgroundImageView.accessibilityIdentifier = "backgroundImageView"

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func setupTemperatureLabel() {
        view.addSubview(temperatureLabel)

        temperatureLabel.accessibilityIdentifier = "temperatureLabel"

        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 461),
            temperatureLabel.widthAnchor.constraint(equalToConstant: 160),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 126),
            temperatureLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }

    private func setupWeatherLabel() {
        view.addSubview(weatherLabel)

        weatherLabel.accessibilityIdentifier = "weatherLabel"

        NSLayoutConstraint.activate([
            weatherLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 558),
            weatherLabel.widthAnchor.constraint(equalToConstant: 95),
            weatherLabel.heightAnchor.constraint(equalToConstant: 58),
            weatherLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }

    private func setupLocationLabel() {
        view.addSubview(locationLabel)

        locationLabel.accessibilityIdentifier = "locationLabel"

        NSLayoutConstraint.activate([
            locationLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -81),
            locationLabel.widthAnchor.constraint(equalToConstant: 375),
            locationLabel.heightAnchor.constraint(equalToConstant: 42),
            locationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func setupInfoButton() {
        view.addSubview(infoButton)

        infoButton.accessibilityIdentifier = "infoButton"

        NSLayoutConstraint.activate([
            infoButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            infoButton.widthAnchor.constraint(equalToConstant: 175),
            infoButton.heightAnchor.constraint(equalToConstant: 65),
            infoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        infoButton.addTarget(self, action: #selector(presentInfoAlert), for: .touchUpInside)
    }

    @objc private func presentInfoAlert() {
        let alertVC = InfoAlertViewController()
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC, animated: true, completion: nil)
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()

        let userLocation: CLLocation = locations[0]

        Task.detached {
            do {
                let weatherData = try await fetchWeatherFromAPI(lat: userLocation.coordinate.latitude, lon: userLocation.coordinate.longitude)
                await self.updateWeatherData(weatherData: weatherData)
            } catch {
                await self.setupImageViewWithoutStone()
            }
        }

        Task.detached {
            do {
                let placemarks = try await fetchCityAndCountry(location: userLocation)
                await self.updateLocation(placemarks: placemarks)
            } catch {
                await self.setupImageViewWithoutStone()
            }
        }
    }

    @MainActor
    private func updateWeatherData(weatherData: WeatherData) {
        if let weather = weatherData.weather.first {
            temperatureLabel.text = String(Int(weatherData.main.temp)) + "°"
            weatherLabel.text = getWeatherDescription(weatherDescriptionData: weather.description)
            setupStoneImageView(temperature: weatherData.main.temp, windSpeed: weatherData.wind.speed)
        }
    }

    @MainActor
    private func updateLocation(placemarks: [CLPlacemark]) {
        if let placemark = placemarks.first {
            if let city = placemark.locality, let country = placemark.country {
                setupIcons(text: city + ", " + country)
            }
        }
    }

    @MainActor
    private func setupImageViewWithoutStone() {
        if stoneImageView != nil {
            stoneImageView.removeFromSuperview()
            stoneImageView = nil
        }

        if let image = UIImage(named: "image_stone_normal.png") {
            stoneImageView = UIImageView(image: image)
            stoneImageView.translatesAutoresizingMaskIntoConstraints = false
            stoneImageView.contentMode = .top
            stoneImageView.clipsToBounds = true

            view.addSubview(stoneImageView)

            stoneImageView.accessibilityIdentifier = "stoneImageView"

            stoneImageView.isUserInteractionEnabled = true
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
            stoneImageView.addGestureRecognizer(panGesture)

            NSLayoutConstraint.activate([
                stoneImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: -50),
                stoneImageView.widthAnchor.constraint(equalToConstant: 224),
                stoneImageView.heightAnchor.constraint(equalToConstant: 155),
                stoneImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        }
    }

    private func getWeatherDescription(weatherDescriptionData: String) -> String {
        var weatherDescription = ""

        if weatherDescriptionData == "clear sky" || weatherDescriptionData == "few clouds" || weatherDescriptionData == "scattered clouds" || weatherDescriptionData == "broken clouds" {
            weatherDescription = "sunny"
        } else if weatherDescriptionData == "shower rain" || weatherDescriptionData == "rain" || weatherDescriptionData == "thunderstorm" {
            weatherDescription = "rainy"
        } else if weatherDescriptionData == "snow" {
            weatherDescription = "snow"
        } else if weatherDescriptionData == "mist" {
            weatherDescription = "fog"
        }

        return weatherDescription
    }

    private func setupStoneImageView(temperature: Double, windSpeed: Double) {
        if stoneImageView != nil {
            stoneImageView.removeFromSuperview()
            stoneImageView = nil
        }

        stoneImageView = getStoneImageView(temperature: temperature, windSpeed: windSpeed)
        stoneImageView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stoneImageView)

        stoneImageView.accessibilityIdentifier = "stoneImageView"

        stoneImageView.isUserInteractionEnabled = true
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        stoneImageView.addGestureRecognizer(panGesture)

        NSLayoutConstraint.activate([
            stoneImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: -50),
            stoneImageView.widthAnchor.constraint(equalToConstant: 224),
            stoneImageView.heightAnchor.constraint(equalToConstant: 455),
            stoneImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        if translation.y > 50 {
            stoneImageView.frame.origin.y = 0
        } else if translation.y > 0 {
            stoneImageView.frame.origin.y = -50 + translation.y
        }

        if gesture.state == .ended {
            UIView.animate(withDuration: 0.3, animations: {
                self.stoneImageView.frame.origin.y = -50
            })
            locationManager.startUpdatingLocation()
        }
    }

    private func setupIcons(text: String) {
        if let leftIcon = UIImage(named: "icon_location"), let rightIcon = UIImage(named: "icon_search") {
            let leftIconAttachment = NSTextAttachment()
            leftIconAttachment.image = leftIcon
            leftIconAttachment.bounds = CGRect(x: 0, y: (locationLabel.font.capHeight - leftIcon.size.height) / 2, width: leftIcon.size.width, height: leftIcon.size.height)

            let rightIconAttachment = NSTextAttachment()
            rightIconAttachment.image = rightIcon
            rightIconAttachment.bounds = CGRect(x: 0, y: (locationLabel.font.capHeight - rightIcon.size.height) / 2, width: rightIcon.size.width, height: rightIcon.size.height)

            let leftIconString = NSAttributedString(attachment: leftIconAttachment)
            let rightIconString = NSAttributedString(attachment: rightIconAttachment)

            let textString = NSAttributedString(string: text)

            let completeString = NSMutableAttributedString()
            completeString.append(leftIconString)
            completeString.append(NSAttributedString(string: " "))
            completeString.append(textString)
            completeString.append(NSAttributedString(string: " "))
            completeString.append(rightIconString)

            locationLabel.attributedText = completeString
        }
    }

    private func getStoneImageView(temperature: Double, windSpeed: Double) -> UIImageView {
        var image = UIImage(named: "image_stone_normal")

        if weatherLabel.text == "rainy" {
            image = UIImage(named: "image_stone_wet")
        } else if weatherLabel.text == "snow" {
            image = UIImage(named: "image_stone_snow")
        } else if weatherLabel.text == "rainy" {
            image = UIImage(named: "image_stone_wet")
        } else if weatherLabel.text == "fog" {
            if let img = image {
                if let ciImage = CIImage(image: img) {
                    image = UIImage(ciImage: ciImage.applyingGaussianBlur(sigma: 10))
                }
            }
        } else if temperature >= 31 {
            image = UIImage(named: "image_stone_cracks")
        }

        let imageView = UIImageView(image: image)
        let maxWindSpeed = 15.0

        if windSpeed >= maxWindSpeed {
            imageView.transform = imageView.transform.rotated(by: CGFloat(Double.pi / 4))
        }

        return imageView
    }
}
