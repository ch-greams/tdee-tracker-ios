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
    
    public var startOfWeek: Date? {
        
        let dateComponents = Self.calendar.dateComponents(
            [ .yearForWeekOfYear, .weekOfYear ],
            from: self
        )
        
        return Self.calendar.date(from: dateComponents)
    }
    
    public var timeString: String {
        DateFormatter.localizedString(from: self, dateStyle: .none, timeStyle: .short)
    }
    
    public var dayString: String {
        Self.formatter.dateFormat = "d"
        return Self.formatter.string(from: self)
    }
    
    public var withoutTime: Date {
        let dayScope = Self.calendar.dateComponents([.year, .month, .day], from: self)
        return Self.calendar.date(from: dayScope) ?? self
    }
    
    public func addDays(_ count: Int) -> Date? {
        return Self.calendar.date(byAdding: .day, value: count, to: self)
    }
    
    
    public func toString(_ format: String) -> String {
        Self.formatter.dateFormat = format
        return Self.formatter.string(from: self)
    }
    
    public static var today: Date { Date().withoutTime }
}
