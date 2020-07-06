//
//  Utils.swift
//  TDEE Tracker
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

struct WeekSummaryTrends {

    let avgFood: WeekSummaryChange
    let avgWeight: WeekSummaryChange
    let deltaWeight: WeekSummaryChange
    let tdee: WeekSummaryChange
    
    init(
        avgFood: WeekSummaryChange = WeekSummaryChange.None,
        avgWeight: WeekSummaryChange = WeekSummaryChange.None,
        deltaWeight: WeekSummaryChange = WeekSummaryChange.None,
        tdee: WeekSummaryChange = WeekSummaryChange.None
    ) {
        self.avgFood = avgFood
        self.avgWeight = avgWeight
        self.deltaWeight = deltaWeight
        self.tdee = tdee
    }
    
    init(previousSummary: WeekSummary, currentSummary: WeekSummary) {

        self.avgFood = Utils.getWeekSummaryParamChange(
            previous: previousSummary.avgFood,
            current: currentSummary.avgFood
        )
        self.avgWeight = Utils.getWeekSummaryParamChange(
            previous: previousSummary.avgWeight,
            current: currentSummary.avgWeight
        )
        self.deltaWeight = Utils.getWeekSummaryParamChange(
            previous: previousSummary.deltaWeight,
            current: currentSummary.deltaWeight
        )
        self.tdee = Utils.getWeekSummaryParamChange(
            previous: previousSummary.tdee,
            current: currentSummary.tdee
        )
    }
}

enum WeekSummaryChange {
    case Up, None, Down
}

class Utils {
    
    // MARK: - Constants
    
    private static let calendar = Calendar.current
    
    private static let KCAL_PER_KG: Double = 7716.17

    private static let KCAL_TO_KJ_MULTIPLIER: Double = 4.184
    
    private static let KG_TO_LB_MULTIPLIER: Double = 2.20462

    
    private static let MAX_WEIGHT_ENTRY_KG: Double = 450.0
    
    private static let MIN_WEIGHT_ENTRY_KG: Double = 30.0
    
    private static let MAX_FOOD_ENTRY_KCAL: Int = 9999
    
    private static let MIN_FOOD_ENTRY_KCAL: Int = 1000
    
    private static let MAX_WEEKLY_WEIGHT_DELTA_KG: Double = 4.5
    
    private static let MIN_WEEKLY_WEIGHT_DELTA_KG: Double = 0.0

    
    private static let LAST_TDEE_VALUES_TO_USE: Int = 3
    
    public static let DEFAULT_SUMMARY = WeekSummary(avgFood: 0, avgWeight: 0, deltaWeight: 0, tdee: 0)
    
    // MARK: - Data Transformation
    
