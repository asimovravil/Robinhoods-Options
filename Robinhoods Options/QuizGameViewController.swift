//
//  QuizGameViewController.swift
//  Robinhoods Options
//
//  Created by Ravil on 09.12.2023.
//

import UIKit
import Shuffle

struct QuizQuestion {
    let question: String
    let answers: [String]
    let correctAnswerIndex: Int
}

class QuizGameViewController: UIViewController, SwipeCardStackDataSource, SwipeCardStackDelegate {
    
    var guessedCardsCount = 0
    var wordsGuessed: [Bool] = Array(repeating: false, count: 50)
    var playerNames: [(String, Int)] = []
    
    var currentPlayerIndex = 0
    var cardStack = SwipeCardStack()
    let subTitleGame = UILabel()
    let titleQuestion = UILabel()
    let titleAmount = UILabel()
    let imageSwipe = UIImageView()
    let titleWord = UILabel()
    
    let buttonFirstAnswer = UIButton()
    let buttonSecondAnswer = UIButton()
    let buttonThirdAnswer = UIButton()
    
    var quiz: [QuizQuestion] = [
        QuizQuestion(question: "What is diversification in finance?",
                     answers: ["Spreading investments across various financial instruments", "Focusing all investments in one stock", "Buying and selling stocks frequently"],
                     correctAnswerIndex: 0),
        
        QuizQuestion(question: "What does 'bull market' signify?",
                     answers: ["A declining market trend", "A stable market trend", "A rising market trend"],
                     correctAnswerIndex: 2),
        
        QuizQuestion(question: "What is a 'bear market'?",
                     answers: ["A market showing financial growth", "A market experiencing decline", "A market with stable prices"],
                     correctAnswerIndex: 1),
        
        QuizQuestion(question: "What is a 'blue chip' stock?",
                     answers: ["A high-risk stock", "A stock from new companies", "A stock from nationally recognized companies with stable earnings"],
                     correctAnswerIndex: 2),
        
        QuizQuestion(question: "What does 'IPO' stand for?",
                     answers: ["Initial Public Offering", "Internal Private Operation", "Immediate Profit Opportunity"],
                     correctAnswerIndex: 0),
        
        QuizQuestion(question: "What is 'compound interest'?",
                     answers: ["Interest on the principal amount only", "Interest on both principal and accrued interest", "A fixed interest rate for the life of the investment"],
                     correctAnswerIndex: 1),
        
        QuizQuestion(question: "What does 'liquidity' mean in finance?",
                     answers: ["The ease of turning assets into cash", "The profitability of a company", "The volume of stock traded on the market"],
                     correctAnswerIndex: 0),
        
        QuizQuestion(question: "What is a 'bond'?",
                     answers: ["A loan to a corporation or government", "A type of stock", "An insurance policy for investments"],
                     correctAnswerIndex: 0),
        
        QuizQuestion(question: "What is 'market capitalization'?",
                     answers: ["The total value of a company's outstanding shares", "The total debts of a company", "The yearly profit of a company"],
                     correctAnswerIndex: 0),
        
        QuizQuestion(question: "What is a 'mutual fund'?",
                     answers: ["A personal savings account", "An investment vehicle made up of a pool of funds from many investors", "A government-issued retirement fund"],
                     correctAnswerIndex: 1)
    ]
    
    var currentQuestionIndex = 0
    
    var sampleCards: [UIImage] = [
        UIImage(named: "card")
    ].compactMap { $0 }
    var cards: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AppColor.backgroundLightGray.uiColor
        setupUI()
        setupNavBar()
        updateUIForCurrentQuestion()
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
    
    private func updateUIForCurrentQuestion() {
        let currentQuestion = quiz[currentQuestionIndex]
        titleWord.text = currentQuestion.question
        buttonFirstAnswer.setTitle(currentQuestion.answers[0], for: .normal)
        buttonSecondAnswer.setTitle(currentQuestion.answers[1], for: .normal)
        buttonThirdAnswer.setTitle(currentQuestion.answers[2], for: .normal)
        
        titleAmount.text = "Question \(currentQuestionIndex + 1)/\(quiz.count)"
    }
    
