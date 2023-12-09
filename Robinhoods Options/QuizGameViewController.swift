//
//  QuizGameViewController.swift
//  Robinhoods Options
//
//  Created by Ravil on 09.12.2023.
//

import UIKit
import Shuffle

class QuizGameViewController: UIViewController, SwipeCardStackDataSource, SwipeCardStackDelegate {

    var guessedCardsCount = 0
    var teamNames: [(name: String, guessedCount: Int)] = []
    var wordsGuessed: [Bool] = Array(repeating: false, count: 50)
    
    var currentTeamIndex = 0
    var cardStack = SwipeCardStack()
    let subTitleGame = UILabel()
    let titleQuestion = UILabel()
    let titleAmount = UILabel()
    let imageSwipe = UIImageView()
    let titleWord = UILabel()
    
    let buttonFirstAnswer = UIButton()
    let buttonSecondAnswer = UIButton()
    let buttonThirdAnswer = UIButton()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        buttonFirstAnswer.layer.cornerRadius = 30
        buttonSecondAnswer.layer.cornerRadius = 30
        buttonThirdAnswer.layer.cornerRadius = 30
    }
    
    private func setupUI() {
        cardStack.dataSource = self
        cardStack.delegate = self
        cardStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cardStack)
        
        subTitleGame.text = "You will answer the questions in turn, the game \nconsists of 30 questions. The winner will be the player \nwith the most correct answers."
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
        
        titleAmount.text = "Question 1/10"
        titleAmount.textColor = .black
        titleAmount.alpha = 0.50
        titleAmount.numberOfLines = 0
        titleAmount.isHidden = true
        titleAmount.textAlignment = .center
        titleAmount.font = UIFont(name: "NotoSans-SemiBold", size: 16)
        titleAmount.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleAmount)
        
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
        
        buttonFirstAnswer.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)

        buttonSecondAnswer.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)

        buttonThirdAnswer.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        
        buttonFirstAnswer.setTitle("1 answer", for: .normal)
        buttonFirstAnswer.setTitleColor(.black, for: .normal)
        buttonFirstAnswer.titleLabel?.font = UIFont(name: "NotoSans-Medium", size: 16)
        buttonFirstAnswer.contentHorizontalAlignment = .left
        buttonFirstAnswer.layer.cornerRadius = 10
        buttonFirstAnswer.backgroundColor = .white
        buttonFirstAnswer.titleLabel?.numberOfLines = 0
        buttonFirstAnswer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonFirstAnswer)
        
        buttonSecondAnswer.setTitle("2 answer", for: .normal)
        buttonSecondAnswer.setTitleColor(.black, for: .normal)
        buttonSecondAnswer.titleLabel?.font = UIFont(name: "NotoSans-Medium", size: 16)
        buttonSecondAnswer.contentHorizontalAlignment = .left
        buttonSecondAnswer.layer.cornerRadius = 10
        buttonSecondAnswer.backgroundColor = .white
        buttonSecondAnswer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonSecondAnswer)
        
        buttonThirdAnswer.setTitle("3 answer", for: .normal)
        buttonThirdAnswer.setTitleColor(.black, for: .normal)
        buttonThirdAnswer.titleLabel?.font = UIFont(name: "NotoSans-Medium", size: 16)
        buttonThirdAnswer.contentHorizontalAlignment = .left
        buttonThirdAnswer.layer.cornerRadius = 10
        buttonThirdAnswer.backgroundColor = .white
        buttonThirdAnswer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonThirdAnswer)

        NSLayoutConstraint.activate([
            cardStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
            cardStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 47),
            cardStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -47),
            cardStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardStack.heightAnchor.constraint(equalToConstant: 274),
            
            subTitleGame.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            subTitleGame.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            titleQuestion.topAnchor.constraint(equalTo: cardStack.topAnchor, constant: 24),
            titleQuestion.centerXAnchor.constraint(equalTo: cardStack.centerXAnchor),
            
            titleAmount.topAnchor.constraint(equalTo: cardStack.topAnchor, constant: 24),
            titleAmount.centerXAnchor.constraint(equalTo: cardStack.centerXAnchor),
            
            imageSwipe.centerXAnchor.constraint(equalTo: cardStack.centerXAnchor),
            imageSwipe.centerYAnchor.constraint(equalTo: cardStack.centerYAnchor),
            
            titleWord.centerXAnchor.constraint(equalTo: cardStack.centerXAnchor),
            titleWord.centerYAnchor.constraint(equalTo: cardStack.centerYAnchor),
            
            buttonFirstAnswer.bottomAnchor.constraint(equalTo: buttonSecondAnswer.topAnchor, constant: -16),
            buttonFirstAnswer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonFirstAnswer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            buttonFirstAnswer.heightAnchor.constraint(equalToConstant: 98),
            
            buttonSecondAnswer.bottomAnchor.constraint(equalTo: buttonThirdAnswer.topAnchor, constant: -16),
            buttonSecondAnswer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonSecondAnswer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            buttonSecondAnswer.heightAnchor.constraint(equalToConstant: 98),
            
            buttonThirdAnswer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -47),
            buttonThirdAnswer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonThirdAnswer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            buttonThirdAnswer.heightAnchor.constraint(equalToConstant: 98),
        ])
    }
    
    private func setupNavBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        let titleLabel = UILabel()
        titleLabel.text = "Quiz"
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
            subTitleGame.isHidden = true
            titleWord.isHidden = false
            titleAmount.isHidden = false
        }

        if index < words.count - 1 {
            titleWord.text = words[index + 1]
        } else {
            titleWord.text = "No more words"
        }

        let currentAmount = index + 1
        titleAmount.text = "\(currentAmount)/\(words.count)"

        if direction == .right {
            guessedCardsCount += 1
            wordsGuessed[index] = true
        } else if direction == .left {
            guessedCardsCount = max(guessedCardsCount - 1, 0)  // Убедитесь, что счетчик не уйдет в минус
            wordsGuessed[index] = false
        }

        print("Guessed Cards Count: \(guessedCardsCount)")
    }

    
    func cardStack(_ cardStack: SwipeCardStack, didUndoCardAt index: Int, from direction: SwipeDirection) {
        print("Card undo")
    }
    
    func didSwipeAllCards(_ cardStack: SwipeCardStack) {
        print("All cards swiped")
    }
    
    @objc private func closeButtonTapped() {
        cardStack.swipe(.left, animated: true)
    }
    
    @objc private func correctButtonTapped() {
        cardStack.swipe(.right, animated: true)
    }
}