    public static func getShortWeekdayNames() -> [ String ] {
        
        let weekdays = DateFormatter().shortWeekdaySymbols.compactMap { $0 }
        
        let firstWeekday = Self.calendar.firstWeekday - 1
        
        return Array( weekdays[ firstWeekday ..< weekdays.count ] + weekdays[ 0 ..< firstWeekday ] )
    }
    
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
        entries: [ DayEntry ],
        prevWeekAvgWeight: Double?,
        prevTdee: [ Int ],
        energyUnit: EnergyUnit,
        weightUnit: WeightUnit
    ) -> WeekSummary {
        
        // avgFood
        let foodEntries = entries.compactMap { $0.food }
        let avgFood: Int = foodEntries.average()
        
        // avgWeight
        let weightEntries = entries.compactMap { $0.weight }
        let avgWeight: Double = weightEntries.average()
        
        // deltaWeight
        let weeklyDeltaWeight = ( avgWeight - (prevWeekAvgWeight ?? avgWeight) ).rounded(to: 2)
        
        // tdee
        let avgDailyDeltaCal = Self.getEnergyFromWeight(
            weight: ( weeklyDeltaWeight / 7 ),
            energyUnit: energyUnit,
            weightUnit: weightUnit
        )
        
        let currentTdee = avgFood - avgDailyDeltaCal

        var prevTdeeToUse = prevTdee.suffix(Self.LAST_TDEE_VALUES_TO_USE)
        prevTdeeToUse.append(currentTdee)

        let tdee = prevTdeeToUse.average()
        
        return WeekSummary(
            avgFood: avgFood,
            avgWeight: avgWeight,
            deltaWeight: weeklyDeltaWeight,
            tdee: tdee
        )
    }
    
    public static func getWeekSummaries(
        weeks: [ Date: [ DayEntry ] ], energyUnit: EnergyUnit, weightUnit: WeightUnit
    ) -> [ Date: WeekSummary ] {
        
        var weekSummaries: [ Date: WeekSummary ] = [:]
        var tdeeArray: [ Int ] = []
    
        let sortedWeeks = weeks.keys.sorted(by: { $0.timeIntervalSince1970 < $1.timeIntervalSince1970 })
        var lastWeekAvgWeight: Double? = nil

        for startWeekDate in sortedWeeks {
            
            if let currentWeek = weeks[startWeekDate] {
                
                let entries = currentWeek.filter { $0.weight != nil && $0.food != nil }
                
                if entries.count > 0 {

                    let weekSummary = Self.getWeekSummary(
                        entries: entries,
                        prevWeekAvgWeight: lastWeekAvgWeight,
                        prevTdee: tdeeArray,
                        energyUnit: energyUnit,
                        weightUnit: weightUnit
                    )
                    
                    weekSummaries[startWeekDate] = weekSummary
                    lastWeekAvgWeight = weekSummary.avgWeight
                    
                    if let lastWeekTDEE = weekSummary.tdee {
                        tdeeArray.append(lastWeekTDEE)
                    }
                }
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
    
    // MARK: - Validation
    
    public static func getWeightOutsideOfValidRangeText(unit: WeightUnit) -> String {
        
        switch unit {
            case WeightUnit.kg:
                let minWeight = Self.MIN_WEIGHT_ENTRY_KG
                let maxWeight = Self.MAX_WEIGHT_ENTRY_KG
                return "\(Label.inputError) (\(minWeight.toString()) - \(maxWeight.toString()))"
            case WeightUnit.lb:
                let minWeight = Self.MIN_WEIGHT_ENTRY_KG * Self.KG_TO_LB_MULTIPLIER
                let maxWeight = Self.MAX_WEIGHT_ENTRY_KG * Self.KG_TO_LB_MULTIPLIER
                return "\(Label.inputError) (\(minWeight.toString()) - \(maxWeight.toString()))"
        }
    }
    
    public static func getFoodOutsideOfValidRangeText(unit: EnergyUnit) -> String {
        
        switch unit {
            case EnergyUnit.kcal:
                return "\(Label.inputError) (\(Self.MIN_FOOD_ENTRY_KCAL) - \(Self.MAX_FOOD_ENTRY_KCAL))"
            case EnergyUnit.kj:
                let minFood = Int( Double( Self.MIN_FOOD_ENTRY_KCAL ) * Self.KCAL_TO_KJ_MULTIPLIER )
                let maxFood = Int( Double( Self.MAX_FOOD_ENTRY_KCAL ) * Self.KCAL_TO_KJ_MULTIPLIER )
                return "\(Label.inputError) (\(minFood) - \(maxFood))"
        }
    }
    
    public static func getDeltaWeightOutsideOfValidRangeText(unit: WeightUnit) -> String {
        
        switch unit {
            case WeightUnit.kg:
                let minWeight = Self.MIN_WEEKLY_WEIGHT_DELTA_KG
                let maxWeight = Self.MAX_WEEKLY_WEIGHT_DELTA_KG
                return "\(Label.inputError) (\(minWeight.toString()) - \(maxWeight.toString()))"
            case WeightUnit.lb:
                let minWeight = Self.MIN_WEEKLY_WEIGHT_DELTA_KG * Self.KG_TO_LB_MULTIPLIER
                let maxWeight = Self.MAX_WEEKLY_WEIGHT_DELTA_KG * Self.KG_TO_LB_MULTIPLIER
                return "\(Label.inputError) (\(minWeight.toString()) - \(maxWeight.toString()))"
        }
    }
    
    public static func isWeightValueValid(value: Double, unit: WeightUnit) -> Bool {
        
        switch unit {
            case WeightUnit.kg:
                return ( value >= Self.MIN_WEIGHT_ENTRY_KG )
                    && ( value <= Self.MAX_WEIGHT_ENTRY_KG )
            case WeightUnit.lb:
                return ( value >= Self.MIN_WEIGHT_ENTRY_KG * Self.KG_TO_LB_MULTIPLIER )
                    && ( value <= Self.MAX_WEIGHT_ENTRY_KG * Self.KG_TO_LB_MULTIPLIER )
        }
    }
    
    public static func isFoodValueValid(value: Int, unit: EnergyUnit) -> Bool {
        
        switch unit {
            case EnergyUnit.kcal:
                return ( value >= Self.MIN_FOOD_ENTRY_KCAL )
                    && ( value <= Self.MAX_FOOD_ENTRY_KCAL )
            case EnergyUnit.kj:
                return ( value >= Int( Double(Self.MIN_FOOD_ENTRY_KCAL) * Self.KCAL_TO_KJ_MULTIPLIER ) )
                    && ( value <= Int( Double(Self.MAX_FOOD_ENTRY_KCAL) * Self.KCAL_TO_KJ_MULTIPLIER ) )
        }
    }
    
    public static func isWeeklyWeightDeltaValueValid(value: Double, unit: WeightUnit) -> Bool {
        
        switch unit {
            case WeightUnit.kg:
                return ( value >= Self.MIN_WEEKLY_WEIGHT_DELTA_KG )
                    && ( value <= Self.MAX_WEEKLY_WEIGHT_DELTA_KG )
            case WeightUnit.lb:
                return ( value >= Self.MIN_WEEKLY_WEIGHT_DELTA_KG * Self.KG_TO_LB_MULTIPLIER )
                    && ( value <= Self.MAX_WEEKLY_WEIGHT_DELTA_KG * Self.KG_TO_LB_MULTIPLIER )
        }
    }

    // MARK: - Date
    
    public static var todayDate: Date {

        let dayScope = Utils.calendar.dateComponents([.year, .month, .day], from: Date())
        return Utils.calendar.date(from: dayScope) ?? Date()
    }
    
    public static func getDateFromTimeComponents(hour: Int, minute: Int) -> Date? {
        
        let dateComponents = DateComponents(hour: hour, minute: minute)
        return calendar.date(from: dateComponents)
    }

    // MARK: - Conversions
    
    public static func getEnergyFromWeight(weight: Double, energyUnit: EnergyUnit, weightUnit: WeightUnit) -> Int {
        
        switch (energyUnit, weightUnit) {
            
            case (EnergyUnit.kcal, WeightUnit.kg):
                return Int( weight * Self.KCAL_PER_KG )
            
            case (EnergyUnit.kj, WeightUnit.kg):
                return Int( weight * Self.KCAL_PER_KG * Self.KCAL_TO_KJ_MULTIPLIER )

            case (EnergyUnit.kcal, WeightUnit.lb):
                return Int( weight * ( Self.KCAL_PER_KG / Self.KG_TO_LB_MULTIPLIER ) )

            case (EnergyUnit.kj, WeightUnit.lb):
                return Int( weight * ( Self.KCAL_PER_KG / Self.KG_TO_LB_MULTIPLIER ) * Self.KCAL_TO_KJ_MULTIPLIER )
        }
    }
    
    public static func convertEnergy(value: Int, from: EnergyUnit, to: EnergyUnit) -> Int {
        
        switch (from, to) {

            case (EnergyUnit.kcal, EnergyUnit.kj):
                return Int( Double(value) * Self.KCAL_TO_KJ_MULTIPLIER )

            case (EnergyUnit.kj, EnergyUnit.kcal):
                return Int( Double(value) / Self.KCAL_TO_KJ_MULTIPLIER )

            default:
                return value
        }
    }
    
    public static func convertWeight(value: Double, from: WeightUnit, to: WeightUnit) -> Double {
        
        switch (from, to) {

            case (WeightUnit.kg, WeightUnit.lb):
                return (value * Self.KG_TO_LB_MULTIPLIER).rounded(to: 2)

            case (WeightUnit.lb, WeightUnit.kg):
                return (value / Self.KG_TO_LB_MULTIPLIER).rounded(to: 2)

            default:
                return value
        }
    }
    
    public static func convertWeightInEntries(
        entries: [ Date : DayEntry ], from: WeightUnit, to: WeightUnit
    ) -> [ Date : DayEntry ] {
        
        return entries.mapValues {
            
            if let weightValue = $0.weight {
                return DayEntry(weight: Self.convertWeight(value: weightValue, from: from, to: to), food: $0.food)
            }
            else {
                return $0
            }
        }
    }
    
    public static func convertEnergyInEntries(
        entries: [ Date : DayEntry ], from: EnergyUnit, to: EnergyUnit
    ) -> [ Date : DayEntry ] {
        
        return entries.mapValues {
            
            if let foodValue = $0.food {
                return DayEntry(weight: $0.weight, food: Self.convertEnergy(value: foodValue, from: from, to: to))
            }
            else {
                return $0
            }
        }
    }
}