    @objc private func answerButtonTapped(_ sender: UIButton) {
        let correctAnswerIndex = quiz[currentQuestionIndex].correctAnswerIndex
        let isCorrectAnswer = sender.tag == correctAnswerIndex
        
        if isCorrectAnswer {
            playerNames[currentPlayerIndex].1 += 1
            sender.backgroundColor = .green
        } else {
            sender.backgroundColor = .red
        }
        
        disableButtons()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.currentPlayerIndex = (self.currentPlayerIndex + 1) % self.playerNames.count
            self.currentQuestionIndex += 1
            if self.currentQuestionIndex < self.quiz.count {
                self.updateUIForCurrentQuestion()
                self.resetButtonColors()
            } else {
                let quizLeadVC = QuizLeaderboardViewController()
                quizLeadVC.playerScores = self.playerNames
                quizLeadVC.navigationItem.hidesBackButton = true
                self.navigationController?.pushViewController(quizLeadVC, animated: true)
            }
        }
    }
    
    private func disableButtons() {
        buttonFirstAnswer.isEnabled = false
        buttonSecondAnswer.isEnabled = false
        buttonThirdAnswer.isEnabled = false
    }
    
    private func resetButtonColors() {
        buttonFirstAnswer.backgroundColor = .white
        buttonSecondAnswer.backgroundColor = .white
        buttonThirdAnswer.backgroundColor = .white
        
        // Включаем кнопки обратно
        buttonFirstAnswer.isEnabled = true
        buttonSecondAnswer.isEnabled = true
        buttonThirdAnswer.isEnabled = true
    }
    
    private func setupUI() {
        let arrowImage = UIImage(systemName: "arrow.right", withConfiguration: UIImage.SymbolConfiguration(weight: .medium))
        
        let arrowImageView1 = UIImageView(image: arrowImage)
        let arrowImageView2 = UIImageView(image: arrowImage)
        let arrowImageView3 = UIImageView(image: arrowImage)
        
        arrowImageView1.tintColor = .gray
        arrowImageView2.tintColor = .gray
        arrowImageView3.tintColor = .gray
        
        buttonFirstAnswer.addSubview(arrowImageView1)
        buttonSecondAnswer.addSubview(arrowImageView2)
        buttonThirdAnswer.addSubview(arrowImageView3)
        arrowImageView1.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView2.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView3.translatesAutoresizingMaskIntoConstraints = false
        
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
        titleWord.font = UIFont(name: "NotoSans-Bold", size: 24)
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
        
        buttonFirstAnswer.addTarget(self, action: #selector(answerButtonTapped), for: .touchUpInside)
        buttonSecondAnswer.addTarget(self, action: #selector(answerButtonTapped), for: .touchUpInside)
        buttonThirdAnswer.addTarget(self, action: #selector(answerButtonTapped), for: .touchUpInside)
        
        buttonFirstAnswer.isHidden = true
        buttonSecondAnswer.isHidden = true
        buttonThirdAnswer.isHidden = true
        
        NSLayoutConstraint.activate([
            arrowImageView1.centerYAnchor.constraint(equalTo: buttonFirstAnswer.centerYAnchor),
            arrowImageView1.trailingAnchor.constraint(equalTo: buttonFirstAnswer.trailingAnchor, constant: -20),
            arrowImageView1.widthAnchor.constraint(equalToConstant: 24),
            arrowImageView1.heightAnchor.constraint(equalToConstant: 24),
            
            arrowImageView2.centerYAnchor.constraint(equalTo: buttonSecondAnswer.centerYAnchor),
            arrowImageView2.trailingAnchor.constraint(equalTo: buttonSecondAnswer.trailingAnchor, constant: -20),
            arrowImageView2.widthAnchor.constraint(equalToConstant: 24),
            arrowImageView2.heightAnchor.constraint(equalToConstant: 24),
            
            arrowImageView3.centerYAnchor.constraint(equalTo: buttonThirdAnswer.centerYAnchor),
            arrowImageView3.trailingAnchor.constraint(equalTo: buttonThirdAnswer.trailingAnchor, constant: -20),
            arrowImageView3.widthAnchor.constraint(equalToConstant: 24),
            arrowImageView3.heightAnchor.constraint(equalToConstant: 24),
            
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
            titleWord.leadingAnchor.constraint(equalTo: cardStack.leadingAnchor, constant: 24),
            titleWord.trailingAnchor.constraint(equalTo: cardStack.trailingAnchor, constant: -24),
            
            buttonFirstAnswer.bottomAnchor.constraint(equalTo: buttonSecondAnswer.topAnchor, constant: -16),
            buttonFirstAnswer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonFirstAnswer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            buttonSecondAnswer.bottomAnchor.constraint(equalTo: buttonThirdAnswer.topAnchor, constant: -16),
            buttonSecondAnswer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonSecondAnswer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            
            buttonThirdAnswer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -47),
            buttonThirdAnswer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonThirdAnswer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

        ])
        
        if UIScreen.main.bounds.size.height >= 812 {
            NSLayoutConstraint.activate([
                cardStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
                buttonFirstAnswer.heightAnchor.constraint(equalToConstant: 98),
                buttonSecondAnswer.heightAnchor.constraint(equalToConstant: 98),
                buttonThirdAnswer.heightAnchor.constraint(equalToConstant: 98),
            ])
        } else {
            NSLayoutConstraint.activate([
                cardStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
                buttonFirstAnswer.heightAnchor.constraint(equalToConstant: 58),
                buttonSecondAnswer.heightAnchor.constraint(equalToConstant: 58),
                buttonThirdAnswer.heightAnchor.constraint(equalToConstant: 58),
            ])
        }
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
        return 11
    }
    
    // MARK: SwipeCardStackDelegate
    
    func cardStack(_ cardStack: SwipeCardStack, didSelectCardAt index: Int) {
        print("Card selected")
    }
    
    func cardStack(_ cardStack: SwipeCardStack, didSwipeCardAt index: Int, with direction: SwipeDirection) {
        if index == 0 {
            buttonFirstAnswer.isHidden = false
            buttonSecondAnswer.isHidden = false
            buttonThirdAnswer.isHidden = false
            imageSwipe.isHidden = true
            titleQuestion.isHidden = true
            titleAmount.isHidden = false
            titleWord.isHidden = false
            subTitleGame.isHidden = true
        } else {
            currentQuestionIndex += 1
            if currentQuestionIndex < quiz.count {
                updateUIForCurrentQuestion()
                resetButtonColors()
            } else {
                let quizLeadVC = QuizLeaderboardViewController()
                quizLeadVC.playerScores = self.playerNames
                quizLeadVC.navigationItem.hidesBackButton = true
                self.navigationController?.pushViewController(quizLeadVC, animated: true)
            }
        }
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
