//
//  FirstNavigationViewController.swift
//  Mayan Secrets
//
//  Created by Ravil on 10.11.2023.
//

import UIKit

final class KnowListViewController: UIViewController {
    
    private let loadingBackground = UIImageView()
    private let loadingRotation = UIImageView()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(loadingBackground)
        view.addSubview(loadingRotation)
        circleLogicSplashAnimation()
        
        loadingRotation.image = UIImage(named: "loadsplash")
        loadingRotation.layer.masksToBounds = true
        loadingRotation.contentMode = .scaleAspectFill
        loadingRotation.translatesAutoresizingMaskIntoConstraints = false
        
        loadingBackground.image = UIImage(named: "loadBack")
        loadingBackground.layer.masksToBounds = true
        loadingBackground.contentMode = .scaleAspectFill
        loadingBackground.translatesAutoresizingMaskIntoConstraints = false
        
        if UIScreen.main.bounds.size.height >= 812 {
            NSLayoutConstraint.activate([
                loadingRotation.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -130)
            ])
        } else {
            NSLayoutConstraint.activate([
                loadingRotation.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80)
            ])
        }
        NSLayoutConstraint.activate([
            loadingBackground.topAnchor.constraint(equalTo: view.topAnchor),
            loadingBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingRotation.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    private func circleLogicSplashAnimation() {
        let fastFullAnimation = CGFloat(Double.pi * 2)
        let splashLoadAnim = CABasicAnimation(keyPath: "transform.rotation")
        splashLoadAnim.fromValue = 0.0
        splashLoadAnim.toValue = fastFullAnimation
        splashLoadAnim.duration = 1.0
        splashLoadAnim.repeatCount = .greatestFiniteMagnitude
        self.loadingRotation.layer.add(splashLoadAnim, forKey: "360rotation")
    }
}
