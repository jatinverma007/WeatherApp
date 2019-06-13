//
//  WBError.swift
//  WeatherBitcoinSample
//
//  Created by jatin verma on 13/06/19.
//  Copyright © 2019 jatin verma. All rights reserved.
//

import Foundation
import SwiftyJSON

class WBError {
    var message:String?
    
    init(json: JSON) {
        let js = JSON(parseJSON: json.string!)
        if js["msg"].string != nil {
            self.message = js["msg"].string
        }
        else {
            self.message = ""
        }
    }
    
    init(statusCode:Int, message:String) {
        self.message = message
    }
}
