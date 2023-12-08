//
//  AliasResultCell.swift
//  Robinhoods Options
//
//  Created by Ravil on 08.12.2023.
//

import UIKit

class AliasResultCell: UITableViewCell {
    
    let cardWord = UIView()
    let nameWord = UILabel()
    let imageWord = UIImageView()
    
    static let id = String(describing: AliasResultCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        cardWord.backgroundColor = .white
        cardWord.layer.cornerRadius = 28
        cardWord.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cardWord)
        
        nameWord.text = "Candle"
        nameWord.textColor = .black
        nameWord.numberOfLines = 0
        nameWord.font = UIFont(name: "NotoSans-Medium", size: 16)
        nameWord.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameWord)
        
        imageWord.image = UIImage(named: "correct")
        imageWord.layer.masksToBounds = true
        imageWord.contentMode = .scaleAspectFill
        imageWord.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageWord)
        
        NSLayoutConstraint.activate([
            cardWord.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardWord.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardWord.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardWord.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            cardWord.heightAnchor.constraint(equalToConstant: 56),
            
            nameWord.leadingAnchor.constraint(equalTo: cardWord.leadingAnchor, constant: 24),
            nameWord.centerYAnchor.constraint(equalTo: cardWord.centerYAnchor),
            
            imageWord.trailingAnchor.constraint(equalTo: cardWord.trailingAnchor, constant: -24),
            imageWord.centerYAnchor.constraint(equalTo: cardWord.centerYAnchor),
            imageWord.heightAnchor.constraint(equalToConstant: 24),
            imageWord.widthAnchor.constraint(equalToConstant: 24),
        ])
    }
}
