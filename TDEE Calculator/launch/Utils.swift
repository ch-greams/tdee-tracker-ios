//
//  Utils.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/8/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import Foundation


struct WeekSummary {
    
    let avgFood: Int?
    let avgWeight: Double
    let deltaWeight: Double?
    let tdee: Int?
}

enum WeekSummaryChange {
    case Up, None, Down
}

class Utils {
    
    // MARK: - Constants
    
    static let CALORIES_PER_KILO: Double = 7716.17
    
    static let LAST_TDEE_VALUES_TO_USE: Int = 3
    
    static let DEFAULT_SUMMARY = WeekSummary(avgFood: 0, avgWeight: 0, deltaWeight: 0, tdee: 0)
    
    // MARK: - Data Transformation
    
    public static func getWeeks(days: [ Date: DayEntry ]) -> [ Date: [ DayEntry ] ] {
        
        var dayEntriesByWeek: [ Date: [ DayEntry ] ] = [:]
        
        for day in days {
            
            if let firstDayOfWeek = day.key.startOfWeek {
                
                if var existingWeek = dayEntriesByWeek[firstDayOfWeek] {

                    existingWeek.append(day.value)
                    
                    dayEntriesByWeek[firstDayOfWeek] = existingWeek
                }
                else {
                    dayEntriesByWeek[firstDayOfWeek] = [ day.value ]
                }
            }
        }
        
        return dayEntriesByWeek
    }
    
    private static func getWeekSummary(
        entries: [ DayEntry ], prevWeekSummary: WeekSummary, prevTdee: [ Int ]
    ) -> WeekSummary {
        
        // avgFood
        let foodEntries = entries.compactMap { $0.food }
        let avgFood: Int = foodEntries.average()
        
        // avgWeight
        let weightEntries = entries.compactMap { $0.weight }
        let avgWeight: Double = weightEntries.average()
        
        // deltaWeight
        let weeklyDeltaWeight = avgWeight - prevWeekSummary.avgWeight;
        let doubleAccuracy: Double = 100
        let deltaWeight = Double( round( doubleAccuracy * weeklyDeltaWeight ) / doubleAccuracy )
        
        // tdee
        let dailyDelta = weeklyDeltaWeight / 7;
        let avgDailyDeltaCal = Int( dailyDelta * Utils.CALORIES_PER_KILO );
        
        let currentTdee = avgFood - avgDailyDeltaCal;

        var prevTdeeToUse = prevTdee.suffix(Utils.LAST_TDEE_VALUES_TO_USE)
        prevTdeeToUse.append(currentTdee)

        let tdee = prevTdeeToUse.average()
        
        return WeekSummary(avgFood: avgFood, avgWeight: avgWeight, deltaWeight: deltaWeight, tdee: tdee)
    }
    
    public static func getWeekSummaries(weeks: [ Date: [ DayEntry ] ]) -> [ Date: WeekSummary ] {
        
        var weekSummaries: [ Date: WeekSummary ] = [:]
        var tdeeArray: [ Int ] = []
        
        let startWeight: Double = 76.0
        let defaultPrevWeekSummary = WeekSummary(
            avgFood: nil,
            avgWeight: startWeight,
            deltaWeight: nil,
            tdee: nil
        )
    
        let sortedWeeks = weeks.keys.sorted(by: { $0.timeIntervalSince1970 < $1.timeIntervalSince1970 })
        var lastWeekSummary = defaultPrevWeekSummary

        for startWeekDate in sortedWeeks {
            
            if let currentWeek = weeks[startWeekDate] {
                
                let weekSummary = Self.getWeekSummary(
                    entries: currentWeek,
                    prevWeekSummary: lastWeekSummary,
                    prevTdee: tdeeArray
                )
                
                weekSummaries[startWeekDate] = weekSummary
                lastWeekSummary = weekSummary
                tdeeArray.append(weekSummary.tdee!)
            }
        }
        
        return weekSummaries
    }
    
    public static func getWeekSummaryParamChange<T: Comparable>(previous: T?, current: T?) -> WeekSummaryChange {

        if previous == nil || current == nil {
            return WeekSummaryChange.None
        }
        else {
            return (
                ( current == previous )
                    ? WeekSummaryChange.None
                    : ( current! > previous! ) ? WeekSummaryChange.Up : WeekSummaryChange.Down
            )
        }
    }
    
    // MARK: - Serialization

    public static func encode<T>(data: T) -> Data? {
        
        return try? NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: false)
    }
    
    public static func decode<T>(data: Data) -> T? {

        return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? T
    }
}
