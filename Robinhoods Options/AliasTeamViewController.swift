//
//  AliasTeamViewController.swift
//  Robinhoods Options
//
//  Created by Ravil on 08.12.2023.
//

import UIKit

class AliasTeamViewController: UIViewController {

    var numberOfPlayers = 2
    var teamNames: [String] = []
    
    let tableViewAliasTeam = UITableView(frame: .zero, style: .plain)
    let aliasStart = UIButton()
    let aliasPlus = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppColor.backgroundLightGray.uiColor
        setupNavBar()
        setupUI()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func aliasPlusTapped() {
        numberOfPlayers += 1
        tableViewAliasTeam.reloadData()
        validateStartButton()
    }

    
    private func setupUI() {
        tableViewAliasTeam.register(AliasTeamCell.self, forCellReuseIdentifier: AliasTeamCell.id)
        tableViewAliasTeam.dataSource = self
        tableViewAliasTeam.delegate = self
        tableViewAliasTeam.showsVerticalScrollIndicator = false
        tableViewAliasTeam.isUserInteractionEnabled = true
        tableViewAliasTeam.backgroundColor = .clear
        tableViewAliasTeam.separatorStyle = .none
        tableViewAliasTeam.rowHeight = 88
        tableViewAliasTeam.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableViewAliasTeam)
        
        aliasStart.setImage(UIImage(named: "startAlias"), for: .normal)
        aliasStart.isEnabled = false
        aliasStart.addTarget(self, action: #selector(aliasStartTapped), for: .touchUpInside)
        aliasStart.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aliasStart)
        
        aliasPlus.setImage(UIImage(named: "plus"), for: .normal)
        aliasPlus.addTarget(self, action: #selector(aliasPlusTapped), for: .touchUpInside)
        aliasPlus.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aliasPlus)
        
        NSLayoutConstraint.activate([
            tableViewAliasTeam.topAnchor.constraint(equalTo: view.topAnchor),
            tableViewAliasTeam.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableViewAliasTeam.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableViewAliasTeam.bottomAnchor.constraint(equalTo: aliasStart.topAnchor, constant: -24),
            
            aliasStart.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            aliasPlus.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            aliasPlus.bottomAnchor.constraint(equalTo: aliasStart.topAnchor, constant: -20),
        ])
        
        if UIScreen.main.bounds.size.height >= 812 {
            NSLayoutConstraint.activate([
                aliasStart.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            ])
        } else {
            NSLayoutConstraint.activate([
                aliasStart.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            ])
        }
    }
    
    @objc private func aliasStartTapped() {
        let aliasGameViewController = AliasGameViewController()
        aliasGameViewController.teamNames = teamNames.map { ($0, 0) }
        navigationController?.pushViewController(aliasGameViewController, animated: true)
    }
    
    private func setupNavBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        let titleLabel = UILabel()
        titleLabel.text = "Teams"
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "NotoSans-SemiBold", size: 16)
        navigationItem.titleView = titleLabel

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundImage = UIImage(named: "navbar")
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}

extension AliasTeamViewController: UITableViewDataSource, UITableViewDelegate, AliasTeamCellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfPlayers
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AliasTeamCell.id, for: indexPath) as? AliasTeamCell else {
            fatalError("Could not cast to AliasTeamCell")
        }
        cell.delegate = self
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.teamPlaceHolder.placeholder = "Team \(indexPath.row + 1)"
        
        if indexPath.row < teamNames.count {
            cell.teamPlaceHolder.text = teamNames[indexPath.row]
        } else {
            cell.teamPlaceHolder.text = ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func didTapAliasPlus() {
        numberOfPlayers += 1
        tableViewAliasTeam.reloadData()
    }
    
    func didChangeText(newText: String, in cell: AliasTeamCell) {
        if let indexPath = tableViewAliasTeam.indexPath(for: cell) {
            // Проверьте, что indexPath.row находится в пределах допустимого диапазона
            if indexPath.row < teamNames.count {
                teamNames[indexPath.row] = newText // Обновите данные в массиве teamNames
            } else {
                // Если индекс выходит за пределы текущей длины, добавьте новый элемент в массив
                teamNames.append(newText)
            }
        }
        validateStartButton()
    }

    
    private func validateStartButton() {
        var allFieldsValid = true
        for i in 0..<numberOfPlayers {
            if let cell = tableViewAliasTeam.cellForRow(at: IndexPath(row: i, section: 0)) as? AliasTeamCell {
                if cell.teamPlaceHolder.text?.count ?? 0 < 3 {
                    allFieldsValid = false
                    break
                }
            }
        }
        aliasStart.isEnabled = allFieldsValid
    }
}
