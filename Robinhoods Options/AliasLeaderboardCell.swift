//
//  AliasLeaderboardCell.swift
//  Robinhoods Options
//
//  Created by Ravil on 08.12.2023.
//

import UIKit

class AliasLeaderboardCell: UITableViewCell {
    
    let cardWord = UIView()
    let placeWord = UILabel()
    let nameWord = UILabel()
    let amountWord = UILabel()
    
    static let id = String(describing: AliasLeaderboardCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        cardWord.backgroundColor = .white
        cardWord.layer.cornerRadius = 22
        cardWord.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cardWord)
        
        placeWord.text = "1"
        placeWord.textColor = .black
        placeWord.numberOfLines = 0
        placeWord.font = UIFont(name: "NotoSans-Medium", size: 16)
        placeWord.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(placeWord)
        
        nameWord.text = "Candle"
        nameWord.textColor = .black
        nameWord.numberOfLines = 0
        nameWord.font = UIFont(name: "NotoSans-Medium", size: 16)
        nameWord.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameWord)
        
        amountWord.text = "0"
        amountWord.textColor = .black
        amountWord.numberOfLines = 0
        amountWord.font = UIFont(name: "NotoSans-SemiBold", size: 20)
        amountWord.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(amountWord)
        
        NSLayoutConstraint.activate([
            cardWord.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardWord.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardWord.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardWord.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            cardWord.heightAnchor.constraint(equalToConstant: 44),
            
            placeWord.leadingAnchor.constraint(equalTo: cardWord.leadingAnchor, constant: 24),
            placeWord.centerYAnchor.constraint(equalTo: cardWord.centerYAnchor),
            
            nameWord.leadingAnchor.constraint(equalTo: placeWord.trailingAnchor, constant: 10),
            nameWord.centerYAnchor.constraint(equalTo: cardWord.centerYAnchor),
            
            amountWord.trailingAnchor.constraint(equalTo: cardWord.trailingAnchor, constant: -24),
            amountWord.centerYAnchor.constraint(equalTo: cardWord.centerYAnchor),
        ])
    }
}
