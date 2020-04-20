//
//  WeatherStruct.swift
//  AppleWeatherApp
//
//  Created by Natalia on 15.04.2020.
//  Copyright © 2020 Natalia. All rights reserved.
//

import Foundation

struct AllWeatherModel: Codable {
    var name: String
    var main: MainModel
    var weather: [WeatherModel]
    
    func viewModel() -> WeatherViewModel {
        let nameVal = name
        let tempVal = main.temp
        let feelsLikeVal = main.feelsLike
        let iconVal = weather[0].icon
        
        let tempCelsiusVal = Int(round(tempVal - 273.15))
        let feelsLikeCelsiusVal = Int(round(feelsLikeVal - 273.15))
        
        let obj = WeatherViewModel(name: nameVal, tempCelsius: String(tempCelsiusVal), feelsLikeCelsius: String(feelsLikeCelsiusVal), icon: iconVal)
        return obj
    }
}

struct WeatherViewModel: Codable {
    var name: String
    var tempCelsius: String
    var feelsLikeCelsius: String
    var icon: String
}

struct MainModel: Codable {
    var temp: Double
    var feelsLike: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
    }
}

struct WeatherModel: Codable {
    var icon: String
}
