//
//  WBWeatherService.swift
//  WeatherBitcoinSample
//
//  Created by jatin verma on 13/06/19.
//  Copyright © 2019 jatin verma. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WBWeatherService {
    class func getWeatherDetailByPlaceName(place: String, success: @escaping (WBWeather) -> Void, failure: @escaping (WBError) -> Void ) {
        let params = [
            "appid" : "b6907d289e10d714a6e88b30761fae22",
            "q" : place
        ]
        WBApiService.request(.get, needLogin: false, url: "/weather/", params: params as [String : AnyObject], success: { (json) in
            success(WBWeather(json: json!))
        }) { (error) in
            failure(error)
        }
    }
    
    class func getWeatherDetailByCoordinate(lat: Double, lon: Double, success: @escaping (WBWeather) -> Void, failure: @escaping (WBError) -> Void ) {
        let params = [
            "appid" : "b6907d289e10d714a6e88b30761fae22",
            "lat" : lat,
            "lon" : lon
            ] as [String : Any]
        WBApiService.request(.get, needLogin: false, url: "/weather/", params: params as [String : AnyObject], success: { (json) in
            success(WBWeather(json: json!))
        }) { (error) in
            failure(error)
        }
    }
}
