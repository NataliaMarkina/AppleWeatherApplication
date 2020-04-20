//
//  ViewController.swift
//  AppleWeatherApp
//
//  Created by Natalia on 14.04.2020.
//  Copyright © 2020 Natalia. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    
    var currentManager: LocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.nameLabel.text = ""
        self.tempLabel.text = ""
        self.feelsLikeLabel.text = ""
        
        currentManager = LocationManager(location: CLLocationManager(), delegate: self)
        currentManager?.getPermission()
    }
    
    @IBAction func updateWeather(_ sender: UIButton) {
        if let last = currentManager?.getLastLocation() {
            locationUpdated(lat: last.0, lon: last.1)
        }
    }
    
    func getInformation(lat: Double, lon: Double) {
        ApiManager.shared.getWeather(lat: lat, lon: lon, closure: {(weatherModel: WeatherViewModel) -> Void in
            DispatchQueue.main.async{
                self.nameLabel.text = weatherModel.name
                self.tempLabel.text = weatherModel.tempCelsius
                self.feelsLikeLabel.text = weatherModel.feelsLikeCelsius
                ApiManager.shared.getIcon(id: weatherModel.icon, closure: {(image: UIImage) -> Void in
                    DispatchQueue.main.async{
                        self.imageView.image = image
                    }
                })
            }
        })
    }
}

extension ViewController: OurLocationManagerDelegate {
    func locationUpdated(lat: Double, lon: Double) {
        getInformation(lat: lat, lon: lon)
    }
}

