//
//  WeeklyWeather.swift
//  Project
//
//  Created by student7 on 06/01/15.
//  Copyright (c) 2015 Onur ILTAN. All rights reserved.
//

import Foundation
import UIKit
struct WeeklyWeather {
    
   
    //var temperature: Int
    
    //var summary: String
    var mondayIcon: UIImage?
    var tuesdayIcon: UIImage?
    var wednesdayIcon: UIImage?
    var thursdayIcon: UIImage?
    var fridayIcon: UIImage?
    var saturdayIcon: UIImage?
    var sundayIcon: UIImage?
    var summaryMonday:String?
    var summaryTuesday:String?
    var summaryWednesday:String?
    var summaryThursday:String?
    var summaryFriday:String?
    var summarySaturday:String?
    var summarySunday:String?


    
    init(weatherDictionary: NSArray) {
        
        let monday = weatherDictionary[0]["icon"] as String
        mondayIcon = weatherIconFromString(monday)
        summaryMonday = weatherDictionary[0]["summary"] as String
        
        let tuesday = weatherDictionary[1]["icon"] as String
        tuesdayIcon = weatherIconFromString(tuesday)
        summaryTuesday = weatherDictionary[1]["summary"] as String

        
        let wednesday = weatherDictionary[2]["icon"] as String
        wednesdayIcon = weatherIconFromString(wednesday)
        summaryWednesday = weatherDictionary[2]["summary"] as String

        let thursday = weatherDictionary[3]["icon"] as String
        thursdayIcon = weatherIconFromString(thursday)
        summaryThursday = weatherDictionary[3]["summary"] as String

        let friday = weatherDictionary[4]["icon"] as String
        fridayIcon = weatherIconFromString(friday)
        summaryFriday = weatherDictionary[4]["summary"] as String

        let saturday = weatherDictionary[5]["icon"] as String
        saturdayIcon = weatherIconFromString(saturday)
        summarySaturday = weatherDictionary[5]["summary"] as String

        let sunday = weatherDictionary[6]["icon"] as String
        sundayIcon = weatherIconFromString(sunday)
        summarySunday = weatherDictionary[6]["summary"] as String

    
        
        
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
