//
//  CityWeatherTableViewController.swift
//  WeatherBitcoinSample
//
//  Created by jatin verma on 13/06/19.
//  Copyright © 2019 jatin verma. All rights reserved.
//

import UIKit
import CoreLocation


class CityWeatherTableViewController: UITableViewController, CLLocationManagerDelegate {

    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var wRemarks: UILabel!
    @IBOutlet weak var wTemp: UILabel!
    @IBOutlet weak var wStatus: UILabel!
    @IBOutlet weak var wIcon: UIImageView!
    @IBOutlet weak var cloudLabel: UILabel!
    @IBOutlet weak var dayCloudIcon: UIImageView!
    @IBOutlet weak var nightCloudIcon: UIImageView!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!

    var currentCity:String!
    var locationManager:CLLocationManager!

    var currentWeather:WBWeather! {
        didSet {
            self.removeSpinner()
            tableView.reloadData()
            city.text = currentWeather.name
            wRemarks.text = currentWeather.weatherDetail.first!.main
            wTemp.text = NSString(format:"\(String(describing: currentWeather.weatherMain.temp!))%@" as NSString, "\u{00B0}") as String
            wStatus.text = "Today: " +  currentWeather.weatherDetail.first!.description
            let url = URL(string: WBConstants.Services.WeatherBitcoin.imageURL + currentWeather.weatherDetail.first!.icon + ".png")
            wIcon.downloaded(from: url!)
            cloudLabel.text = currentWeather.cloud.st_toString() + " %"
            let dayCloudIconUrl = URL(string: WBConstants.Services.WeatherBitcoin.imageURL + getCloudIcon(number: currentWeather.cloud).0 + ".png")
            dayCloudIcon.downloaded(from: dayCloudIconUrl!)
            let nightCloudIconUrl = URL(string: WBConstants.Services.WeatherBitcoin.imageURL + getCloudIcon(number: currentWeather.cloud).1 + ".png")
            nightCloudIcon.downloaded(from: nightCloudIconUrl!)
            humidityLabel.text = currentWeather.weatherMain.humidity.st_toString() + " %"
            windLabel.text = currentWeather.weatherWind.speed.wt_toString() + " km/hr"
            pressureLabel.text = currentWeather.weatherMain.pressure.st_toString() + " hPa"
            visibilityLabel.text = (currentWeather.visibility/1000).wt_toString() + " km/hr"
        }
    }

    //View controller functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.alwaysBounceVertical = false
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if currentCity == "current" {
            determineMyCurrentLocation()
        }
        else {
            getWeatherDetail()
        }
    }
    
    //Helper functions
    func getCloudIcon(number: Int) -> (String, String) {
        if number >= 11 && number <= 25 {
            return ("02d","02n")
        }
        else if number > 25 && number <= 50 {
            return ("03d", "03n")
        }
        else if number >= 51 && number <= 84 {
            return ("04d", "04n")
        }
        else {
            return ("04d", "04n")
        }
    }
    
    //Load weather details
    func getWeatherDetail() {
        self.showSpinner(onView: self.view)
        WBWeatherService.getWeatherDetailByPlaceName(place: currentCity, success: { (weather) in
            self.currentWeather = weather
        }) { (error) in
            let alert = UIAlertController(title: "Error", message: error.message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func getWeatherDetailByCoordinates(lat: Double, long: Double) {
        self.showSpinner(onView: self.view)
        WBWeatherService.getWeatherDetailByCoordinate(lat: lat, lon: long, success: { (weather) in
            self.currentWeather = weather
        }) { (error) in
            let alert = UIAlertController(title: "Error", message: error.message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //tableview datasource and delegate
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.wt_disableHighlight()
        cell.wt_disableTap()
    }

    //Locations
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        getWeatherDetailByCoordinates(lat: userLocation.coordinate.latitude, long: userLocation.coordinate.longitude)
        locationManager.stopUpdatingLocation()
//        print("user latitude = \(userLocation.coordinate.latitude)")
//        print("user longitude = \(userLocation.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
