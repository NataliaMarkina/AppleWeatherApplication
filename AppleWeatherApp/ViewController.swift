//
//  ViewController.swift
//  AppleWeatherApp
//
//  Created by Natalia on 14.04.2020.
//  Copyright © 2020 Natalia. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    
    @IBOutlet weak var celsiusLabel: UILabel!
    
    @IBOutlet weak var stack1: UIStackView!
    @IBOutlet weak var stack2: UIStackView!
    
    var currentManager: LocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.imageView.alpha = 0
        UIView.animate(withDuration: 2, delay: 1, options: .curveEaseOut, animations: { () -> Void in
            self.imageView.alpha = 1
        }, completion: nil)
        
        
        UIView.animate(withDuration: 1, delay: 1, options: .curveEaseOut, animations: { () -> Void in
            self.nameLabel.frame.origin.x = 300
            self.stack1.frame.origin.x = 400
            self.stack2.frame.origin.x = 400
        }, completion: nil)
        
        self.nameLabel.text = ""
        self.tempLabel.text = ""
        self.feelsLikeLabel.text = ""
        
        currentManager = LocationManager(location: CLLocationManager(), delegate: self)
        currentManager?.getPermission()
    }
    
    @IBAction func updateWeather(_ sender: UIButton) {
        if let last = currentManager?.getLastLocation() {
            let results = CoreDataManager.instance.getRequest()
            if results.count == 0 {
                locationUpdated(lat: last.0, lon: last.1)
            } else {
                let alert = UIAlertController(title: "Хотите обновить данные?", message: "Хотите обновить данные?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Да", style: .default, handler: {_ in
                    self.locationUpdated(lat: last.0, lon: last.1)
                }))
                alert.addAction(UIAlertAction(title: "Нет", style: .default, handler: {_ in
                    self.setOldData(results: results)
                }))
                present(alert, animated: true, completion: nil)
            }
            //locationUpdated(lat: last.0, lon: last.1)
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
    
    func setOldData(results: [Weather]) {
        DispatchQueue.main.async{
            self.nameLabel.text = results[0].name
            self.tempLabel.text = results[0].temp
            self.feelsLikeLabel.text = results[0].feelsLike
            ApiManager.shared.getIcon(id: results[0].iconId!, closure: {(image: UIImage) -> Void in
                DispatchQueue.main.async{
                    self.imageView.image = image
                }
            })
        }
    }
}

extension ViewController: OurLocationManagerDelegate {
    func locationUpdated(lat: Double, lon: Double) {
        getInformation(lat: lat, lon: lon)
    }
}

