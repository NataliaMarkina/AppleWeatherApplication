//
//  WeatherStruct.swift
//  AppleWeatherApp
//
//  Created by Natalia on 15.04.2020.
//  Copyright © 2020 Natalia. All rights reserved.
//

import Foundation

struct AllWeatherModel: Codable{
    var name: String
    var main: MainModel
    var weather: [WeatherModel]
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
