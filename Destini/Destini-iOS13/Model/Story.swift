//
//  Sotry.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct Story {
    
    let title: String
    let choice1: String
    let choice2: String
    let choice1Destiny: Int
    let choice2Destiny: Int
    
    init(t: String, c1: String, c1Destiny: Int, c2: String, c2Destiny: Int) {
        title = t
        choice1 = c1
        choice1Destiny = c1Destiny
        choice2 = c2
        choice2Destiny = c2Destiny
    }
}
