//
//  AppState.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/6/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import Foundation
import SwiftUI



enum AppStateKey: String, CaseIterable {

    case Entries
    case WeightUnit, EnergyUnit
    case GoalWeight, GoalWeeklyWeightDelta
    case IsFirstSetupDone
    case ReminderWeightDate, ReminderFoodDate
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
    
    @Published var isFirstSetupDone: Bool = false
    
    @Published var messageText: String = ""
    
    // NOTE: Possible issues when user changes timezones
    @Published var selectedDay: Date

    @Published var weight: Double = 0.0
    @Published var food: Int = 0
    @Published var weightInput: String = ""
    @Published var foodInput: String = ""
    
    @Published private var entries: [ Date : DayEntry ] = [:]
    @Published private var summaries: [ Date: WeekSummary ] = [:]
    
    @Published var weightUnit: WeightUnit = WeightUnit.kg
    @Published var energyUnit: EnergyUnit = EnergyUnit.kcal
    
    @Published var goalWeight: Double = 0.0
    @Published var goalWeeklyWeightDelta: Double = 0.0
    @Published var goalWeightInput: String = ""
    @Published var goalWeeklyWeightDeltaInput: String = ""

    @Published var reminderWeightDate: Date
    @Published var reminderFoodDate: Date

    public let uiSizes: UISizes = UIConstants.getUISizes(device: UIDevice.current.name)


    public var progressData: (progressWeight: Double, goalWeight: Double, estimatedTimeLeft: Int) {
        
        let weeks: [ Date: [ DayEntry ] ] = Utils.getWeeks(days: self.entries)
        
        let weekWeights: [ Date: Double ] = weeks
            .compactMapValues { entries in
                entries.compactMap { entry in entry.weight }.average()
            }
            .filter { $0.value > 0 }
        
        let sortedWeeks = weekWeights.keys
            .sorted(by: { $0.timeIntervalSince1970 < $1.timeIntervalSince1970 })

        let startWeight = sortedWeeks.first.map { weekWeights[$0] ?? 0 } ?? 0
        let currentWeight = sortedWeeks.last.map { weekWeights[$0] ?? 0 } ?? 0
        
        // NOTE: Check is user working towards the goal, if not startWeight will be adjusted
        let isThisLoss = self.goalWeight < startWeight
        let isUserWorking = (
            ( isThisLoss && ( startWeight > currentWeight ) ) ||
            ( !isThisLoss && ( startWeight < currentWeight ) )
        )
        
        let progressWeight = ( isUserWorking ? abs(currentWeight - startWeight) : 0 )
        
        let startPoint = ( isUserWorking ? startWeight : currentWeight )
        
        let goalWeight = abs(self.goalWeight - startPoint)
        
        if self.goalWeeklyWeightDelta != 0 {

            let leftWeight = self.goalWeight - currentWeight
            let estimatedTimeLeft = abs( Int( ( leftWeight / self.goalWeeklyWeightDelta ).rounded(.up) ) )
            
            return (
                progressWeight: progressWeight,
                goalWeight: goalWeight,
                estimatedTimeLeft: estimatedTimeLeft
            )
        }
        else {
            return (
                progressWeight: progressWeight,
                goalWeight: goalWeight,
                estimatedTimeLeft: 0
            )
        }
    }
    
    
    public var goalTargetFoodDelta: Int {
        
        let weeklyFoodDelta = Utils.getEnergyFromWeight(
            weight: self.goalWeeklyWeightDelta,
            energyUnit: self.energyUnit,
            weightUnit: self.weightUnit
        )
        
        return (weeklyFoodDelta / 7)
    }
    
    public var recommendedFoodAmount: Int {
        return self.lastWeekSummary.tdee.map { $0 > 0 ? $0 + self.goalTargetFoodDelta : 0 } ?? 0
    }
    
    public var isFutureDate: Bool {
        
        let result = self.calendar.compare(self.selectedDay, to: Utils.todayDate, toGranularity: .day)
        
        return result == ComparisonResult.orderedDescending
    }

    public var selectedWeekSummary: WeekSummary {
        
        return self.selectedDay.startOfWeek
            .map { self.summaries[$0] ?? Utils.DEFAULT_SUMMARY } ?? Utils.DEFAULT_SUMMARY
    }

