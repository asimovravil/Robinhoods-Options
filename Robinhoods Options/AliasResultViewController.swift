//
//  AliasResultViewController.swift
//  Robinhoods Options
//
//  Created by Ravil on 08.12.2023.
//

import UIKit

class AliasResultViewController: UIViewController {

    let tableViewAliasResult = UITableView(frame: .zero, style: .plain)
    
    let resultBackground = UIImageView()
    let cardTeam = UIView()
    let nameTeam = UILabel()
    let titleTeam = UILabel()
    let titleGuessed = UILabel()
    let amountGuessed = UILabel()
    let titleSkipped = UILabel()
    let amountSkipped = UILabel()
    let buttonNextTeam = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: false)
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        cardTeam.layer.cornerRadius = 30
    }
    
    private func setupUI() {
        resultBackground.image = UIImage(named: "resultBackground")
        resultBackground.layer.masksToBounds = true
        resultBackground.contentMode = .scaleAspectFill
        resultBackground.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resultBackground)
        
        tableViewAliasResult.register(AliasResultCell.self, forCellReuseIdentifier: AliasResultCell.id)
        tableViewAliasResult.dataSource = self
        tableViewAliasResult.delegate = self
        tableViewAliasResult.showsVerticalScrollIndicator = false
        tableViewAliasResult.isUserInteractionEnabled = true
        tableViewAliasResult.backgroundColor = .clear
        tableViewAliasResult.separatorStyle = .none
        tableViewAliasResult.rowHeight = 72
        tableViewAliasResult.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableViewAliasResult)
        
        cardTeam.backgroundColor = .white
        cardTeam.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cardTeam)
        
        nameTeam.text = "To the moooon"
        nameTeam.textColor = .black
        nameTeam.numberOfLines = 0
        nameTeam.textAlignment = .center
        nameTeam.font = UIFont(name: "NotoSans-SemiBold", size: 32)
        nameTeam.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTeam)
        
        titleTeam.text = "Team"
        titleTeam.textColor = .black
        titleTeam.numberOfLines = 0
        titleTeam.textAlignment = .center
        titleTeam.font = UIFont(name: "NotoSans-Medium", size: 12)
        titleTeam.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleTeam)
        
        titleGuessed.text = "Guessed"
        titleGuessed.textColor = .black
        titleGuessed.numberOfLines = 0
        titleGuessed.textAlignment = .center
        titleGuessed.font = UIFont(name: "NotoSans-SemiBold", size: 32)
        titleGuessed.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleGuessed)
        
        amountGuessed.text = "10"
        amountGuessed.textColor = .black
        amountGuessed.numberOfLines = 0
        amountGuessed.textAlignment = .center
        amountGuessed.font = UIFont(name: "NotoSans-SemiBold", size: 32)
        amountGuessed.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(amountGuessed)
        
        titleSkipped.text = "Skipped"
        titleSkipped.textColor = .black
        titleSkipped.numberOfLines = 0
        titleSkipped.alpha = 0.50
        titleSkipped.textAlignment = .center
        titleSkipped.font = UIFont(name: "NotoSans-SemiBold", size: 16)
        titleSkipped.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleSkipped)
        
        amountSkipped.text = "5"
        amountSkipped.textColor = .black
        amountSkipped.numberOfLines = 0
        amountSkipped.alpha = 0.50
        amountSkipped.textAlignment = .center
        amountSkipped.font = UIFont(name: "NotoSans-SemiBold", size: 16)
        amountSkipped.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(amountSkipped)
        
        buttonNextTeam.setImage(UIImage(named: "nextTeam"), for: .normal)
        buttonNextTeam.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonNextTeam)
        
        NSLayoutConstraint.activate([
            resultBackground.topAnchor.constraint(equalTo: view.topAnchor),
            resultBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resultBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resultBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            cardTeam.topAnchor.constraint(equalTo: view.topAnchor, constant: 138),
            cardTeam.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 47),
            cardTeam.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -47),
            cardTeam.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardTeam.heightAnchor.constraint(equalToConstant: 96),
            
            nameTeam.topAnchor.constraint(equalTo: cardTeam.topAnchor, constant: 16),
            nameTeam.centerXAnchor.constraint(equalTo: cardTeam.centerXAnchor),
            
            titleTeam.bottomAnchor.constraint(equalTo: cardTeam.bottomAnchor, constant: -16),
            titleTeam.centerXAnchor.constraint(equalTo: cardTeam.centerXAnchor),
            
            titleGuessed.topAnchor.constraint(equalTo: cardTeam.bottomAnchor, constant: 122),
            titleGuessed.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            amountGuessed.topAnchor.constraint(equalTo: cardTeam.bottomAnchor, constant: 122),
            amountGuessed.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            titleSkipped.topAnchor.constraint(equalTo: titleGuessed.bottomAnchor, constant: 8),
            titleSkipped.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            amountSkipped.topAnchor.constraint(equalTo: amountGuessed.bottomAnchor, constant: 8),
            amountSkipped.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            buttonNextTeam.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            buttonNextTeam.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableViewAliasResult.topAnchor.constraint(equalTo: titleSkipped.bottomAnchor, constant: 24),
            tableViewAliasResult.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableViewAliasResult.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableViewAliasResult.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension AliasResultViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AliasResultCell.id, for: indexPath) as? AliasResultCell else {
            fatalError("Could not cast to AliasResultCell")
        }
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
