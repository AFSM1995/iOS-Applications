//
//  Questions.swift
//  Quizzler-iOS13
//
//  Created by Álvaro Santillan on 1/6/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct Questions {
    let question: String;
    let answer: [String];
    let correctAnswer: String;
    
    init(q: String, a: [String], ca: String) {
        question = q
        answer = a
        correctAnswer = ca
    }
}
