//
//  Date.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/8/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import Foundation


extension Date {
    
    var startOfWeek: Date? {
        let calendar = Calendar.current
        return calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
    }
}
