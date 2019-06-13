//
//  WBWind.swift
//  WeatherBitcoinSample
//
//  Created by jatin verma on 13/06/19.
//  Copyright © 2019 jatin verma. All rights reserved.
//

import Foundation
import SwiftyJSON

class WBWind {
    var speed: Double!
    var deg:Double!
    init(json : JSON) {
        if json["speed"].double != nil {
            self.speed = json["speed"].double
        }
        else {
            self.speed = 0.0
        }
        if json["deg"].double != nil {
            self.deg = json["deg"].double
        }
        else {
            self.deg = 0.0
        }
    }
}
