//
//  WBWeatherDetail.swift
//  WeatherBitcoinSample
//
//  Created by jatin verma on 13/06/19.
//  Copyright © 2019 jatin verma. All rights reserved.
//

import Foundation
import SwiftyJSON

class WBWeatherDetail {
    var icon: String!
    var id: Int!
    var main:String!
    var description:String!
    init(json : JSON) {
        if json["icon"].string != nil {
            self.icon = json["icon"].string
        }
        else {
            self.icon = ""
        }
        if json["id"].int != nil {
            self.id = json["id"].int
        }
        else {
            self.id = 0
        }
        if json["main"].string != nil {
            self.main = json["main"].string
        }
        else {
            self.main = ""
        }
        if json["description"].string != nil {
            self.description = json["description"].string
        }
        else {
            self.description = ""
        }
    }
}
