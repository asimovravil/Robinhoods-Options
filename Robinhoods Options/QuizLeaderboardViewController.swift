//
//  QuizLeaderboardViewController.swift
//  Robinhoods Options
//
//  Created by Ravil on 09.12.2023.
//

import UIKit

class QuizLeaderboardViewController: UIViewController {
    
    let tableViewAliasLeaderboard = UITableView(frame: .zero, style: .plain)
    let onboardingSkip = UIButton()
    let aliasleaderBackground = UIImageView()
    let buttonNewGame = UIButton()
    let nameTeam = UILabel()
    var playerScores: [(name: String, score: Int)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func setupUI() {
        onboardingSkip.setImage(UIImage(named: "skip"), for: .normal)
        view.addSubview(onboardingSkip)
        
        aliasleaderBackground.image = UIImage(named: "aliasleaderBackground")
        aliasleaderBackground.layer.masksToBounds = true
        aliasleaderBackground.contentMode = .scaleAspectFill
        aliasleaderBackground.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aliasleaderBackground)
        
        tableViewAliasLeaderboard.register(QuizLeaderboardCell.self, forCellReuseIdentifier: QuizLeaderboardCell.id)
        tableViewAliasLeaderboard.dataSource = self
        tableViewAliasLeaderboard.delegate = self
        tableViewAliasLeaderboard.showsVerticalScrollIndicator = false
        tableViewAliasLeaderboard.isUserInteractionEnabled = true
        tableViewAliasLeaderboard.backgroundColor = .clear
        tableViewAliasLeaderboard.separatorStyle = .none
        tableViewAliasLeaderboard.rowHeight = 68
        tableViewAliasLeaderboard.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableViewAliasLeaderboard)
        
        buttonNewGame.setImage(UIImage(named: "newGame"), for: .normal)
        buttonNewGame.addTarget(self, action: #selector(buttonNewGameTapped), for: .touchUpInside)
        buttonNewGame.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonNewGame)
        
        nameTeam.text = "Friendship"
        nameTeam.textColor = .black
        nameTeam.numberOfLines = 0
        nameTeam.textAlignment = .center
        nameTeam.font = UIFont(name: "NotoSans-SemiBold", size: 32)
        nameTeam.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTeam)
        
        NSLayoutConstraint.activate([
            aliasleaderBackground.topAnchor.constraint(equalTo: view.topAnchor),
            aliasleaderBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            aliasleaderBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            aliasleaderBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            tableViewAliasLeaderboard.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableViewAliasLeaderboard.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableViewAliasLeaderboard.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            buttonNewGame.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            buttonNewGame.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameTeam.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        if UIScreen.main.bounds.size.height >= 812 {
            NSLayoutConstraint.activate([
                nameTeam.topAnchor.constraint(equalTo: view.topAnchor, constant: 220),
                tableViewAliasLeaderboard.topAnchor.constraint(equalTo: view.topAnchor, constant: 364),
            ])
        } else {
            NSLayoutConstraint.activate([
                nameTeam.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
                tableViewAliasLeaderboard.topAnchor.constraint(equalTo: view.topAnchor, constant: 280),
            ])
        }
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
    
    @objc func buttonNewGameTapped() {
        let homeVC = HomeViewController()
        homeVC.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
}

extension QuizLeaderboardViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerScores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuizLeaderboardCell.id, for: indexPath) as? QuizLeaderboardCell else {
            fatalError("Could not cast to AliasLeaderboardCell")
        }
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        let playerScore = playerScores[indexPath.row]
        cell.configure(with: playerScore.name, score: playerScore.score)
        cell.placeWord.text = "\(indexPath.row + 1)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
