//
//  Date.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/8/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import Foundation


extension Date {
    
    private static let calendar = Calendar.current
    
    var startOfWeek: Date? {
        
        return Self.calendar.date(
            from: Self.calendar.dateComponents(
                [.yearForWeekOfYear, .weekOfYear],
                from: self
            )
        )
    }
}
