//
//  QuizListViewController.swift
//  Robinhoods Options
//
//  Created by Ravil on 07.12.2023.
//

import UIKit

class QuizListViewController: UIViewController {

    let quizList = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppColor.backgroundLightGray.uiColor
        setupUI()
    }
    
    func setupUI() {
        quizList.image = UIImage(named: "quizList")
        quizList.layer.masksToBounds = true
        quizList.contentMode = .scaleAspectFill
        quizList.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(quizList)
        
        NSLayoutConstraint.activate([
            quizList.topAnchor.constraint(equalTo: view.topAnchor),
            quizList.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}
