//
//  WBMain.swift
//  WeatherBitcoinSample
//
//  Created by jatin verma on 13/06/19.
//  Copyright © 2019 jatin verma. All rights reserved.
//

import Foundation
import SwiftyJSON

class WBMain {
    var maxTemp:Double!
    var humidity:Int!
    var temp:Double!
    var minTemp:Double!
    var pressure:Int!
    init(json: JSON) {
        if json["temp_max"].double != nil {
            self.maxTemp = json["temp_max"].double
        }
        else {
            self.maxTemp = 0.0
        }
        if json["humidity"].int != nil {
            self.humidity = json["humidity"].int
        }
        else {
            self.humidity = 0
        }
        if json["temp"].double != nil {
            self.temp = json["temp"].double
        }
        else {
            self.temp = 0.0
        }
        if json["temp_min"].double != nil {
            self.minTemp = json["temp_min"].double
        }
        else {
            self.minTemp = 0.0
        }
        if json["pressure"].int != nil {
            self.pressure = json["pressure"].int
        }
        else {
            self.pressure = 0
        }
    }
}
