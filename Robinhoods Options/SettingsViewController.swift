//
//  SettingsViewController.swift
//  Robinhoods Options
//
//  Created by Ravil on 07.12.2023.
//

import UIKit
import StoreKit

class SettingsViewController: UIViewController {

    private let settings1: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "set1")
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let settings2: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "set2"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let settings3: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "set3"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let settings4: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "set4"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let toggleButonSwitch: UISwitch = {
        let switchView = UISwitch(frame: .zero)
        switchView.setOn(true, animated: true)
        switchView.translatesAutoresizingMaskIntoConstraints = false
        return switchView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppColor.backgroundLightGray.uiColor
        view.addSubview(settings1)
        view.addSubview(settings2)
        view.addSubview(settings3)
        view.addSubview(settings4)
        view.addSubview(toggleButonSwitch)
        constraintsSetup()
        
        toggleButonSwitch.addTarget(self, action: #selector(switchTon(_:)), for: .valueChanged)
        settings2.addTarget(self, action: #selector(settings2Metod), for: .touchUpInside)
        settings3.addTarget(self, action: #selector(settings3Metod), for: .touchUpInside)
        settings4.addTarget(self, action: #selector(settings4Metod), for: .touchUpInside)
    }
    
    private func constraintsSetup() {
        NSLayoutConstraint.activate([
            settings1.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            settings1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            settings2.topAnchor.constraint(equalTo: settings1.bottomAnchor, constant: 16),
            settings2.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            settings3.topAnchor.constraint(equalTo: settings2.bottomAnchor, constant: 16),
            settings3.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            settings4.topAnchor.constraint(equalTo: settings3.bottomAnchor, constant: 16),
            settings4.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            toggleButonSwitch.topAnchor.constraint(equalTo: settings1.topAnchor, constant: 16),
            toggleButonSwitch.trailingAnchor.constraint(equalTo: settings1.trailingAnchor, constant: -24),
        ])
    }
    
    @objc private func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func settings2Metod() {
        let controller = PrivacyController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func settings3Metod() {
        SKStoreReviewController.requestReview()
    }
    
    @objc func settings4Metod() {
        let textToShare = "Check out this awesome app!"
        let appURL = URL(string: "https://www.yourappstorelink.com")!
        
        let activityViewController = UIActivityViewController(activityItems: [textToShare, appURL], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    @objc func switchTon(_ sender : UISwitch){
        if sender.isOn {
            print("On")
        } else {
            print("No")
        }
    }
}
