//
//  currencyData.swift
//  ByteCoin
//
//  Created by Álvaro Santillan on 12/24/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct ExchangeData: Codable {
    let rate: Double
    let asset_id_quote: String
}

//{
//  "time": "2020-12-25T00:44:14.6776910Z",
//  "asset_id_base": "BTC",
//  "asset_id_quote": "USD",
//  "rate": 23646.550676266663863139647794
//}
