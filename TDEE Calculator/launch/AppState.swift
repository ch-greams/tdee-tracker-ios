//
//  AppState.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/6/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import Foundation
import SwiftUI

enum AppStateKey: String, CaseIterable {

    // TODO: Change to PascalCase later (it'll mess up existing data)
    case entries
    case weightUnit, energyUnit
    case goalWeight, goalWeeklyDelta, goalTargetSurplus
}

enum WeightUnit: String, Equatable {
    case kg = "KG"
    case lb = "LB"
}

enum EnergyUnit: String, Equatable {
    case kcal = "KCAL"
    case kj = "KJ"
}



class AppState: ObservableObject {
    
    private let calendar = Calendar.current

    private let store: UserDefaults
    
    // NOTE: Possible issues when user changes timezones
    @Published var selectedDay: Date

    @Published var weight: String = ""
    @Published var food: String = ""
    
    @Published private var entries: [ Date : DayEntry ] = [:]
    
    @Published var summaries: [ Date: WeekSummary ] = [:]
    
    // TODO: Save in the store or calculate each time?
    @Published var recommendedAmount: Int = 0
    
    @Published var weightUnit: WeightUnit = WeightUnit.kg
    @Published var energyUnit: EnergyUnit = EnergyUnit.kcal
    
    @Published var goalWeight: Double = 0.0
    @Published var goalWeeklyDelta: Double = 0.0
    // TODO: Save in the store or calculate each time?
    @Published var goalTargetSurplus: Int = 0
    
    @Published var goalWeightInput: String = "0.0"
    @Published var goalWeeklyDeltaInput: String = "0.0"

    

     // MARK: - Lifecycle
    
    init(store: UserDefaults = .standard) {
        
        // MARK: - Standard roperty initialization
        
        self.store = store

        let dayScope = calendar.dateComponents([.year, .month, .day], from: Date())
        self.selectedDay = calendar.date(from: dayScope)!
        
        // MARK: - Other setup
        
        self.loadEntries()
        
        self.loadSelectedDayData(for: self.selectedDay)
        
        self.refreshSummary()
        
        // Load configuration
        
        self.loadConfiguration()
    }
    
    // MARK: - Private
    
    private func loadEntries() {
        
        if let savedEntriesData = self.store.data(forKey: AppStateKey.entries.rawValue) {
            
            if let entries: [ Date : DayEntry ] = Utils.decode(data: savedEntriesData) {

                self.entries = entries
            }
        }
    }
    
    // NOTE: Do not run this on every change
    private func saveEntries() {
        
        if let encodedData = Utils.encode(data: self.entries) {
            
            self.store.set(encodedData, forKey: AppStateKey.entries.rawValue)
        }
    }
    
    private func loadSelectedDayData(for date: Date) {
        
        if let existingEntry = self.entries[date] {
            
            if let existingWeight = existingEntry.weight {
                
                self.weight = String(existingWeight)
            }
            else {
                
                self.weight = ""
            }
            
            if let existingFood = existingEntry.food {
                
                self.food = String(existingFood)
            }
            else {
                
                self.food = ""
            }
        }
        else {

            self.weight = ""
            self.food = ""
        }
    }
    
    private func refreshSummary() {
        
        let weeks: [ Date: [ DayEntry ] ] = Utils.getWeeks(days: self.entries)

        let summaries: [ Date: WeekSummary ] = Utils.getWeekSummaries(weeks: weeks)
        
        self.summaries = summaries
    }
    
    // Generic save & load
    
    
    /// Load value from the persistent store
    /// - Parameter key: variable name to find in UserDefaults
    /// - Returns: value related to a key stored in UserDefaults
    private func load<T>(key: AppStateKey) -> T? {
        
        return self.store.value(forKey: key.rawValue) as? T
    }
    
    private func save<T>(key: AppStateKey, value: T) {
        
        self.store.set(value, forKey: key.rawValue)
    }
    
    // Configuration management
    
    private func loadConfiguration() {

        if let weightUnitString: String = self.load(key: AppStateKey.weightUnit) {

            if let weightUnit = WeightUnit(rawValue: weightUnitString) {
                
                self.weightUnit = weightUnit
            }
        }
        
        if let energyUnitString: String = self.load(key: AppStateKey.energyUnit) {
            
            if let energyUnit = EnergyUnit(rawValue: energyUnitString) {
                
                self.energyUnit = energyUnit
            }
        }

        
        if let goalWeight: Double = self.load(key: AppStateKey.goalWeight) {
            self.goalWeight = goalWeight
            self.goalWeightInput = String(self.goalWeight)
        }
        
        if let goalWeeklyDelta: Double = self.load(key: AppStateKey.goalWeeklyDelta) {
            self.goalWeeklyDelta = goalWeeklyDelta
            self.goalWeeklyDeltaInput = String(self.goalWeeklyDelta)
        }

        // TODO: Always calculate?
        if let goalTargetSurplus: Int = self.load(key: AppStateKey.goalTargetSurplus) {
            self.goalTargetSurplus = goalTargetSurplus
        }
    }
    
    // MARK: - API
    
    public func changeDay(to date: Date) {
        
        self.selectedDay = date
        
        self.loadSelectedDayData(for: self.selectedDay)
    }

