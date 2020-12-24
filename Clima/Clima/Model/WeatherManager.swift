//
//  WeatherManager.swift
//  Clima
//
//  Created by Álvaro Santillan on 12/20/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    var delegate: WeatherManagerDelegate?
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=fc571bc98df191e593421dd3e6d271fc&units=imperial"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchLiveWeather(lat: Int, lon: Int) {
//        api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
        let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
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
                    if let weather = self.parseData(safeData) {
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
            })
            
            // 4. Start the task
            task.resume()
        }
    }
    
    // Create a decoder and use it to decode the API weather data of type WeatherData.
    func parseData(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let conditionId = decodedData.weather[0].id
            let cityName = decodedData.name
            let temperature = decodedData.main.temp
            let weather = WeatherModel(conditionId: conditionId, temperature: temperature, cityName: cityName)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
