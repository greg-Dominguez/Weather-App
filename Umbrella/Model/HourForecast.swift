//
//  HourForecast.swift
//  Umbrella
//
//  Created by Greg Dominguez on 10/3/17.
//  Copyright © 2017 greg.dominguez. All rights reserved.
//

import Foundation


struct HourForecast {
    
    let temperature: Int
    let time: String
    let weather: String
    let dayOffset: Int
    let iconURL: String
}


enum Weather {
    case cloudy
    case sunny
    case clear
    case partlyCloudy
    case unknown
}

enum HotCold {
    case hot
    case cold
}

class HourForecastViewModel {
    
    let temperature: String
    let timeLocalized: String
    let weather: Weather
    let iconURL: String
    
    var hottest: Bool = false
    var coldest: Bool = false
    
    convenience init(hour: HourForecast){
        self.init(time: hour.time, temp: String(hour.temperature), condition: hour.weather, iconURL: hour.iconURL)
    }
    
    init(time: String, temp: String, condition: String, iconURL: String){
        self.timeLocalized = time
        self.temperature = temp
        self.iconURL = iconURL
        
        switch condition {
        case "Clear":
            self.weather = .clear
        case "Sunny":
            self.weather = .sunny
        case "Cloudy":
            self.weather = .cloudy
        case "Partly Cloudy":
            self.weather = .partlyCloudy
        default:
            self.weather = .unknown
        }
    }
}
