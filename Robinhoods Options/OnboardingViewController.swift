//
//  OnboardingViewController.swift
//  Robinhoods Options
//
//  Created by Ravil on 07.12.2023.
//

import UIKit

class OnboardingViewController: UIViewController {

    let onboBackground = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        onboBackground.image = UIImage(named: "background")
        onboBackground.layer.masksToBounds = true
        onboBackground.contentMode = .scaleAspectFit
        onboBackground.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboBackground)
        
        NSLayoutConstraint.activate([
            onboBackground.topAnchor.constraint(equalTo: view.topAnchor),
            onboBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onboBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            onboBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

