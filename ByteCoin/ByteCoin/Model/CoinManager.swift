//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol ExchangeManagerDelegate {
    func didUpdateExchangeRate(exchange: ExchangeModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    var delegate: ExchangeManagerDelegate?
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "7AA4D0C0-D553-40EA-A7C8-406ED05E4B14"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        // 1. Create a URl
        if let url = URL(string: urlString) {
            // 2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            // 3. Give the session a task
            let task = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let exchange = self.parseData(safeData) {
                        self.delegate?.didUpdateExchangeRate(exchange: exchange)
                    }
                }
            })
            
            // 4. Start the task
            task.resume()
        }
    }
    
    // Create a decoder and use it to decode the API data.
    func parseData(_ exchangeData: Data) -> ExchangeModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(ExchangeData.self, from: exchangeData)
            let rate = decodedData.rate
            let quoteCurrency = decodedData.asset_id_quote
            let exchange = ExchangeModel(rate: rate, quoteCurrency: quoteCurrency)
            return exchange
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}


//https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=7AA4D0C0-D553-40EA-A7C8-406ED05E4B14
