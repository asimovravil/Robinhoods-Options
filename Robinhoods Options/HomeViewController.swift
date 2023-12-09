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
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: nil, action: nil)
        
        homeBackground.image = UIImage(named: "homeBackground")
        homeBackground.layer.masksToBounds = true
        homeBackground.contentMode = .scaleAspectFill
        homeBackground.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(homeBackground)
        
        homeAlias.setImage(UIImage(named: "alias"), for: .normal)
        homeAlias.addTarget(self, action: #selector(homeAliasMethod), for: .touchUpInside)
        homeAlias.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(homeAlias)
        
        homeQuiz.setImage(UIImage(named: "quiz"), for: .normal)
        homeQuiz.addTarget(self, action: #selector(homeQuizMethod), for: .touchUpInside)
        homeQuiz.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(homeQuiz)
        
        homeFAQ.setImage(UIImage(named: "faq"), for: .normal)
        homeFAQ.addTarget(self, action: #selector(homeFAQMethod), for: .touchUpInside)
        homeFAQ.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(homeFAQ)
        
        homeSettings.setImage(UIImage(named: "settings"), for: .normal)
        homeSettings.addTarget(self, action: #selector(homeSettingsMethod), for: .touchUpInside)
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
    
    @objc func homeQuizMethod() {
        let quizVC = QuizTeamViewController()
        self.navigationController?.pushViewController(quizVC, animated: true)
    }
    
    @objc func homeAliasMethod() {
        let aliasVC = AliasTeamViewController()
        self.navigationController?.pushViewController(aliasVC, animated: true)
    }
    
    @objc func homeFAQMethod() {
        let faqVC = FAQViewController()
        self.navigationController?.pushViewController(faqVC, animated: true)
    }
    
    @objc func homeSettingsMethod() {
        let settingsVC = SettingsViewController()
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }
}
