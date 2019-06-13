//
//  WBSystem.swift
//  WeatherBitcoinSample
//
//  Created by jatin verma on 13/06/19.
//  Copyright © 2019 jatin verma. All rights reserved.
//

import Foundation
import SwiftyJSON

class WBSystem {
    var type:Int!
    var id:Int!
    var message:Double!
    var country:String!
    var sunrise:Double!
    var sunset:Double!
    init(json: JSON) {
        if json["type"].int != nil {
            self.type = json["type"].int
        }
        else {
            self.type = 0
        }
        if json["id"].int != nil {
            self.id = json["id"].int
        }
        else {
            self.id = 0
        }
        if json["country"].string != nil {
            self.country = json["country"].string
        }
        else {
            self.country = ""
        }
        if json["sunset"].double != nil {
            self.sunset = json["sunset"].double
        }
        else {
            self.sunset = 0.0
        }
        if json["sunrise"].double != nil {
            self.sunrise = json["sunrise"].double
        }
        else {
            self.sunrise = 0.0
        }
        if json["message"].double != nil {
            self.message = json["message"].double
        }
        else {
            self.message = 0.0
        }
    }
}
