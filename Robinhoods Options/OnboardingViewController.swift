//
//  OnboardingViewController.swift
//  Robinhoods Options
//
//  Created by Ravil on 07.12.2023.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    var sectionPageList = 0
    
    let onboardingBackground = UIImageView()
    let onboardingImage = UIImageView()
    let onboardingTitle = UILabel()
    let onboardingSubTitle = UILabel()
    let onboardingPage = UIPageControl()
    let onboardingNext = UIButton()
    let onboardingSkip = UIButton()
    
    func updateContentForPage(_ page: Int) {
        let sectionData = onboardingList[page]
        onboardingTitle.text = sectionData.onboardingTitle
        onboardingSubTitle.text = sectionData.onboardingSubTitle
        onboardingImage.image = UIImage(named: sectionData.onboardingImage)
    }
    
    @objc func sectionNextClapped() {
        if sectionPageList < onboardingList.count - 1 {
            sectionPageList += 1
        } else {
            print("good")
        }
        
        updateContentForPage(sectionPageList)
        onboardingPage.currentPage = sectionPageList
    }
    
    private func setupNavigationBar() {
        let sectionSkipBarButton = UIBarButtonItem(customView: onboardingSkip)
        navigationItem.leftBarButtonItem = sectionSkipBarButton
        onboardingSkip.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
    }

    @objc private func skipButtonTapped() {
        print("good")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateContentForPage(sectionPageList)
        setupNavigationBar()
        
        onboardingSkip.setImage(UIImage(named: "skip"), for: .normal)
        view.addSubview(onboardingSkip)
        
        onboardingBackground.image = UIImage(named: "background")
        onboardingBackground.layer.masksToBounds = true
        onboardingBackground.contentMode = .scaleAspectFill
        onboardingBackground.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboardingBackground)
        
        onboardingImage.layer.masksToBounds = true
        onboardingImage.contentMode = .scaleAspectFit
        onboardingImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboardingImage)
        
        onboardingTitle.textAlignment = .left
        onboardingTitle.textColor = .black
        onboardingTitle.numberOfLines = 0
        onboardingTitle.font = UIFont(name: "NotoSans-SemiBold", size: 42)
        onboardingTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboardingTitle)
        
        onboardingSubTitle.textAlignment = .left
        onboardingSubTitle.textColor = .black
        onboardingSubTitle.numberOfLines = 0
        onboardingSubTitle.alpha = 0.40
        onboardingSubTitle.font = UIFont(name: "NotoSans-Regular", size: 16)
        onboardingSubTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboardingSubTitle)
        
        onboardingPage.numberOfPages = onboardingList.count
        onboardingPage.currentPage = sectionPageList
        onboardingPage.currentPageIndicatorTintColor = .black
        onboardingPage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboardingPage)
        
        onboardingNext.setImage(UIImage(named: "hello"), for: .normal)
        onboardingNext.addTarget(self, action: #selector(sectionNextClapped), for: .touchUpInside)
        onboardingNext.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboardingNext)
        
        if UIScreen.main.bounds.size.height >= 812 {
            NSLayoutConstraint.activate([
                onboardingImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            ])
        } else {
            NSLayoutConstraint.activate([
                onboardingImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
                onboardingImage.heightAnchor.constraint(equalToConstant: 280),
            ])
        }
        
        NSLayoutConstraint.activate([
            onboardingBackground.topAnchor.constraint(equalTo: view.topAnchor),
            onboardingBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onboardingBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            onboardingBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            onboardingImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onboardingImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            onboardingTitle.bottomAnchor.constraint(equalTo: onboardingSubTitle.topAnchor, constant: -8),
            onboardingTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            onboardingTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            onboardingSubTitle.bottomAnchor.constraint(equalTo: onboardingPage.topAnchor, constant: -24),
            onboardingSubTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            onboardingSubTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            onboardingPage.bottomAnchor.constraint(equalTo: onboardingNext.topAnchor, constant: -16),
            onboardingPage.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            onboardingNext.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            onboardingNext.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        if UIScreen.main.bounds.size.height >= 812 {
            NSLayoutConstraint.activate([
            ])
        } else {
            NSLayoutConstraint.activate([
            ])
        }
    }
}

