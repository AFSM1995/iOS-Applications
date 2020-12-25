//
//  CurrencyModel.swift
//  ByteCoin
//
//  Created by Álvaro Santillan on 12/24/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct ExchangeModel {
    let rate: Double
    let quoteCurrency: String
    
    var rateAsString: String {
        var rateAsString = rate * 100
        rateAsString.round()
        return String(rateAsString / 100)
    }
}
