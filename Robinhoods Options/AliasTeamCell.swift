//
//  AliasTeamCell.swift
//  Robinhoods Options
//
//  Created by Ravil on 08.12.2023.
//

import UIKit

class AliasTeamCell: UITableViewCell {

    let teamPlaceHolder = UITextField()
    let aliasPlus = UIButton()
    
    static let id = String(describing: AliasTeamCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        teamPlaceHolder.placeholder = "Team"
        teamPlaceHolder.font = UIFont(name: "NotoSans-Medium", size: 16)
        teamPlaceHolder.textAlignment = .left
        teamPlaceHolder.textColor = .black
        teamPlaceHolder.autocorrectionType = .no
        teamPlaceHolder.keyboardType = .default
        teamPlaceHolder.backgroundColor = .white
        teamPlaceHolder.layer.cornerRadius = 32
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: teamPlaceHolder.frame.height))
        teamPlaceHolder.leftView = paddingView
        teamPlaceHolder.leftViewMode = .always
        
        teamPlaceHolder.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(teamPlaceHolder)
        
        aliasPlus.setImage(UIImage(named: "plus"), for: .normal)
        aliasPlus.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(aliasPlus)
        
        NSLayoutConstraint.activate([
            teamPlaceHolder.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            teamPlaceHolder.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            teamPlaceHolder.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            teamPlaceHolder.heightAnchor.constraint(equalToConstant: 64),
            
            aliasPlus.topAnchor.constraint(equalTo: teamPlaceHolder.bottomAnchor, constant: 24),
            aliasPlus.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
    func showAliasPlusButton(_ show: Bool) {
        aliasPlus.isHidden = !show
    }
}
