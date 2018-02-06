//
//  DataManager.swift
//  Umbrella
//
//  Created by Greg Dominguez on 10/4/17.
//  Copyright © 2017 greg.dominguez. All rights reserved.
//

import Foundation

protocol WeatherDataDelegate: class {
    
    func updateCurrentConditions(current: CurrentForecast)
    func updateForecast(days: [Day])
    func requestZipCode()
}

class WeatherDataManager {
    
    static let shared = WeatherDataManager()
    weak var delegate: WeatherDataDelegate?

    private(set) var current: CurrentForecast?
    private(set) var days: [Day] = []
    private(set) var zipcode: String?
    
    private init(){
        
        zipcode = UserPreferences.zipCode()
    }
    
    func reloadData(){
        
        guard let zip = zipcode else {
            delegate?.requestZipCode()
            return
        }
        
        WebserviceManager.request10DayForecastData(zipcode: zip){ [weak self] days in
            self?.updateForecast(newDays: days)
        }
        
        WebserviceManager.requestCurrentConditions(zipcode: zip){ [weak self] conditions in
            if let currentConditions = conditions{
                self?.updateCurrentConditions(newCurrent: currentConditions)
            }
        }
    }
    
    func set(zipcode: String){
        self.zipcode = zipcode
        UserPreferences.store(zipcode: zipcode)
    }
    
    private func updateForecast(newDays: [Day]){
        days = newDays
        delegate?.updateForecast(days: newDays)
    }
    
    private func updateCurrentConditions(newCurrent: CurrentForecast) {
        current = newCurrent
        delegate?.updateCurrentConditions(current: newCurrent)
    }
}
