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
        
        let dateComponents = Self.calendar.dateComponents(
            [ .yearForWeekOfYear, .weekOfYear ],
            from: self
        )
        
        return Self.calendar.date(from: dateComponents)
    }
    
    var timeString: String {
        DateFormatter.localizedString(from: self, dateStyle: .none, timeStyle: .short)
    }
    
    var dayString: String {
        Self.formatter.dateFormat = "d"
        return Self.formatter.string(from: self)
    }
    
    
    func toString(_ format: String) -> String {
        Self.formatter.dateFormat = format
        return Self.formatter.string(from: self)
    }
}
