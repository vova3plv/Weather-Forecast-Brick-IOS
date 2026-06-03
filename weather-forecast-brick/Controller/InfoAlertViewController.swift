//
//  InfoAlertViewController.swift
//  weather-forecast-brick
//
//  Created by Мария Анисович on 22.08.2024.
//

import UIKit

final class InfoAlertViewController: UIViewController {
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "image_background"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var infoAlertView: InfoAlertView = {
        let view = InfoAlertView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupBackgroundImageView()
        
        setupInfoAlertView()
    }
    
    private func setupBackgroundImageView() {
        view.addSubview(backgroundImageView)

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupInfoAlertView() {
        infoAlertView.addButtonTarget(nil, action: #selector(hideButtonTapped(_:)))
        
        view.addSubview(infoAlertView)
        
        infoAlertView.accessibilityIdentifier = "infoAlertView"
        
        NSLayoutConstraint.activate([
            infoAlertView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoAlertView.topAnchor.constraint(equalTo: view.topAnchor, constant: 220),
            infoAlertView.widthAnchor.constraint(equalToConstant: 269),
            infoAlertView.heightAnchor.constraint(equalToConstant: 372)
        ])
    }
    
    @objc private func hideButtonTapped(_ button: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
