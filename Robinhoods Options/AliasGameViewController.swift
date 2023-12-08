//
//  AliasGameViewController.swift
//  Robinhoods Options
//
//  Created by Ravil on 08.12.2023.
//

import UIKit
import Shuffle

class AliasGameViewController: UIViewController, SwipeCardStackDataSource, SwipeCardStackDelegate {

    let titleGame = UILabel()
    var cardStack = SwipeCardStack()
    let subTitleGame = UILabel()
    let titleQuestion = UILabel()
    let imageSwipe = UIImageView()
    let titleWord = UILabel()
    
    let words = [
        "Apple", "Banana", "Cat", "Dog", "Elephant",
        "Fish", "Giraffe", "Horse", "Iguana", "Jaguar",
        "Zebra", "Lion", "Bear", "Wolf", "Cheetah",
        "Tiger", "Crocodile", "Parrot", "Eagle", "Penguin",
        "Dolphin", "Shark", "Turtle", "Rabbit", "Hamster",
        "Beauty", "Prince", "Wizard", "Queen", "Flower",
        "Dragon", "Vampire", "Zombie", "Witch", "Elf",
        "Robot", "Car", "Plane", "Train", "Ship",
        "Mountain", "Beach", "Sun", "Moon", "Star",
        "Book", "Music", "Movie", "Computer", "Phone"
    ]

    var sampleCards: [UIImage] = [
        UIImage(named: "card")
    ].compactMap { $0 }
    var cards: [UIView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AppColor.backgroundLightGray.uiColor
        setupUI()
        setupNavBar()
    }
    
    private func setupUI() {
        titleGame.text = "Team"
        titleGame.textColor = .black
        titleGame.numberOfLines = 0
        titleGame.textAlignment = .center
        titleGame.font = UIFont(name: "NotoSans-SemiBold", size: 32)
        titleGame.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleGame)
        
        cardStack.dataSource = self
        cardStack.delegate = self
        cardStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cardStack)
        
        subTitleGame.text = "Each team will play in turn, the game consists of 3 \nrounds of 60 seconds each. You need to explain the \nwords to your team without naming them. The winner \nwill be the team with the most guessed words."
        subTitleGame.textColor = .black
        subTitleGame.alpha = 0.50
        subTitleGame.numberOfLines = 0
        subTitleGame.textAlignment = .center
        subTitleGame.font = UIFont(name: "NotoSans-Regular", size: 14)
        subTitleGame.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subTitleGame)
        
        titleQuestion.text = "Are you ready?"
        titleQuestion.textColor = .black
        titleQuestion.alpha = 0.50
        titleQuestion.numberOfLines = 0
        titleQuestion.textAlignment = .center
        titleQuestion.font = UIFont(name: "NotoSans-SemiBold", size: 16)
        titleQuestion.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleQuestion)
        
        imageSwipe.image = UIImage(named: "swipeCard")
        imageSwipe.layer.masksToBounds = true
        imageSwipe.contentMode = .scaleAspectFill
        imageSwipe.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageSwipe)
        
        titleWord.text = "Word"
        titleWord.textColor = .black
        titleWord.numberOfLines = 0
        titleWord.textAlignment = .center
        titleWord.isHidden = true
        titleWord.font = UIFont(name: "NotoSans-Bold", size: 32)
        titleWord.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleWord)
        
        

        NSLayoutConstraint.activate([
            titleGame.topAnchor.constraint(equalTo: view.topAnchor, constant: 170),
            titleGame.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            cardStack.topAnchor.constraint(equalTo: titleGame.bottomAnchor, constant: 60),
            cardStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 47),
            cardStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -47),
            cardStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardStack.heightAnchor.constraint(equalToConstant: 274),
            
            subTitleGame.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            subTitleGame.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            titleQuestion.topAnchor.constraint(equalTo: cardStack.topAnchor, constant: 24),
            titleQuestion.centerXAnchor.constraint(equalTo: cardStack.centerXAnchor),
            
            imageSwipe.centerXAnchor.constraint(equalTo: cardStack.centerXAnchor),
            imageSwipe.centerYAnchor.constraint(equalTo: cardStack.centerYAnchor),
            
            titleWord.centerXAnchor.constraint(equalTo: cardStack.centerXAnchor),
            titleWord.centerYAnchor.constraint(equalTo: cardStack.centerYAnchor),
        ])
    }
    
    private func setupNavBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        let titleLabel = UILabel()
        titleLabel.text = "Round 1/3"
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "NotoSans-SemiBold", size: 16)
        navigationItem.titleView = titleLabel

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundImage = UIImage(named: "navbar")
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    // MARK: SwipeCardStackDataSource
    
    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
        let card = SwipeCard()
        card.content = UIImageView(image: sampleCards[index % sampleCards.count])
        return card
    }
    
    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
        return sampleCards.count + 50
    }
    
    // MARK: SwipeCardStackDelegate
    
    func cardStack(_ cardStack: SwipeCardStack, didSelectCardAt index: Int) {
        print("Card selected")
    }
    
    func cardStack(_ cardStack: SwipeCardStack, didSwipeCardAt index: Int, with direction: SwipeDirection) {
        if index == 0 {
            imageSwipe.isHidden = true
            titleQuestion.isHidden = true
            
            titleWord.isHidden = false
        }
        
        if index < words.count {
            titleWord.text = words[index]
        } else {
            titleWord.text = "No more words"
        }
        
        print("Card swiped")
    }
    
    func cardStack(_ cardStack: SwipeCardStack, didUndoCardAt index: Int, from direction: SwipeDirection) {
        print("Card undo")
    }
    
    func didSwipeAllCards(_ cardStack: SwipeCardStack) {
        print("All cards swiped")
    }
}
