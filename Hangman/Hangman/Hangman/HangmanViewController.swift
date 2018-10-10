//
//  HangmanViewController.swift
//  Hangman
//
//  Created by Yi Cao on 10/9/18.
//  Copyright © 2018 iOS DeCal. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {
     private lazy var game: HangmanGame = HangmanGame()
    @IBOutlet weak var hangmanProgress: UILabel!
    
    @IBOutlet weak var incorrectGuesses: UILabel!
    
    @IBOutlet weak var currentGuess: UILabel!
    private var gameOverObserver: NSObjectProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
        // observers to listen to model notification about game status
        gameOverObserver = NotificationCenter.default.addObserver(forName: .gameOver, object: nil, queue: OperationQueue.main) { (notification) in
            self.issueAlert(HangmanAlertConstant.loseMessage)
        }
        gameOverObserver = NotificationCenter.default.addObserver(forName: .gameWin, object: nil, queue: OperationQueue.main) { (notification) in
            self.issueAlert(HangmanAlertConstant.winMessage)
        }
    }
    
    @IBOutlet weak var hangmanImage: UIImageView!
    
    @IBAction func enterGuess(_ sender: UIButton) {
        if let letter = sender.titleLabel?.text {
            currentGuess.text = HangmanUIConstant.guess + letter
        }
    }
    
    @IBAction func makeGuess(_ sender: UIButton) {
        if let inputLetter = currentGuess.text {
            game.checkGuess(forLetter: inputLetter.last!)
            updateViewFromModel()
        }
    }
    
    @IBAction func restartGame(_ sender: UIButton) {
        restart()
    }
    
    private func restart() {
        currentGuess.text = HangmanUIConstant.guess
        game.restart()
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        hangmanProgress.text = game.progressPhrase
        incorrectGuesses.text = HangmanUIConstant.incorrect +  game.incorrectLetters
        let imageName = HangmanUIConstant.imageTitle + "\(game.incorrectLetters.count+1)"
        hangmanImage.image = UIImage(named: imageName)
        print(game.gamePhrase)
    }
    
    // generic helper function to pass winning and losing alerts
    private func issueAlert(_ message: String) {
        let alert = UIAlertController(title: HangmanAlertConstant.newGame, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: HangmanAlertConstant.startAction, style: .default, handler: {action in
            self.restart()
        }))
        self.present(alert, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        dismissObservers()
    }
    
    private func dismissObservers() {
        if let observer = self.gameOverObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    // -MARK: Constants
    private struct HangmanUIConstant {
        static let  guess = "Guess: "
        static let incorrect = "Incorrect Guesses: "
        static let imageTitle = "hangman"
    }
    private struct HangmanAlertConstant {
        static let newGame = "New Game"
        static let winMessage = "Congratuations! You won!"
        static let loseMessage = "Sorry! You lost!"
        static let startAction = "Start"
    }
}
