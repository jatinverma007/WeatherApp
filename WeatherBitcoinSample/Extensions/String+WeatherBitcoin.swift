//
//  String+WeatherBitcoin.swift
//  WeatherBitcoinSample
//
//  Created by jatin verma on 13/06/19.
//  Copyright © 2019 jatin verma. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func wb_length() -> Int {
        return (self as NSString).length
    }
    
    func wb_toInt() -> Int? {
        return Int(self)
    }
    
    func wb_toFloat() -> Float {
        return (self as NSString).floatValue
    }
}
