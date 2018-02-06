//
//  ZipcodeReader.swift
//  Umbrella
//
//  Created by Greg Dominguez on 10/3/17.
//  Copyright © 2017 greg.dominguez. All rights reserved.
//

import Foundation

class ZipcodeReader {
    
    class func isValid(zipcode: String) -> Bool{
        if zipcode.count != 5 {
            return false
        }
        
        if let _ = Int(zipcode){
            return true
        }
        return false
    }
}
