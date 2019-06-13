//
//  Int+WeatherBitcoin.swift
//  WeatherBitcoinSample
//
//  Created by jatin verma on 13/06/19.
//  Copyright © 2019 jatin verma. All rights reserved.
//

import Foundation

extension Int {
    func st_toString() -> String {
        return String(self)
    }
    
    func st_toDouble() -> Double {
        return Double(self)
    }
    func st_toDurationString() -> String {
        let seconds = self % 60
        let minutes = (self / 60) % 60
        let hours = self / 3600
        let strHours = hours > 9 ? String(hours) : "0" + String(hours)
        let strMinutes = minutes > 9 ? String(minutes) : "0" + String(minutes)
        let strSeconds = seconds > 9 ? String(seconds) : "0" + String(seconds)
        
        if hours > 0 {
            return "\(strHours):\(strMinutes):\(strSeconds)"
        }
        else {
            return "\(strMinutes):\(strSeconds)"
        }
        
    }
    
    func st_toFloat() -> Float {
        return Float(self)
    }
    
    func st_randonElement(lowerLimit: Int = 0, upperLimit: Int = 99) -> Int {
        guard upperLimit > lowerLimit else {
            return -1
        }
        
        let difference = upperLimit - lowerLimit
        
        let randomItem = Int(arc4random_uniform(UInt32(difference)))
        
        return lowerLimit + randomItem
    }
    
}
