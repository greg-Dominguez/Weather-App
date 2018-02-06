//
//  UserPreferences.swift
//  Umbrella
//
//  Created by Greg Dominguez on 10/3/17.
//  Copyright © 2017 greg.dominguez. All rights reserved.
//

import Foundation

class UserPreferences {
    
    private static let zipcodeKey = "zipcode"
    
    class func zipCodeIsSet() -> Bool {
        
        if let _ = UserDefaults.standard.value(forKey: zipcodeKey) as? String {
            return true
        }
        return false
    }
    
    class func zipCode()->String? {
        return UserDefaults.standard.value(forKey: zipcodeKey) as? String
    }
    
    class func store(zipcode: String) {
        if ZipcodeReader.isValid(zipcode: zipcode){
            UserDefaults.standard.set(zipcode, forKey: zipcodeKey)
            UserDefaults.standard.synchronize()
        }
    }
}
