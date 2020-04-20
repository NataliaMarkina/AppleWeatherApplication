//
//  ApiManager.swift
//  AppleWeatherApp
//
//  Created by Natalia on 15.04.2020.
//  Copyright © 2020 Natalia. All rights reserved.
//

import Foundation
import UIKit

class ApiManager {
    static var shared = ApiManager()
    
    let urlApi = "http://api.openweathermap.org/data/2.5/weather"
    let appID = "e7b9dd9f41c3ac26eae9e94536c8075e"
    let urlImage = "http://openweathermap.org/img/wn/"
    
    func getWeather(lat: Double, lon: Double, closure: @escaping (WeatherViewModel) -> Void) {
        let session = URLSession.shared
        let url = URL(string: "\(urlApi)?lat=\(lat)&lon=\(lon)&appid=\(appID)")!
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            
            do {
                guard let dataValue = data else {return}
                let weatherObj = try JSONDecoder().decode(AllWeatherModel.self, from: dataValue)
                closure(weatherObj.viewModel)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    func getIcon(id: String, closure: @escaping (UIImage) -> Void) {
        let session = URLSession.shared
        let url = URL(string: "\(urlImage)\(id)@2x.png")!
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            
            guard let dataValue = data else {return}
            guard let image = UIImage(data: dataValue) else {return}
            closure(image)
        }
        
        task.resume()
    }
}
