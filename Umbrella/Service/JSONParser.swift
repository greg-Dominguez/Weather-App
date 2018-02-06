//
//  JSONParser.swift
//  Umbrella
//
//  Created by Greg Dominguez on 10/4/17.
//  Copyright © 2017 greg.dominguez. All rights reserved.
//

import Foundation

class JSONParser {
    
    private static let calendar = Calendar.current
    
    class func tenDayHourlyForecast(data: Data) -> [Day]? {
        
        var json: Any
        do {
            json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        }catch {
            return nil
        }
        
        guard let jsonData = json as? [String: Any] else {
            return nil
        }
        
        guard let jsonArray = jsonData["hourly_forecast"] as? [[String: Any]] else {
            return nil
        }
        
        var days: [Day] = []
        for jsonObject in jsonArray {
            if let hour = JSONParser.hourObject(data: jsonObject){
            
                //if this hour fits in the last day, add it there
                if !days.isEmpty{
                    if hour.dayOffset == days[days.count-1].dayOffset{
                        days[days.count-1].hours.append(hour)
                        continue
                    }
                }
                //start a new day
                let newDay = Day(dayOffset: hour.dayOffset, hours: [hour])
                days.append(newDay)
            }
        }
        return days
    }
    
    private class func hourObject(data: [String: Any]) -> HourForecast? {
        
        guard let fcttime = data["FCTTIME"] as? [String:Any],
            let epoch = fcttime["epoch"] as? String,
            let unixDate = Int(epoch),
            let time = fcttime["civil"] as? String else {
            return nil
        }
        
        guard let tempInfo = data["temp"] as? [String: Any],
            let tempString = tempInfo["english"] as? String,
            let temp = Int(tempString) else {
            return nil
        }
        
        guard let weather = data["wx"] as? String else {
            return nil
        }
        
        guard let iconURL = data["icon_url"] as? String else {
            return nil
        }
        let secureIconURL = iconURL.replacingOccurrences(of: "http", with: "https")
        
        //determine the number of days in the future this hour is (0 = today, 1 = tomorrow, ...)
        let day = JSONParser.calendar.startOfDay(for: Date(timeIntervalSince1970: TimeInterval(unixDate)))
        let today = JSONParser.calendar.startOfDay(for: Date())
        let dayOffset = JSONParser.calendar.dateComponents([.day], from: today, to: day).day ?? 0

        return HourForecast(temperature: temp, time: time, weather: weather, dayOffset: dayOffset, iconURL: secureIconURL)
    }
    
    class func currentForecast(data: Data) -> CurrentForecast? {
        
        var json: Any
        do {
            json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        }catch {
            return nil
        }
        
        guard let jsonData = json as? [String: Any] else {
            return nil
        }
        print(jsonData)
        guard let currentObservation = jsonData["current_observation"] as? [String: Any] else {
            return nil
        }
        
        guard let displayLocation = currentObservation["display_location"] as? [String: Any],
            let location = displayLocation["full"] as? String else {
                return nil
        }
        
        guard let temp = currentObservation["temp_f"] as? Float else {
                return nil
        }
        
        guard let condition = currentObservation["weather"] as? String else {
            return nil
        }
        
        
        return CurrentForecast(temperature: Int(temp), condition: condition, location: location)

        
    }
}
