//
//  WeeklyViewController.swift
//  Project
//
//  Created by student7 on 06/01/15.
//  Copyright (c) 2015 Onur ILTAN. All rights reserved.
//


import UIKit
import CoreLocation

class WeeklyViewController: UIViewController,CLLocationManagerDelegate {

    var dailyData:NSArray!
    
    @IBOutlet weak var mondayImage: UIImageView!
    @IBOutlet weak var tuesdayImage: UIImageView!
    @IBOutlet weak var wednesdayImage: UIImageView!
    @IBOutlet weak var thursdayImage: UIImageView!
    @IBOutlet weak var fridayImage: UIImageView!
    @IBOutlet weak var saturdayIamge: UIImageView!
    @IBOutlet weak var sundayImage: UIImageView!
    @IBOutlet weak var mondaySummary: UILabel!
    @IBOutlet weak var tuesdaySummary: UILabel!
    @IBOutlet weak var wednesdaySummary: UILabel!
    @IBOutlet weak var thursdaySummary: UILabel!
    @IBOutlet weak var fridaySummary: UILabel!
    @IBOutlet weak var SaturdaySummary: UILabel!
    @IBOutlet weak var sundaySummary: UILabel!

    

    override func viewDidLoad(){
        let weeklytWeather = WeeklyWeather(weatherDictionary: dailyData)
        self.mondayImage.image = weeklytWeather.mondayIcon
        self.tuesdayImage.image = weeklytWeather.tuesdayIcon
        self.wednesdayImage.image = weeklytWeather.wednesdayIcon
        self.thursdayImage.image = weeklytWeather.thursdayIcon
        self.fridayImage.image = weeklytWeather.fridayIcon
        self.saturdayIamge.image = weeklytWeather.saturdayIcon
        self.sundayImage.image = weeklytWeather.sundayIcon
        self.mondaySummary.text = weeklytWeather.summaryMonday
        self.tuesdaySummary.text = weeklytWeather.summaryTuesday
        self.wednesdaySummary.text = weeklytWeather.summaryWednesday
        self.thursdaySummary.text = weeklytWeather.summaryThursday
        self.fridaySummary.text = weeklytWeather.summaryFriday
        self.SaturdaySummary.text = weeklytWeather.summarySaturday
        self.sundaySummary.text = weeklytWeather.summarySunday

    }
    
    @IBAction func backAction() {
        
         dismissViewControllerAnimated(true, completion: nil)
    }
  



}

