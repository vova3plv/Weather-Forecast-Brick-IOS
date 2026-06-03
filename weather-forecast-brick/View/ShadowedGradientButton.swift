//
//  ShadowedGradientButton.swift
//  weather-forecast-brick
//
//  Created by Мария Анисович on 09.08.2024.
//

import UIKit

final class ShadowedGradientButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()

        self.addShadow()

        self.addGradient()
    }

    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(hex: "#FF9960").cgColor, UIColor(hex: "#F9501B").cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = 14
        gradientLayer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func addShadow() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 14
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 14).cgPath
        self.layer.shadowColor = UIColor(hex: "#000000").cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowOpacity = 0.25
        self.layer.shadowRadius = 3
    }
}
