//
//  AliasListViewController.swift
//  Robinhoods Options
//
//  Created by Ravil on 07.12.2023.
//

import UIKit

class AliasListViewController: UIViewController {

    let aliasList = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppColor.backgroundLightGray.uiColor
        setupUI()
    }
    
    func setupUI() {
        aliasList.image = UIImage(named: "aliesList")
        aliasList.layer.masksToBounds = true
        aliasList.contentMode = .scaleAspectFill
        aliasList.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aliasList)
        
        NSLayoutConstraint.activate([
            aliasList.topAnchor.constraint(equalTo: view.topAnchor),
            aliasList.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}
