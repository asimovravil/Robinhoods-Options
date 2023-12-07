//
//  HomeViewController.swift
//  Robinhoods Options
//
//  Created by Ravil on 07.12.2023.
//

import UIKit

class HomeViewController: UIViewController {

    let homeBackground = UIImageView()
    let homeAlias = UIButton()
    let homeQuiz = UIButton()
    let homeFAQ = UIButton()
    let homeSettings = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        homeBackground.image = UIImage(named: "homeBackground")
        homeBackground.layer.masksToBounds = true
        homeBackground.contentMode = .scaleAspectFill
        homeBackground.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(homeBackground)
        
        homeAlias.setImage(UIImage(named: "alias"), for: .normal)
        homeAlias.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(homeAlias)
        
        homeQuiz.setImage(UIImage(named: "quiz"), for: .normal)
        homeQuiz.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(homeQuiz)
        
        homeFAQ.setImage(UIImage(named: "faq"), for: .normal)
        homeFAQ.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(homeFAQ)
        
        homeSettings.setImage(UIImage(named: "settings"), for: .normal)
        homeSettings.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(homeSettings)
        
        NSLayoutConstraint.activate([
            homeBackground.topAnchor.constraint(equalTo: view.topAnchor),
            homeBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            homeAlias.bottomAnchor.constraint(equalTo: homeQuiz.topAnchor, constant: -12),
            homeAlias.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            homeQuiz.bottomAnchor.constraint(equalTo: homeFAQ.topAnchor, constant: -16),
            homeQuiz.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        if UIScreen.main.bounds.size.height >= 812 {
            NSLayoutConstraint.activate([
                homeSettings.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
                homeFAQ.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
                homeFAQ.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                homeSettings.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            ])
        } else {
            NSLayoutConstraint.activate([
                homeSettings.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
                homeFAQ.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
                homeFAQ.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
                homeSettings.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            ])
        }
    }
}
