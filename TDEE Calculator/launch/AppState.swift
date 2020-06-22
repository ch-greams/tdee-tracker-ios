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
    case goalWeight, goalWeeklyDelta
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

    @Published var weight: Double = 0.0
    @Published var food: Int = 0
    
    @Published var weightInput: String = ""
    @Published var foodInput: String = ""
    
    @Published private var entries: [ Date : DayEntry ] = [:]
    
    @Published var summaries: [ Date: WeekSummary ] = [:]
    
    @Published var weightUnit: WeightUnit = WeightUnit.kg
    @Published var energyUnit: EnergyUnit = EnergyUnit.kcal
    
    @Published var goalWeight: Double = 0.0
    @Published var goalWeeklyDelta: Double = 0.0
    
    @Published var goalWeightInput: String = "0.0"
    @Published var goalWeeklyDeltaInput: String = "0.0"

    // NOTE: Not stored in UserDefaults created using refreshGoalBasedValues()
    @Published var recommendedFoodAmount: Int = 0
    @Published var goalTargetFoodSurplus: Int = 0

    @Published var startWeight: Double = 0.0
    @Published var currentWeight: Double = 0.0
    @Published var estimatedTimeLeft: Int = 0
    
    @Published var weeklyWeightDeltas: [ Double ] = []

    // MARK: - Lifecycle
    
    init(store: UserDefaults = .standard) {
        
        // MARK: - Standard roperty initialization
        
        self.store = store

        let dayScope = calendar.dateComponents([.year, .month, .day], from: Date())
        self.selectedDay = calendar.date(from: dayScope)!
        
        // MARK: - Other setup
        
        self.loadAllStuff()
    }

    
    // MARK: - Private

    // TODO: Some optimization?
    private func loadAllStuff() {

        // Load entries and summary
        
        self.loadEntries()
        
        self.loadSelectedDayData(for: self.selectedDay)
        
        self.refreshSummary()
        
        // Load configuration
        
        self.loadConfiguration()
        
        // Progress page values
        
        self.estimatedTimeLeft = self.getEstimatedTimeLeft(
            goalWeight: self.goalWeight,
            currentWeight: self.currentWeight,
            goalWeeklyDelta: self.goalWeeklyDelta
        )
    }

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
                
                self.weight = existingWeight
                self.weightInput = String(existingWeight)
            }
            else {

                self.weight = 0.0
                self.weightInput = ""
            }
            
            if let existingFood = existingEntry.food {
                
                self.food = existingFood
                self.foodInput = String(existingFood)
            }
            else {
                
                self.food = 0
                self.foodInput = ""
            }
        }
        else {
            
            self.weight = 0.0
            self.weightInput = ""
            self.food = 0
            self.foodInput = ""
        }
    }
    
    private func refreshSummary() {
        
        let weeks: [ Date: [ DayEntry ] ] = Utils.getWeeks(days: self.entries)

        let summaries: [ Date: WeekSummary ] = Utils.getWeekSummaries(
            weeks: weeks,
            energyUnit: self.energyUnit,
            weightUnit: self.weightUnit
        )
        
        self.summaries = summaries
        
        self.weeklyWeightDeltas = self.getWeeklyWeightDeltas()
        
        self.startWeight = self.getFirstWeekSummary().avgWeight
        self.currentWeight = self.getLastWeekSummary().avgWeight
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

        self.refreshGoalBasedValues()
    }
    
    // MARK: - API
    
    public func changeDay(to date: Date) {
        
        self.selectedDay = date
        
        self.loadSelectedDayData(for: self.selectedDay)
    }

    public func changeEntry(date: Date, entry: DayEntry) {
        
        self.entries[date] = entry
        
        self.refreshSummary()
        
        self.refreshGoalBasedValues()
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
    
    
    // MARK: - Entry update
    
    public func updateWeightInEntry() {
        
        if let entry = self.getEntry(date: self.selectedDay) {
            
            self.changeEntry(
                date: self.selectedDay,
                entry: DayEntry(weight: self.weight, food: entry.food)
            )
        }
        else {

            self.changeEntry(
                date: self.selectedDay,
                entry: DayEntry(weight: self.weight, food: nil)
            )
        }
    
        self.saveEntries()
    }
    
    public func updateFoodInEntry() {
        
        if let entry = self.getEntry(date: self.selectedDay) {
            
            self.changeEntry(
                date: self.selectedDay,
                entry: DayEntry(weight: entry.weight, food: self.food)
            )
        }
        else {

            self.changeEntry(
                date: self.selectedDay,
                entry: DayEntry(weight: nil, food: self.food)
            )
        }
        
        self.saveEntries()
    }

    // MARK: - Trends Page
    
    public func getSelectedWeekSummary() -> WeekSummary {
        
        let firstDayOfWeek = self.selectedDay.startOfWeek!
        
        return self.summaries[firstDayOfWeek] ?? Utils.DEFAULT_SUMMARY
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
    
    // MARK: - Progress Page
    
    // TODO: Merge getFirst and getLast into setProgressValues ?
    public func getFirstWeekSummary() -> WeekSummary {
        
        let sortedWeeks = self.summaries.keys
            .sorted(by: { $0.timeIntervalSince1970 < $1.timeIntervalSince1970 })
        
        if let firstDayOfWeek = sortedWeeks.first {
            return self.summaries[firstDayOfWeek] ?? Utils.DEFAULT_SUMMARY
        }
        else {
            return Utils.DEFAULT_SUMMARY
        }
    }
    
    public func getLastWeekSummary() -> WeekSummary {
        
        let sortedWeeks = self.summaries.keys
            .sorted(by: { $0.timeIntervalSince1970 < $1.timeIntervalSince1970 })
        
        if let firstDayOfWeek = sortedWeeks.last {
            return self.summaries[firstDayOfWeek] ?? Utils.DEFAULT_SUMMARY
        }
        else {
            return Utils.DEFAULT_SUMMARY
        }
    }
    
    public func getEstimatedTimeLeft(
        goalWeight: Double,
        currentWeight: Double,
        goalWeeklyDelta: Double
    ) -> Int {

        let leftWeight = goalWeight - currentWeight

        let estimatedTimeLeft = (
            goalWeeklyDelta != 0
                ? Int( ( leftWeight / goalWeeklyDelta ).rounded(.up) )
                : 0
        )
        
        return estimatedTimeLeft
    }
    
    public func getWeeklyWeightDeltas() -> [ Double ] {
        
        let sortedWeeks = self.summaries.keys
            .sorted(by: { $0.timeIntervalSince1970 < $1.timeIntervalSince1970 })
        
        var weeklyWeightDeltas: [ Double ] = []
        
        if sortedWeeks.count > 0 {
            
            let firstWeek = sortedWeeks.first!
            let lastWeek = sortedWeeks.last!
            
            let components = self.calendar.dateComponents([.weekOfYear], from: firstWeek, to: lastWeek)
            let weekCount = components.weekOfYear ?? 0

            if weekCount > 0 {
                
                var weekDates: [ Date ] = []
                
                // NOTE: Start from 1 to skip first week, since there'll be no delta
                for iWeek in 1 ... weekCount {
                    
                    if let curWeek = calendar.date(byAdding: .weekOfYear, value: iWeek, to: firstWeek) {
                        
                        weekDates.append(curWeek)
                    }
                }
                
                for weekDate in weekDates {
                    
                    let summary = self.summaries[weekDate] ?? Utils.DEFAULT_SUMMARY
                    
                    weeklyWeightDeltas.append(summary.deltaWeight ?? 0)
                }
            }
        }

        return weeklyWeightDeltas
    }
    
    // MARK: - Setup Page calculations
    
    // TODO: Move statics to Utils
    
    private static func getCurrentSummary(summaries: [Date : WeekSummary], today: Date) -> WeekSummary? {
        
        if let currentWeekStart = today.startOfWeek {
            
            if let currentSummary = summaries[currentWeekStart] {
                
                return currentSummary
            }
        }
        
        return nil
    }
    
    private static func getGoalTargetSurplus(
        currentSummary: WeekSummary,
        goalWeight: Double,
        goalWeeklyDelta: Double,
        energyUnit: EnergyUnit,
        weightUnit: WeightUnit
    ) -> Int {
        
        let deltaWeight: Double = goalWeight - currentSummary.avgWeight
        
        let weeksToGoal: Double = deltaWeight / goalWeeklyDelta
        
        let deltaCalories = Utils.getEnergyFromWeight(
            weight: deltaWeight,
            energyUnit: energyUnit,
            weightUnit: weightUnit
        )
        
        return Int( ( Double(deltaCalories) / weeksToGoal ) / 7 )
    }
    
    private static func getRecommendedAmount(
        currentSummary: WeekSummary,
        goalTargetSurplus: Int
    ) -> Int {

        if let currentTdee = currentSummary.tdee {

            return currentTdee + goalTargetSurplus
        }
        
        return 0
    }
    
    /// Regenerate goalTargetSurplus and recommendedAmount values
    public func refreshGoalBasedValues() {
        
        if let currentSummary = Self.getCurrentSummary(summaries: self.summaries, today: Date()) {
            
            self.goalTargetFoodSurplus = Self.getGoalTargetSurplus(
                currentSummary: currentSummary,
                goalWeight: self.goalWeight,
                goalWeeklyDelta: self.goalWeeklyDelta,
                energyUnit: self.energyUnit,
                weightUnit: self.weightUnit
            )
            
            self.recommendedFoodAmount = Self.getRecommendedAmount(
                currentSummary: currentSummary,
                goalTargetSurplus: self.goalTargetFoodSurplus
            )
            
            self.estimatedTimeLeft = self.getEstimatedTimeLeft(
                goalWeight: self.goalWeight,
                currentWeight: self.currentWeight,
                goalWeeklyDelta: self.goalWeeklyDelta
            )
        }
    }
    
    public func saveGoalWeight() {
        self.save(key: AppStateKey.goalWeight, value: self.goalWeight)
    }
    
    public func saveGoalWeeklyDelta() {
        self.save(key: AppStateKey.goalWeeklyDelta, value: self.goalWeeklyDelta)
    }
    
    public func updateWeightUnit(_ newValue: WeightUnit) {
        
        let oldValue = self.weightUnit
        self.weightUnit = newValue
        
        // TODO: Convert existing data
        
        self.entries = Utils.convertWeightInEntries(entries: self.entries, from: oldValue, to: newValue)
        
        self.goalWeight = Utils.convertWeight(value: self.goalWeight, from: oldValue, to: newValue)
        self.goalWeeklyDelta = Utils.convertWeight(value: self.goalWeeklyDelta, from: oldValue, to: newValue)
        
        self.saveEntries()

        self.saveGoalWeight()
        self.saveGoalWeeklyDelta()

        self.save(key: AppStateKey.weightUnit, value: self.weightUnit.rawValue)
        
        // TODO: Optimize refresh?
        self.loadAllStuff()
    }
    
    public func updateEnergyUnit(_ newValue: EnergyUnit) {
        
        let oldValue = self.energyUnit
        self.energyUnit = newValue
        
        // TODO: Convert existing data

        self.entries = Utils.convertEnergyInEntries(entries: self.entries, from: oldValue, to: newValue)

        self.saveEntries()
        
        self.save(key: AppStateKey.energyUnit, value: self.energyUnit.rawValue)

        // TODO: Optimize refresh?
        self.loadAllStuff()
    }
}
