//
//  WBConstants.swift
//  WeatherBitcoinSample
//
//  Created by jatin verma on 13/06/19.
//  Copyright © 2019 jatin verma. All rights reserved.
//

import Foundation
struct WBConstants {
    struct Services {
        struct WeatherBitcoin {
            static let baseURL = "https://openweathermap.org/data/2.5"
            static let imageURL = "https://openweathermap.org/img/w/"
        }
    }
    struct ErrorStrings {
        static let timeOutError = "The request timed out."
        static let noInternetConnection = "The Internet connection appears to be offline."
        static let networkConnectionLost = "The network connection was lost."
        static let undefinedError = "Some error occured. Please try again!"
    }
    
    struct StoryBoard {
        static let mainStoryboard = "Main"
    }
    struct StoryBoardIds {
        static let weatherVC = "weather_view_controller"
        static let weatherCityVC = "weather_city_table_view_controller"
    }

}