    public func changeEntry(date: Date, entry: DayEntry) {
        
        self.entries[date] = entry
        
        self.refreshSummary()
    }
    
    public func getEntry(date: Date) -> DayEntry? {
        
        return self.entries[date]
    }
    
    public func isDayHasData(date: Date) -> DayEntryData {
        
        if let dayEntry = self.getEntry(date: date) {
            
            return (
                dayEntry.food != nil && dayEntry.weight != nil
                    ? DayEntryData.Full
                    : DayEntryData.Partial
            )
        }
        
        return DayEntryData.Empty
    }
    
    
    // Entry update
    
    public func updateWeightInEntry() {
        
        if let formattedNumber = NumberFormatter().number(from: self.weight) {
            
            if let entry = self.getEntry(date: self.selectedDay) {
                
                self.changeEntry(
                    date: self.selectedDay,
                    entry: DayEntry(weight: formattedNumber.intValue, food: entry.food)
                )
            }
            else {

                self.changeEntry(
                    date: self.selectedDay,
                    entry: DayEntry(weight: formattedNumber.intValue, food: nil)
                )
            }
        
            self.saveEntries()
        }
    }
    
    public func updateFoodInEntry() {
        
        if let formattedNumber = NumberFormatter().number(from: self.food) {
            
            if let entry = self.getEntry(date: self.selectedDay) {
                
                self.changeEntry(
                    date: self.selectedDay,
                    entry: DayEntry(weight: entry.weight, food: formattedNumber.intValue)
                )
            }
            else {

                self.changeEntry(
                    date: self.selectedDay,
                    entry: DayEntry(weight: nil, food: formattedNumber.intValue)
                )
            }
            
            self.saveEntries()
        }
    }

    // Trends Page
    
    public func getSelectedWeekSummary() -> WeekSummary {
        
        let firstDayOfWeek = self.selectedDay.startOfWeek!
        let defaultSummary = WeekSummary(avgFood: 0, avgWeight: 0, deltaWeight: 0, tdee: 0)
        
        return self.summaries[firstDayOfWeek] ?? defaultSummary
    }
    

    // TODO: Save calculations?
    public func getTrendsChange() -> (
        avgFood: WeekSummaryChange,
        avgWeight: WeekSummaryChange,
        deltaWeight: WeekSummaryChange,
        tdee: WeekSummaryChange
    ) {
        
        let currentSummary = self.getSelectedWeekSummary()
        
        if let prevWeek = calendar.date(byAdding: .weekOfYear, value: -1, to: self.selectedDay) {

            if let prevWeekFirstDay = prevWeek.startOfWeek {

                if let prevWeekSummary = self.summaries[prevWeekFirstDay] {

                    return (
                        avgFood: Utils.getWeekSummaryParamChange(
                            previous: prevWeekSummary.avgFood,
                            current: currentSummary.avgFood
                        ),
                        avgWeight: Utils.getWeekSummaryParamChange(
                            previous: prevWeekSummary.avgWeight,
                            current: currentSummary.avgWeight
                        ),
                        deltaWeight: Utils.getWeekSummaryParamChange(
                            previous: prevWeekSummary.deltaWeight,
                            current: currentSummary.deltaWeight
                        ),
                        tdee: Utils.getWeekSummaryParamChange(
                            previous: prevWeekSummary.tdee,
                            current: currentSummary.tdee
                        )
                    )
                }
            }
        }
        
        return (
            avgFood: WeekSummaryChange.None,
            avgWeight: WeekSummaryChange.None,
            deltaWeight: WeekSummaryChange.None,
            tdee: WeekSummaryChange.None
        )
    }
    

    // Setup Page calculations
    
    
    /// Regenerate goalTargetSurplus and recommendedAmount values
    public func updateTargetSurplus() {
        
        if let currentWeekStart = Date().startOfWeek {
            
            if let currentSummary = self.summaries[currentWeekStart] {
                
                let deltaWeight: Double = self.goalWeight - currentSummary.avgWeight
                
                let weeksToGoal: Double = deltaWeight / self.goalWeeklyDelta
                
                let deltaCalories: Double = deltaWeight * Utils.CALORIES_PER_KILO
                
                self.goalTargetSurplus = Int( ( deltaCalories / weeksToGoal ) / 7 )
                
                if let currentTdee = currentSummary.tdee {

                    self.recommendedAmount = currentTdee + self.goalTargetSurplus
                }
                
                // TODO: Re-think this
                // Update goalTargetSurplus in store
                
                self.save(key: AppStateKey.goalTargetSurplus, value: self.goalTargetSurplus)
            }
        }
    }
    
    public func saveGoalWeight() {
        self.save(key: AppStateKey.goalWeight, value: self.goalWeight)
    }
    
    public func saveGoalWeeklyDelta() {
        self.save(key: AppStateKey.goalWeeklyDelta, value: self.goalWeeklyDelta)
    }
    
    public func updateWeightUnit(_ value: WeightUnit) {
        
        self.weightUnit = value
        self.save(key: AppStateKey.weightUnit, value: self.weightUnit.rawValue)
    }
    
    public func updateEnergyUnit(_ value: EnergyUnit) {
        
        self.energyUnit = value
        self.save(key: AppStateKey.energyUnit, value: self.energyUnit.rawValue)
    }
}
