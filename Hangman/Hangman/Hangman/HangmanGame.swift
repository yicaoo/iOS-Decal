//
//  HangmanGame.swift
//  Hangman
//
//  Created by Yi Cao on 10/9/18.
//  Copyright © 2018 iOS DeCal. All rights reserved.
//

import Foundation

class HangmanGame {
    private (set) var gamePhrase = ""
    private (set) var progressPhrase = ""
    private (set) var incorrectLetters = ""
    
    func checkGuess(forLetter letter: Character) {
        if gamePhrase.contains(letter) && !progressPhrase.contains(letter) {
            updateProgressPhrase(forLetter: letter)
        } else {
            if !incorrectLetters.contains(letter) {
                incorrectLetters.append(letter)
                if incorrectLetters.count >= HangmanGameConstant.numGuessesTotal {
            NotificationCenter.default.post(name: .gameOver, object: self)
                }
            }
        }
    }
    
    private func updateProgressPhrase(forLetter letter: Character) {
        var updateString = ""
        for (index, char) in gamePhrase.enumerated() {
            if char == letter {
                updateString.append(char)
            } else {
                let charIndex = progressPhrase.index(progressPhrase.startIndex, offsetBy: index)
                updateString.append(progressPhrase[charIndex])
            }
        }
        progressPhrase = updateString
        if !progressPhrase.contains(HangmanGameConstant.hide
            ) {
            NotificationCenter.default.post(name: .gameWin, object: self)
        }
    }
    
    private func setPhrase() {
        let hangmanPhrases = HangmanPhrases()
        // Generate a random phrase for the user to guess
        gamePhrase = hangmanPhrases.getRandomPhrase()
        for char in gamePhrase {
            if char == HangmanGameConstant.space {
                progressPhrase.append(char)
            } else {
                progressPhrase += HangmanGameConstant.hide
            }
        }
    }
    
    func restart() {
        progressPhrase = ""
        incorrectLetters = ""
        setPhrase()
    }
    
    init() {
        setPhrase()
    }
    
    private struct HangmanGameConstant {
        static let  hide = "-"
        static let space: Character = " "
        static let numGuessesTotal = 6
    }
}

extension Notification.Name {
    static let gameOver = NSNotification.Name(rawValue: "gameOver")
    static let gameWin = NSNotification.Name(rawValue: "gameWin")
}
