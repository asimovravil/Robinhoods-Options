//
//  AliasTeamViewController.swift
//  Robinhoods Options
//
//  Created by Ravil on 08.12.2023.
//

import UIKit

class AliasTeamViewController: UIViewController {

    let tableViewAliasTeam = UITableView(frame: .zero, style: .plain)
    let aliasStart = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppColor.backgroundLightGray.uiColor
        setupNavBar()
        setupUI()
    }
    
    private func setupUI() {
        tableViewAliasTeam.register(AliasTeamCell.self, forCellReuseIdentifier: AliasTeamCell.id)
        tableViewAliasTeam.dataSource = self
        tableViewAliasTeam.delegate = self
        tableViewAliasTeam.showsVerticalScrollIndicator = false
        tableViewAliasTeam.backgroundColor = .clear
        tableViewAliasTeam.separatorStyle = .none
        tableViewAliasTeam.rowHeight = 88
        tableViewAliasTeam.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableViewAliasTeam)
        
        aliasStart.setImage(UIImage(named: "startAlias"), for: .normal)
        aliasStart.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aliasStart)
        
        NSLayoutConstraint.activate([
            tableViewAliasTeam.topAnchor.constraint(equalTo: view.topAnchor),
            tableViewAliasTeam.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableViewAliasTeam.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableViewAliasTeam.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            aliasStart.centerXAnchor.constraint(equalTo: view.centerXAnchor),
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

extension AliasTeamViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AliasTeamCell.id, for: indexPath) as? AliasTeamCell else {
            fatalError("Could not cast to AliasTeamCell")
        }
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            cell.showAliasPlusButton(true)
        } else {
            cell.showAliasPlusButton(false)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
