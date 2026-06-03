//
//  CustomAlertView.swift
//  weather-forecast-brick
//
//  Created by Мария Анисович on 01.09.2024.
//

import UIKit

final class InfoAlertView: UIView {
    private lazy var infoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hex: "#FF9960")
        view.layer.cornerRadius = 14
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "INFO"
        label.font = UIFont(name: "Ubuntu-Bold", size: 18)
        label.textColor = UIColor(hex: "#2D2D2D")
        return label
    }()
    
    private lazy var hideButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Hide", for: .normal)
        button.setTitleColor(UIColor(hex: "#575757"), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "Ubuntu-Medium", size: 15)
        button.layer.cornerRadius = 14
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(hex: "#575757").cgColor
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(hex: "#FB5F29")
        layer.cornerRadius = 14
        
        setupInfoView()
        
        setupTitleLabel()
        
        setupStackView()
        
        setupHideButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        addShadow()
    }
    
    private func addShadow() {
        layer.masksToBounds = false
        layer.cornerRadius = 14
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 14).cgPath
        layer.shadowColor = UIColor(hex: "#000000").cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 2
    }
    
    private func setupInfoView() {
        addSubview(infoView)
        
        NSLayoutConstraint.activate([
            infoView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -8),
            infoView.topAnchor.constraint(equalTo: topAnchor),
            infoView.widthAnchor.constraint(equalToConstant: 269),
            infoView.heightAnchor.constraint(equalToConstant: 372)
        ])
    }

    private func setupTitleLabel() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            titleLabel.widthAnchor.constraint(equalToConstant: 44),
            titleLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    private func setupStackView() {
        var infoLabels: [InfoLabel] = []
        
        for _ in 0...6 {
            infoLabels.append(InfoLabel())
        }
        
        infoLabels[0].text = "Brick is wet - raining"
        infoLabels[1].text = "Brick is dry - sunny"
        infoLabels[2].text = "Brick is hard to see - fog"
        infoLabels[3].text = "Brick with cracks - very hot"
        infoLabels[4].text = "Brick with snow - snow"
        infoLabels[5].text = "Brick is swinging - windy"
        infoLabels[6].text = "Brick is gone - No Internet"
                
        let stackView = UIStackView(arrangedSubviews: infoLabels)
                
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
                
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 70),
            stackView.widthAnchor.constraint(equalToConstant: 217),
            stackView.heightAnchor.constraint(equalToConstant: 215)
        ])
    }
    
    private func setupHideButton() {
        addSubview(hideButton)
        
        NSLayoutConstraint.activate([
            hideButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            hideButton.topAnchor.constraint(equalTo: topAnchor, constant: 317),
            hideButton.widthAnchor.constraint(equalToConstant: 115),
            hideButton.heightAnchor.constraint(equalToConstant: 31)
        ])
    }
    
    func addButtonTarget(_ target: Any?, action: Selector) {
        hideButton.addTarget(target, action: action, for: .touchUpInside)
    }
}
