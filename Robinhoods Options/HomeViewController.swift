//
//  HomeViewController.swift
//  Robinhoods Options
//
//  Created by Ravil on 07.12.2023.
//

import UIKit

class HomeViewController: UIViewController {

    let homeBackground = UIImageView()
    
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
        
        NSLayoutConstraint.activate([
            homeBackground.topAnchor.constraint(equalTo: view.topAnchor),
            homeBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
