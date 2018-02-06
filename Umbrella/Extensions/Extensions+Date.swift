//
//  Extensions+Date.swift
//  Umbrella
//
//  Created by Greg Dominguez on 10/5/17.
//  Copyright © 2017 greg.dominguez. All rights reserved.
//

import Foundation

extension Date {
    
    //date formatters are expensive, so compute it lazily
    private static var weekdayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter
    }
    
    var weekdayName: String {
        return Date.weekdayFormatter.string(from: self)
    }
    
}
