//
//  AliasResultViewController.swift
//  Robinhoods Options
//
//  Created by Ravil on 08.12.2023.
//

import UIKit

class AliasResultViewController: UIViewController {

    let resultBackground = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        resultBackground.image = UIImage(named: "resultBackground")
        resultBackground.layer.masksToBounds = true
        resultBackground.contentMode = .scaleAspectFill
        resultBackground.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resultBackground)
        
        NSLayoutConstraint.activate([
            resultBackground.topAnchor.constraint(equalTo: view.topAnchor),
            resultBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resultBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resultBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