    public var firstWeekSummary: WeekSummary {
        
        let sortedWeeks = self.summaries.keys
            .sorted(by: { $0.timeIntervalSince1970 < $1.timeIntervalSince1970 })
        
        return sortedWeeks.first
            .map { self.summaries[$0] ?? Utils.DEFAULT_SUMMARY } ?? Utils.DEFAULT_SUMMARY
    }
    
    public var lastWeekSummary: WeekSummary {
        
        let sortedWeeks = self.summaries.keys
            .sorted(by: { $0.timeIntervalSince1970 < $1.timeIntervalSince1970 })
        
        return sortedWeeks.last
            .map { self.summaries[$0] ?? Utils.DEFAULT_SUMMARY } ?? Utils.DEFAULT_SUMMARY
    }

    public var trendsChange: WeekSummaryTrends {

        if
            let prevWeek = calendar.date(byAdding: .weekOfYear, value: -1, to: self.selectedDay),
            let prevWeekStartDate = prevWeek.startOfWeek,
            let previousSummary = self.summaries[prevWeekStartDate] {
            
            return WeekSummaryTrends(previousSummary: previousSummary, currentSummary: self.selectedWeekSummary)
        }
        else {
            
            return WeekSummaryTrends()
        }
    }
    
    public var weeklyWeightDeltas: [ Double ] {
        
        let sortedWeeks = self.summaries.keys
            .sorted(by: { $0.timeIntervalSince1970 < $1.timeIntervalSince1970 })
        
        var weeklyWeightDeltas: [ Double ] = []
        
        if let firstWeek = sortedWeeks.first, let lastWeek = sortedWeeks.last {
            
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
    
    public var firstEntryDate: Date {
        
        let sortedEntries = self.entries.keys
            .sorted(by: { $0.timeIntervalSince1970 < $1.timeIntervalSince1970 })
        
        return sortedEntries.first ?? Date()
    }

    public var isEnoughDataForRecommendation: Bool {
        
        return self.summaries.count > 1
    }

    public var todayEntry: DayEntry {
        
        return self.entries[Utils.todayDate] ?? DayEntry(weight: nil, food: nil)
    }
    


    // MARK: - Lifecycle
    
    init(store: UserDefaults = .standard) {
        
        // MARK: - Standard roperty initialization
        
        self.store = store

        self.selectedDay = Utils.todayDate
        
        // MARK: - Reminders
        
        self.reminderWeightDate = Utils.getDateFromTimeComponents(hour: 9, minute: 0) ?? Date()
        self.reminderFoodDate = Utils.getDateFromTimeComponents(hour: 21, minute: 0) ?? Date()
        
        // MARK: - Other setup
        
        self.loadExistingData()
    }

    
    // MARK: - Private

    private func loadExistingData() {

        if let isDone: Bool = self.load(key: AppStateKey.IsFirstSetupDone) {
            self.isFirstSetupDone = isDone
        }
        
        if self.isFirstSetupDone {

            // Load entries and summary
            
            self.loadEntries()
            
            self.loadSelectedDayData(for: self.selectedDay)
            
            self.refreshSummary()
            
            // Load configuration
            
            self.loadConfiguration()
            
            // Load reminders
            
            if let reminderWeightDate: Date = self.load(key: AppStateKey.ReminderWeightDate) {
                self.reminderWeightDate = reminderWeightDate
            }
            
            if let reminderFoodDate: Date = self.load(key: AppStateKey.ReminderFoodDate) {
                self.reminderFoodDate = reminderFoodDate
            }
        }
    }

    private func loadEntries() {
        
        if let savedEntriesData = self.store.data(forKey: AppStateKey.Entries.rawValue) {
            
            if let entries: [ Date : DayEntry ] = Utils.decode(data: savedEntriesData) {

                self.entries = entries
            }
        }
    }
    
    // NOTE: Do not run this on every change
    private func saveEntries() {
        
        if let encodedData = Utils.encode(data: self.entries) {
            
            self.store.set(encodedData, forKey: AppStateKey.Entries.rawValue)
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

        if let str: String = self.load(key: AppStateKey.WeightUnit), let weightUnit = WeightUnit(rawValue: str) {
                
            self.weightUnit = weightUnit
        }
        
        if let str: String = self.load(key: AppStateKey.EnergyUnit), let energyUnit = EnergyUnit(rawValue: str) {
                
            self.energyUnit = energyUnit
        }

        
        if let goalWeight: Double = self.load(key: AppStateKey.GoalWeight) {
            self.goalWeight = goalWeight
            self.goalWeightInput = String(self.goalWeight)
        }
        
        if let goalWeeklyDelta: Double = self.load(key: AppStateKey.GoalWeeklyWeightDelta) {
            self.goalWeeklyWeightDelta = goalWeeklyDelta
            self.goalWeeklyWeightDeltaInput = String(self.goalWeeklyWeightDelta)
        }
    }
    
    // MARK: - API

    private func changeEntry(date: Date, entry: DayEntry) {
        
        self.entries[date] = entry
        
        self.refreshSummary()
    }
    
    private func getEntry(date: Date) -> DayEntry? {
        
        return self.entries[date]
    }
    
    public func changeDay(to date: Date) {
        
        self.selectedDay = date
        
        self.loadSelectedDayData(for: self.selectedDay)
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

    private func updateWeightInEntry() {
        
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
    
    private func updateFoodInEntry() {
        
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

    public func updateWeightFromInput() {

        if let numberValue = NumberFormatter().number(from: self.weightInput) {
            
            let value = numberValue.doubleValue.rounded(to: 2)
            
            if Utils.isWeightValueValid(value: value, unit: self.weightUnit) {

                self.weight = value

                self.updateWeightInEntry()

                self.updateReminders(ReminderType.Weight)
            }
            else {
                
                self.showMessage(
                    text: Utils.getWeightOutsideOfValidRangeText(unit: self.weightUnit),
                    time: 3
                )
            }
        }

        self.weightInput = self.weight > 0 ? String(self.weight) : ""
    }

    public func updateEnergyFromInput() {

        if let numberValue = NumberFormatter().number(from: self.foodInput) {
            
            let value = numberValue.intValue
            
            if Utils.isFoodValueValid(value: value, unit: self.energyUnit) {

                self.food = value
                
                self.updateFoodInEntry()

                self.updateReminders(ReminderType.Food)
            }
            else {
                
                self.showMessage(
                    text: Utils.getFoodOutsideOfValidRangeText(unit: self.energyUnit),
                    time: 3
                )
            }
        }

        self.foodInput = self.food > 0 ? String(self.food) : ""
    }
    
    // MARK: - Setup Page calculations
    
    private func saveGoalWeight() {
        self.save(key: AppStateKey.GoalWeight, value: self.goalWeight)
    }

    private func saveGoalWeeklyDelta() {
        self.save(key: AppStateKey.GoalWeeklyWeightDelta, value: self.goalWeeklyWeightDelta)
    }

    public func saveGoalWeightFromInput() {
        
        if let numberValue = NumberFormatter().number(from: self.goalWeightInput) {
            
            let value = numberValue.doubleValue.rounded(to: 2)
            
            if Utils.isWeightValueValid(value: value, unit: self.weightUnit) {

                self.goalWeight = value
                
                self.saveGoalWeight()
            }
            else {
                
                self.showMessage(
                    text: Utils.getWeightOutsideOfValidRangeText(unit: self.weightUnit),
                    time: 3
                )
            }
        }

        self.goalWeightInput = self.goalWeight > 0 ? String(self.goalWeight) : ""
    }

    public func saveGoalWeeklyDeltaFromInput() {

        if let numberValue = NumberFormatter().number(from: self.goalWeeklyWeightDeltaInput) {
            
            let value = numberValue.doubleValue.rounded(to: 2)
            
            if Utils.isWeeklyWeightDeltaValueValid(value: value, unit: self.weightUnit) {

                self.goalWeeklyWeightDelta = value

                self.saveGoalWeeklyDelta()
            }
            else {
                
                self.showMessage(
                    text: Utils.getDeltaWeightOutsideOfValidRangeText(unit: self.weightUnit),
                    time: 3
                )
            }
        }

        self.goalWeeklyWeightDeltaInput = self.goalWeeklyWeightDelta >= 0 ? String(self.goalWeeklyWeightDelta) : ""
    }
    
    public func updateWeightUnit(_ newValue: WeightUnit) {
        
        let oldValue = self.weightUnit
        self.weightUnit = newValue
        
        // NOTE: Convert existing weight data
        self.entries = Utils.convertWeightInEntries(entries: self.entries, from: oldValue, to: newValue)
        self.goalWeight = Utils.convertWeight(value: self.goalWeight, from: oldValue, to: newValue)
        self.goalWeeklyWeightDelta = Utils.convertWeight(value: self.goalWeeklyWeightDelta, from: oldValue, to: newValue)
        
        // NOTE: Save existing weight data
        self.saveEntries()
        self.saveGoalWeight()
        self.saveGoalWeeklyDelta()
        self.save(key: AppStateKey.WeightUnit, value: self.weightUnit.rawValue)
        
        // NOTE: It's possible to optimize unit switch, but you'll have to update inputs and few other vars manually
        // NOTE: While dropping loadExistingData() hard reset, it'll create a weak point here for any new variable
        self.loadExistingData()
    }
    
    public func updateEnergyUnit(_ newValue: EnergyUnit) {
        
        let oldValue = self.energyUnit
        self.energyUnit = newValue

        // NOTE: Convert existing energy data
        self.entries = Utils.convertEnergyInEntries(entries: self.entries, from: oldValue, to: newValue)
        
        // NOTE: Save existing energy data
        self.saveEntries()
        self.save(key: AppStateKey.EnergyUnit, value: self.energyUnit.rawValue)

        // NOTE: It's possible to optimize unit switch, but you'll have to update inputs and few other vars manually
        // NOTE: While dropping loadExistingData() hard reset, it'll create a weak point here for any new variable
        self.loadExistingData()
    }
    
    // MARK: - Welcome Page setup
    
    /// No need for recalculatios since there should be no data during setup phase
    public func setUnits(weightUnit: WeightUnit?, energyUnit: EnergyUnit?) {
        
        if let wu = weightUnit, let eu = energyUnit {
            
            self.weightUnit = wu
            self.energyUnit = eu
        }
    }
    
    public func completeFirstSetup() {
        
        self.isFirstSetupDone = true
        
        self.save(key: AppStateKey.IsFirstSetupDone, value: self.isFirstSetupDone)
        
        self.updateReminders()
    }

    // MARK: - Reminders
    
    private func getNextDateTimeComponents(hasEntry: Bool, time: Date) -> DateComponents {
    
        let nextNotificationDay = (
            hasEntry ? calendar.date(byAdding: .day, value: 1, to: Utils.todayDate) ?? Date() : Date()
        )
    
        let nextDateComponents = self.calendar.dateComponents([ .year, .month, .day ], from: nextNotificationDay)
        let nextTimeComponents = self.calendar.dateComponents([ .hour, .minute ], from: time)
        
        return DateComponents(
            year: nextDateComponents.year,
            month: nextDateComponents.month,
            day: nextDateComponents.day,
            hour: nextTimeComponents.hour,
            minute: nextTimeComponents.minute
        )
    }
    
    private func saveWeightReminder(weight: Double?) {
        
        let nextDateTimeComponents = self.getNextDateTimeComponents(
            hasEntry: (weight != nil),
            time: self.reminderWeightDate
        )
        
        if let nextDateTime = self.calendar.date(from: nextDateTimeComponents) {
            self.reminderWeightDate = nextDateTime
        }

        self.save(key: AppStateKey.ReminderWeightDate, value: self.reminderWeightDate)
        
        NotificationManager.updateNotificationTime(
            dateComponents: nextDateTimeComponents,
            type: ReminderType.Weight
        )
    }
    
    private func saveFoodReminder(food: Int?) {

        let nextDateTimeComponents = self.getNextDateTimeComponents(
            hasEntry: (food != nil),
            time: self.reminderFoodDate
        )
        
        if let nextDateTime = self.calendar.date(from: nextDateTimeComponents) {
            self.reminderFoodDate = nextDateTime
        }

        self.save(key: AppStateKey.ReminderFoodDate, value: self.reminderFoodDate)
        
        NotificationManager.updateNotificationTime(
            dateComponents: nextDateTimeComponents,
            type: ReminderType.Food
        )
    }

    public func updateReminders(_ reminderToUpdate: ReminderType? = nil) {
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        if self.isFirstSetupDone {
            
            switch reminderToUpdate {
                case Optional(ReminderType.Weight):
                    self.saveWeightReminder(weight: self.todayEntry.weight)
                case Optional(ReminderType.Food):
                    self.saveFoodReminder(food: self.todayEntry.food)
                default:
                    self.saveWeightReminder(weight: self.todayEntry.weight)
                    self.saveFoodReminder(food: self.todayEntry.food)
            }
        }
    }

    // MARK: - Other
    
    private func showMessage(text: String, time: TimeInterval) {
        
        self.messageText = text
        
        Timer.scheduledTimer(withTimeInterval: time, repeats: false, block: { _ in
            self.messageText = ""
        })
    }
}