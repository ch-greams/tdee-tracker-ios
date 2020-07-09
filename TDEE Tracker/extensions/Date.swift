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
    private static let formatter = DateFormatter()
    
    var startOfWeek: Date? {
        
        Self.calendar.date(
            from: Self.calendar.dateComponents(
                [ .yearForWeekOfYear, .weekOfYear ],
                from: self
            )
        )
    }
    
    var timeString: String {
        DateFormatter.localizedString(from: self, dateStyle: .none, timeStyle: .short)
    }
    
    var dayString: String {
        Self.formatter.dateFormat = "d"
        return Self.formatter.string(from: self)
    }
}
