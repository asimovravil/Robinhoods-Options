//
//  AliasLeaderboardViewController.swift
//  Robinhoods Options
//
//  Created by Ravil on 08.12.2023.
//

import UIKit

class AliasLeaderboardViewController: UIViewController {

    let onboardingSkip = UIButton()
    let aliasleaderBackground = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        setupUI()
    }
    
    private func setupUI() {
        onboardingSkip.setImage(UIImage(named: "skip"), for: .normal)
        view.addSubview(onboardingSkip)
        
        aliasleaderBackground.image = UIImage(named: "aliasleaderBackground")
        aliasleaderBackground.layer.masksToBounds = true
        aliasleaderBackground.contentMode = .scaleAspectFill
        aliasleaderBackground.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aliasleaderBackground)
        
        NSLayoutConstraint.activate([
            aliasleaderBackground.topAnchor.constraint(equalTo: view.topAnchor),
            aliasleaderBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            aliasleaderBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            aliasleaderBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupNavBar() {
        let sectionSkipBarButton = UIBarButtonItem(customView: onboardingSkip)
        navigationItem.leftBarButtonItem = sectionSkipBarButton
        onboardingSkip.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
    }
    
    @objc private func skipButtonTapped() {
        let homeVC = HomeViewController()
        homeVC.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
}
