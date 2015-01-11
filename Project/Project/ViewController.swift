//
//  ViewController.swift
//  Project
//
//  Created by Onur ILTAN on 02/01/15.
//  Copyright (c) 2015 Onur ILTAN. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {
    
    
    private let apiKey = "d406d5c34221fa74d61fc28f2eb5fae5"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var refreshActivityIndicator: UIActivityIndicatorView!
    
    
    var locationManager = CLLocationManager()
    var currentLocation : CLLocation!
    var latitude :Double!
    var longitude : Double!
    var dailyDataa : NSArray!
    

  

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as WeeklyViewController
        destinationVC.dailyData = dailyDataa
    }

 

    func finder(){
        CLGeocoder().reverseGeocodeLocation(locationManager.location, completionHandler: { (placemarks, error) -> Void in
            
            if(error != nil ){
                println("Error occured")
                //self.latitude = 41.0
                //self.longitude = 29.259657
                return
                
            }
            
            if placemarks.count > 0 {
                let pmarks = placemarks[0] as CLPlacemark
                self.displayLocationInfo(pmarks)
            }
            else {
                println("Error with data")
            }
            
            
        })
    }
    
   

    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error: "+error.localizedDescription)
    }
    
    
    func displayLocationInfo(placemark : CLPlacemark){
        self.locationManager.stopUpdatingLocation()
        currentLocation = placemark.location
        latitude = currentLocation.coordinate.latitude
        longitude = currentLocation.coordinate.longitude
      

    }
    
   

    func locationFinder(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        locationFinder()
        finder()
        refreshActivityIndicator.hidden = true
        getCurrentWeatherData()
        
        
    }
    
    func getCurrentWeatherData() -> Void  {
        
        let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(apiKey)/")
        let forecastURL = NSURL(string: "\(latitude),\(longitude)" , relativeToURL:baseURL)
        let sharedSession = NSURLSession.sharedSession()
        let downloadTask: NSURLSessionDownloadTask =
        sharedSession.downloadTaskWithURL(forecastURL!,
            completionHandler: {(location:NSURL!, response:
                NSURLResponse!, error:NSError!)-> Void in
                
                if(error == nil){
                    
                    let dataObject = NSData(contentsOfURL: location)
                    let weatherDictionary:NSDictionary = NSJSONSerialization.JSONObjectWithData(dataObject!, options: nil, error: nil) as NSDictionary // take other days weathers from there
                    
                    let currentWeatherDictionary : NSDictionary = weatherDictionary["currently"] as NSDictionary
                    let weeklyWeatherDictionary : NSDictionary = weatherDictionary["daily"] as NSDictionary
                    
                    let dailyData : NSArray = weeklyWeatherDictionary["data"] as NSArray
                    self.dailyDataa = dailyData
                  
                    
                    let currentWeather = CurrentWeather(weatherDictionary: weatherDictionary)
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.temperatureLabel.text = "\((currentWeather.temperature - 32)*5/9)"
                        self.imageView.image = currentWeather.icon!
                        self.humidityLabel.text = "\(currentWeather.humidity)"
                        self.descriptionLabel.text = "\(currentWeather.summary)"
                        self.windSpeedLabel.text = "\(currentWeather.windSpeed)"
                        self.pressureLabel.text = "\(currentWeather.pressure)"
                        self.locationLabel.text = "\(currentWeather.location)"
                        self.refreshActivityIndicator.stopAnimating()
                        self.refreshActivityIndicator.hidden = true
                        self.refreshButton.hidden = false
                    })
                    
                }
                else{
                    
                    let netWorkIssueController = UIAlertController(title: "Error", message: "Unable to load data, try again", preferredStyle: .Alert)
                    
                    let okButton = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    netWorkIssueController.addAction(okButton)
                    
                    
                    self.presentViewController(netWorkIssueController, animated: true, completion: nil)
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.refreshActivityIndicator.stopAnimating()
                        self.refreshActivityIndicator.hidden = true
                        self.refreshButton.hidden = false
                    })
                    
                }
                
                
                
        })
        downloadTask.resume()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func refresh() {
        locationFinder()
        finder()
        getCurrentWeatherData()
        refreshButton.hidden = true
        refreshActivityIndicator.hidden = false
        refreshActivityIndicator.startAnimating()
    }
    
    
    
    


}

