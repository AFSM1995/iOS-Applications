//
//  WeatherData.swift
//  Clima
//
//  Created by Álvaro Santillan on 12/21/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

// Format API data using decodable structs.
struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
}
