//
//  WBWeather.swift
//  WeatherBitcoinSample
//
//  Created by jatin verma on 13/06/19.
//  Copyright © 2019 jatin verma. All rights reserved.
//

import Foundation
import SwiftyJSON

class WBWeather {
    var lon:Double!
    var lat:Double!
    var base:String!
    var visibility:Double!
    var cloud:Int!
    var dt:Double!
    var id:Double!
    var name:String!
    var cod:Double!
    var weatherDetail:[WBWeatherDetail]!
    var weatherSystem:WBSystem!
    var weatherMain:WBMain!
    var weatherWind:WBWind!
    init(json : JSON) {
        if json["coord"]["lat"].double != nil {
            self.lat = json["coord"]["lat"].double
        }
        else {
            self.lat = 0.0
        }
        if json["coord"]["lon"].double != nil {
            self.lon = json["coord"]["lon"].double
        }
        else {
            self.lon = 0.0
        }
        if json["base"].string != nil {
            self.base = json["base"].string
        }
        else {
            self.base = ""
        }
        if json["dt"].double != nil {
            self.dt = json["dt"].double
        }
        else {
            self.dt = 0.0
        }
        if json["name"].string != nil {
            self.name = json["name"].string
        }
        else {
            self.name = ""
        }
        if json["clouds"]["all"].int != nil {
            self.cloud = json["clouds"]["all"].int
        }
        else {
            self.cloud = 0
        }
        if json["visibility"].double != nil {
            self.visibility = json["visibility"].double
        }
        else {
            self.visibility = 0.0
        }
        if json["weather"].exists() {
            var weath = [WBWeatherDetail]()
            for (_, subJSON):(String, JSON) in json["weather"] {
                weath.append(WBWeatherDetail(json: subJSON))
            }
            self.weatherDetail = weath
        }
        self.weatherSystem = WBSystem(json: json["sys"])
        self.weatherMain = WBMain(json: json["main"])
        self.weatherWind = WBWind(json: json["wind"])
        
    }
    
}
