//
//  CurrentWeather.swift
//  Project
//
//  Created by Onur ILTAN on 02/01/15.
//  Copyright (c) 2015 Onur ILTAN. All rights reserved.
//

import Foundation
import UIKit
struct CurrentWeather {
    
    var temperature: Int
    var humidity: Double
    var summary: String
    var icon: UIImage?
    var pressure:Int
    var windSpeed:Int
    var location:String
    init(weatherDictionary: NSDictionary) {
        let currentWeather = weatherDictionary["currently"] as NSDictionary
        let mainWeather = weatherDictionary as NSDictionary
        
        temperature = currentWeather["temperature"] as Int
        humidity = currentWeather["humidity"] as Double
        summary = currentWeather["summary"] as String
        pressure = currentWeather["pressure"] as Int
        windSpeed = currentWeather["windSpeed"] as Int
        location = mainWeather["timezone"] as String
        
        let iconString = currentWeather["icon"] as String
        icon = weatherIconFromString(iconString)

        
    }
    
        func weatherIconFromString(stringIcon: String) -> UIImage {
        var imageName: String
        
        switch stringIcon {
        case "clear-day":
            imageName = "clear-day"
        case "clear-night":
            imageName = "clear-night"
        case "rain":
            imageName = "rain"
        case "snow":
            imageName = "snow"
        case "sleet":
            imageName = "sleet"
        case "wind":
            imageName = "wind"
        case "fog":
            imageName = "fog"
        case "cloudy":
            imageName = "cloudy"
        case "partly-cloudy-day":
            imageName = "partly-cloudy"
        case "partly-cloudy-night":
            imageName = "cloudy-night"
        default:
            imageName = "default"
        }
        
        var iconName = UIImage(named: imageName)
        return iconName!
    }

    
}