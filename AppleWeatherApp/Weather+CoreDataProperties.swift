//
//  Weather+CoreDataProperties.swift
//  AppleWeatherApp
//
//  Created by Natalia on 22.04.2020.
//  Copyright © 2020 Natalia. All rights reserved.
//
//

import Foundation
import CoreData


extension Weather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Weather> {
        return NSFetchRequest<Weather>(entityName: "Weather")
    }

    @NSManaged public var feelsLike: String?
    @NSManaged public var iconId: String?
    @NSManaged public var name: String?
    @NSManaged public var temp: String?

}
