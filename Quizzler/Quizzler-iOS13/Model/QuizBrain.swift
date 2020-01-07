//
//  QuizBrain.swift
//  Quizzler-iOS13
//
//  Created by Álvaro Santillan on 1/6/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct QuizBrain {
    
    let quiz = [
        Questions(q: "Which is the largest organ in the human body?", a: ["Heart", "Skin", "Large Intestine"], ca: "Skin"),
        Questions(q: "Five dollars is worth how many nickels?", a: ["25", "50", "100"], ca: "100"),
        Questions(q: "What do the letters in the GMT time zone stand for?", a: ["Global Meridian Time", "Greenwich Mean Time", "General Median Time"], ca: "Greenwich Mean Time"),
        Questions(q: "What is the French word for 'hat'?", a: ["Chapeau", "Écharpe", "Bonnet"], ca: "Chapeau"),
        Questions(q: "In past times, what would a gentleman keep in his fob pocket?", a: ["Notebook", "Handkerchief", "Watch"], ca: "Watch"),
        Questions(q: "How would one say goodbye in Spanish?", a: ["Au Revoir", "Adiós", "Salir"], ca: "Adiós"),
        Questions(q: "Which of these colours is NOT featured in the logo for Google?", a: ["Green", "Orange", "Blue"], ca: "Orange"),
        Questions(q: "What alcoholic drink is made from molasses?", a: ["Rum", "Whisky", "Gin"], ca: "Rum"),
        Questions(q: "What type of animal was Harambe?", a: ["Panda", "Gorilla", "Crocodile"], ca: "Gorilla"),
        Questions(q: "Where is Tasmania located?", a: ["Indonesia", "Australia", "Scotland"], ca: "Australia")
        ]

        var currentQuizQuestion = 0
        var currentScore = 0

        mutating func checkAnswer(_ userAnswer: String) -> Bool {
            if userAnswer == quiz[currentQuizQuestion].correctAnswer {
                currentScore += 1
                return true
            } else {
                return false
            }
        }
    
        func getQuestionText() -> String {
            return quiz[currentQuizQuestion].question
        }
    
    func getQuestionOptions(buttonID: Int) -> String {
        if buttonID == 1 {
            return quiz[currentQuizQuestion].answer[0]
        } else if buttonID == 2 {
            return quiz[currentQuizQuestion].answer[1]
        } else {
            return quiz[currentQuizQuestion].answer[2]
        }
    }
        
        func getProgress() -> Float {
            let progress = Float(currentQuizQuestion + 1) / Float(quiz.count)
            return progress
        }
    
    func getScore() -> Int {
        return currentScore
    }
        
        mutating func nextQuestion() {
            if (currentQuizQuestion + 1 < quiz.count) {
                currentQuizQuestion += 1
            } else {
                currentQuizQuestion = 0
                currentScore = 0
            }
        }
}
