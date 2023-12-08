//
//  AliasGameViewController.swift
//  Robinhoods Options
//
//  Created by Ravil on 08.12.2023.
//

import UIKit
import Shuffle

class AliasGameViewController: UIViewController, SwipeCardStackDataSource, SwipeCardStackDelegate {

    var guessedCardsCount = 0
    private var countdownTimer: Timer?
    private var remainingSeconds: Int = 60
    var teamNames: [String] = []
    
    let titleGame = UILabel()
    var cardStack = SwipeCardStack()
    let subTitleGame = UILabel()
    let titleQuestion = UILabel()
    let titleAmount = UILabel()
    let imageSwipe = UIImageView()
    let titleWord = UILabel()
    let buttonClose = UIButton()
    let buttonCorrect = UIButton()
    private var countdownLabel: UILabel!
    
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
        startTimer()
        
        if let teamName = teamNames.first {
            titleGame.text = "\(teamName)"
        }
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
        
        titleAmount.text = "1/50"
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
        
        buttonClose.setImage(UIImage(named: "close"), for: .normal)
        buttonClose.isHidden = true
        buttonClose.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonClose)
        
        buttonCorrect.setImage(UIImage(named: "correct"), for: .normal)
        buttonCorrect.isHidden = true
        buttonCorrect.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonCorrect)
        
        buttonClose.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        buttonCorrect.addTarget(self, action: #selector(correctButtonTapped), for: .touchUpInside)

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
            
            titleAmount.topAnchor.constraint(equalTo: cardStack.topAnchor, constant: 24),
            titleAmount.centerXAnchor.constraint(equalTo: cardStack.centerXAnchor),
            
            imageSwipe.centerXAnchor.constraint(equalTo: cardStack.centerXAnchor),
            imageSwipe.centerYAnchor.constraint(equalTo: cardStack.centerYAnchor),
            
            titleWord.centerXAnchor.constraint(equalTo: cardStack.centerXAnchor),
            titleWord.centerYAnchor.constraint(equalTo: cardStack.centerYAnchor),
            
            buttonClose.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            buttonClose.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -30),

            buttonCorrect.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            buttonCorrect.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 30),
        ])
    }
    
    private func setupNavBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        let titleLabel = UILabel()
        titleLabel.text = "Round 1/3"
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "NotoSans-SemiBold", size: 16)
        navigationItem.titleView = titleLabel

        let countdownStackView = UIStackView()
        countdownStackView.axis = .horizontal
        countdownStackView.alignment = .center
        countdownStackView.spacing = 4

        countdownLabel = UILabel()
        countdownLabel.text = "60"
        countdownLabel.textColor = .black
        countdownLabel.font = UIFont(name: "NotoSans-SemiBold", size: 16)

        let clockImageView = UIImageView(image: UIImage(named: "clockBar"))
        clockImageView.contentMode = .scaleAspectFit

        countdownStackView.addArrangedSubview(clockImageView)
        countdownStackView.addArrangedSubview(countdownLabel)

        let countdownBarItem = UIBarButtonItem(customView: countdownStackView)
        navigationItem.rightBarButtonItem = countdownBarItem

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundImage = UIImage(named: "navbar")
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }

    
    private func updateTimerLabel() {
        countdownLabel.text = "\(remainingSeconds)s"
    }
    
    private func startTimer() {
        countdownTimer?.invalidate() // Отменяем предыдущий таймер, если он уже был запущен
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.remainingSeconds > 0 {
                self.remainingSeconds -= 1
                self.updateTimerLabel()
            } else {
                // Таймер достиг нуля, выполните здесь необходимые действия
                self.countdownTimer?.invalidate() // Отменяем таймер
                self.printMessage(message: "Время истекло!")
            }
        }
    }

    // Просто выводит сообщение в консоль
    func printMessage(message: String) {
        print(message)
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
            buttonClose.isHidden = false
            buttonCorrect.isHidden = false
            titleWord.isHidden = false
            titleAmount.isHidden = false
            
            if direction == .left {
                guessedCardsCount += 1
            }
            
            if direction == .right {
                guessedCardsCount -= 1
            }
        }
        
        if index < words.count {
            titleWord.text = words[index]
        } else {
            titleWord.text = "No more words"
        }
        
        let currentAmount = index + 1
        titleAmount.text = "\(currentAmount)/\(words.count)"
        
        if direction == .left {
            guessedCardsCount -= 1
            print("Swiped left, guessedCardsCount decreased to \(guessedCardsCount)")
        }
        
        else if direction == .right {
            guessedCardsCount += 1
            print("Swiped right, guessedCardsCount increased to \(guessedCardsCount)")
        }
    }

    
    func cardStack(_ cardStack: SwipeCardStack, didUndoCardAt index: Int, from direction: SwipeDirection) {
        print("Card undo")
    }
    
    func didSwipeAllCards(_ cardStack: SwipeCardStack) {
        print("All cards swiped")
    }
    
    @objc private func closeButtonTapped() {
        guessedCardsCount -= 1
        cardStack.swipe(.left, animated: true)
    }
    
    @objc private func correctButtonTapped() {
        guessedCardsCount += 1
        cardStack.swipe(.right, animated: true)
    }
}
