//
//  InfoLabel.swift
//  weather-forecast-brick
//
//  Created by Мария Анисович on 23.08.2024.
//

import UIKit

final class InfoLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.customizeAppearance()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func customizeAppearance() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = .left
        self.font = UIFont(name: "Ubuntu-Regular", size: 15)
        self.textColor = UIColor(hex: "#2D2D2D")
    }
}
