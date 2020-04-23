//
//  Weather+CoreDataClass.swift
//  AppleWeatherApp
//
//  Created by Natalia on 22.04.2020.
//  Copyright © 2020 Natalia. All rights reserved.
//
//

import Foundation
import CoreData


public class Weather: NSManagedObject {
    convenience init() {
        let context = CoreDataManager.instance.persistentContainer.viewContext
        
        // Описание сущности
        let entity = NSEntityDescription.entity(forEntityName: "Weather", in: context)
        
        // Создание нового объекта
        self.init(entity: entity!, insertInto: context)
    }
}
