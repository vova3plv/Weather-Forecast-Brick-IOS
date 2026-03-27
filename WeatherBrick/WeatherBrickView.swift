//
//  WeatherBrickView.swift
//  WeatherBrick
//
//  Created by Владимир Берденко on 18.02.2024.
//  Copyright © 2024 VAndrJ. All rights reserved.
//

import UIKit

class WeatherBrickView: UIView {

    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor(patternImage: UIImage(named: "image_background")!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
