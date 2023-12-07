//
//  SettingsViewController.swift
//  Robinhoods Options
//
//  Created by Ravil on 07.12.2023.
//

#warning("Вадим добавь ссылку на Privacy Policy")

import UIKit
import StoreKit

class SettingsViewController: UIViewController {

    let settings1 = UIImageView()
    let settings2 = UIButton()
    let settings3 = UIButton()
    let settings4 = UIButton()
    let toggleButonSwitch = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppColor.backgroundLightGray.uiColor
        setupUI()
        setupNavBar()
    }
    
    private func setupUI() {
        view.addSubview(settings1)
        view.addSubview(settings2)
        view.addSubview(settings3)
        view.addSubview(settings4)
        view.addSubview(toggleButonSwitch)
        
        settings4.setImage(UIImage(named: "set4"), for: .normal)
        settings4.translatesAutoresizingMaskIntoConstraints = false
        
        settings3.setImage(UIImage(named: "set3"), for: .normal)
        settings3.translatesAutoresizingMaskIntoConstraints = false
        
        settings2.setImage(UIImage(named: "set2"), for: .normal)
        settings2.translatesAutoresizingMaskIntoConstraints = false
        
        settings1.image = UIImage(named: "set1")
        settings1.layer.masksToBounds = true
        settings1.contentMode = .scaleAspectFill
        settings1.translatesAutoresizingMaskIntoConstraints = false
        
        toggleButonSwitch.addTarget(self, action: #selector(switchTon(_:)), for: .valueChanged)
        settings2.addTarget(self, action: #selector(settings2Metod), for: .touchUpInside)
        settings3.addTarget(self, action: #selector(settings3Metod), for: .touchUpInside)
        settings4.addTarget(self, action: #selector(settings4Metod), for: .touchUpInside)
        
        toggleButonSwitch.setOn(true, animated: true)
        toggleButonSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settings1.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
            settings1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            settings2.topAnchor.constraint(equalTo: settings1.bottomAnchor, constant: 8),
            settings2.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            settings3.topAnchor.constraint(equalTo: settings2.bottomAnchor, constant: 8),
            settings3.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            settings4.topAnchor.constraint(equalTo: settings3.bottomAnchor, constant: 8),
            settings4.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            toggleButonSwitch.topAnchor.constraint(equalTo: settings1.topAnchor, constant: 8),
            toggleButonSwitch.trailingAnchor.constraint(equalTo: settings1.trailingAnchor, constant: -24),
        ])
    }
    
    private func setupNavBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        let titleLabel = UILabel()
        titleLabel.text = "Settings"
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "NotoSans-SemiBold", size: 16)
        navigationItem.titleView = titleLabel

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundImage = UIImage(named: "navbar")
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
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
