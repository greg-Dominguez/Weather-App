//
//  WebserviceManager.swift
//  Umbrella
//
//  Created by Greg Dominguez on 10/4/17.
//  Copyright © 2017 greg.dominguez. All rights reserved.
//

import Foundation

fileprivate struct API {
    
    static let key = "06a69a38eed8bdc5"
    static let responseType = ".json"
    static var baseURL: String {
        return "https://api.wunderground.com/api/" + API.key
    }
    
    static func forecast10DayURL(zipcode: String) -> String {
        return API.baseURL + "/hourly10day/q/" + zipcode + API.responseType
    }
    
    static func currentConditions(zipcode: String) -> String {
        
        return API.baseURL + "/conditions/q/" + zipcode + API.responseType
    }
    
}

class WebserviceManager {
    
    class func request10DayForecastData(zipcode: String, completion: @escaping ([Day])->Void){
        
        guard let url = URL(string: API.forecast10DayURL(zipcode: zipcode)) else {
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: url){ data, response, error in
            
            if let e = error {
                print(e)
                completion([])
                return
            }
            
            guard let jsonData = data else {
                completion([])
                return
            }
            
            if let forecast = JSONParser.tenDayHourlyForecast(data: jsonData) {
                completion(forecast)
            }else {
                completion([])
            }
        }.resume()
    }
    
    class func requestCurrentConditions(zipcode: String, completion: @escaping (CurrentForecast?)->Void){
        
        guard let url = URL(string: API.currentConditions(zipcode: zipcode)) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url){ data, response, error in
            
            if let e = error {
                print(e)
                completion(nil)
                return
            }
            
            guard let jsonData = data else {
                completion(nil)
                return
            }
            
            if let forecast = JSONParser.currentForecast(data: jsonData) {
                completion(forecast)
            }else {
                completion(nil)
            }
            }.resume()
    }

    
    
}
