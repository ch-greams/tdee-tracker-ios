//
//  AppState.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/6/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import Foundation
import SwiftUI
import StoreKit
import HealthKit



enum AppStateKey: String, CaseIterable {

    case Entries
    case WeightUnit, EnergyUnit
    case GoalWeight, GoalWeeklyWeightDelta
    case IsFirstSetupDone
    case ReminderWeightDate, ReminderFoodDate
    case CurrentTheme
    case TutorialStep

    case IsPremiumVersion
}

protocol Localizable {
    var localized: String { get }
}

enum WeightUnit: String, Equatable, Localizable {
    case kg = "KG"
    case lb = "LB"
    
    var localized: String {
        self.rawValue.localize
    }
}

enum EnergyUnit: String, Equatable, Localizable {
    case kcal = "KCAL"
    case kj = "KJ"
    
    var localized: String {
        self.rawValue.localize
    }
}



class AppState: ObservableObject {
    
    private let calendar = Calendar.current

    private let store: UserDefaults
    
    @Published public var currentInput: InputName?
    
    @Published public var isFirstSetupDone: Bool = false
    @Published public var tutorialStep: TutorialStep = TutorialStep.First
    
    @Published public var messageText: String = ""
    
    // NOTE: Possible issues when user changes timezones
    @Published public var selectedDay: Date

    @Published public var weight: Double = 0.0
    @Published public var food: Int = 0
    @Published public var weightInput: String = ""
    @Published public var foodInput: String = ""
    
    @Published private var entries: [ Date : DayEntry ] = [:] {
        didSet { self.refreshSummary() }
    }
    @Published private var summaries: [ Date : WeekSummary ] = [:]
    
    @Published public var weightUnit: WeightUnit = WeightUnit.kg
    @Published public var energyUnit: EnergyUnit = EnergyUnit.kcal
    
    @Published public var goalWeight: Double = 0.0
    @Published public var goalWeeklyWeightDelta: Double = 0.0
    @Published public var goalWeightInput: String = ""
    @Published public var goalWeeklyWeightDeltaInput: String = ""

    @Published public var reminderWeightDate: Date {
        didSet {
            self.reminderWeightDateInput = self.reminderWeightDate.timeString
        }
    }
    @Published public var reminderFoodDate: Date {
        didSet {
            self.reminderFoodDateInput = self.reminderFoodDate.timeString
        }
    }
    @Published public var reminderWeightDateInput: String = ""
    @Published public var reminderFoodDateInput: String = ""
    
    @Published public var showLoader: Bool = false
    @Published public var loaderText: String = ""
    
    @Published public var showBuyModal: Bool = false
    
    @Published public var isPremiumVersion: Bool = false
    @Published public var currentTheme: UIThemeType = UIThemeType.Default

    public var uiTheme: UITheme = UIThemeManager.getUITheme(theme: UIThemeType.Default)
    

    public var areWeightEntriesLoaded: Bool = false {
        didSet {
            DispatchQueue.main.async {
                
                if self.areWeightEntriesLoaded {
                    
                    for (date, weight) in HealthStoreManager.weightEntries {
                        
                        if let entry = self.entries[date.withoutTime] {
                            
                            if entry.weight == nil {
                                
                                self.entries[date.withoutTime] = DayEntry(weight: weight, food: entry.food)
                            }
                        }
                        else {
                            self.entries[date.withoutTime] = DayEntry(weight: weight, food: nil)
                        }
                    }
                    
                    self.saveEntries()
                    self.loadSelectedDayData(for: self.selectedDay)
                }
                else {
                    HealthStoreManager.fetchWeightData()
                }
            }
            
        }
    }
    public var areEnergyEntriesLoaded: Bool = false {
        didSet {
            DispatchQueue.main.async {
                
                if self.areEnergyEntriesLoaded {
                    
                    for (date, food) in HealthStoreManager.energyEntries {
                        
                        if let entry = self.entries[date.withoutTime] {
                            
                            if entry.food == nil {
                                
                                self.entries[date.withoutTime] = DayEntry(weight: entry.weight, food: food)
                            }
                        }
                        else {
                            self.entries[date.withoutTime] = DayEntry(weight: nil, food: food)
                        }
                    }
                    
                    self.saveEntries()
                    self.loadSelectedDayData(for: self.selectedDay)
                }
                else {
                    HealthStoreManager.fetchEnergyData()
                }
            }
        }
    }

    
    public var progressData: (
        progressWeight: Double,
        goalWeight: Double,
        isSurplus: Bool,
        estimatedTimeLeft: Int
    ) {
        
        let weekWeights: [ Date: Double ] = Utils.getWeeks(days: self.entries)
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
                isSurplus: !isThisLoss,
                estimatedTimeLeft: estimatedTimeLeft
            )
        }
        else {
            return (
                progressWeight: progressWeight,
                goalWeight: goalWeight,
                isSurplus: !isThisLoss,
                estimatedTimeLeft: 0
            )
        }
    }
    
    private var isSurplus: Bool {
        
        let weekWeights: [ Date : Double ] = Utils.getWeeks(days: self.entries)
            .compactMapValues { $0.compactMap { entry in entry.weight }.average() }
            .filter { $0.value > 0 }
        
        let sortedWeeks = weekWeights.keys
            .sorted(by: { $0.timeIntervalSince1970 < $1.timeIntervalSince1970 })
        
        let startWeight = sortedWeeks.first.map { weekWeights[$0] ?? 0 } ?? 0
        
        return self.goalWeight >= startWeight
    }
    
    public var goalTargetFoodDelta: Int {
        
        let weeklyFoodDelta = Utils.getEnergyFromWeight(
            weight: self.goalWeeklyWeightDelta,
            energyUnit: self.energyUnit,
            weightUnit: self.weightUnit
        )
        
        return ( self.isSurplus ? 1 : -1 ) * ( weeklyFoodDelta / 7 )
    }
    
    public var recommendedFoodAmount: Int {
        return self.lastWeekSummary.tdee.map { $0 > 0 ? $0 + self.goalTargetFoodDelta : 0 } ?? 0
    }
    
    public var isFutureDate: Bool {
        
        let result = self.calendar.compare(self.selectedDay, to: Date.today, toGranularity: .day)
        
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
        
        return self.entries[Date.today] ?? DayEntry(weight: nil, food: nil)
    }
    


    // MARK: - Lifecycle
    
    init(store: UserDefaults = .standard) {
        
        // MARK: - Standard roperty initialization
        
        self.store = store

        self.selectedDay = Date.today
        
        // MARK: - Reminders
        
        self.reminderWeightDate = Utils.getDateFromTimeComponents(hour: 9, minute: 0) ?? Date()
        self.reminderFoodDate = Utils.getDateFromTimeComponents(hour: 21, minute: 0) ?? Date()
        
        // MARK: - Other setup
        
        HealthStoreManager.appState = self
        
        StoreManager.shared.delegate = self
        StoreObserver.shared.delegate = self
        
        self.loadExistingData()
    }

    
    // MARK: - Private

    private func loadExistingData() {

        if let isDone: Bool = self.load(key: AppStateKey.IsFirstSetupDone) {
            self.isFirstSetupDone = isDone
        }
        
        if self.isFirstSetupDone {
            
            // Load tutorial progress
            
            if let num: Int = self.load(key: AppStateKey.TutorialStep), let step = TutorialStep(rawValue: num) {
                    
                self.tutorialStep = step
            }

            // Load entries and summary
            
            self.loadEntries()
            
            self.loadSelectedDayData(for: self.selectedDay)
            
            // Load configuration
            
            self.loadConfiguration()
            
            // Load reminders
            
            if let reminderWeightDate: Date = self.load(key: AppStateKey.ReminderWeightDate) {
                self.reminderWeightDate = reminderWeightDate
            }
            
            if let reminderFoodDate: Date = self.load(key: AppStateKey.ReminderFoodDate) {
                self.reminderFoodDate = reminderFoodDate
            }
            
            // Load isPremium
            
            if let isPremiumVersion: Bool = self.load(key: AppStateKey.IsPremiumVersion) {
                self.isPremiumVersion = isPremiumVersion
            }
            
            // Load theme
            
            if let str: String = self.load(key: AppStateKey.CurrentTheme), let theme = UIThemeType(rawValue: str) {
                    
                self.currentTheme = theme
                self.uiTheme = UIThemeManager.getUITheme(theme: self.currentTheme)
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
                self.weightInput = existingWeight.toString()
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
            self.goalWeightInput = self.goalWeight.toString()
        }
        
        if let goalWeeklyDelta: Double = self.load(key: AppStateKey.GoalWeeklyWeightDelta) {
            self.goalWeeklyWeightDelta = goalWeeklyDelta
            self.goalWeeklyWeightDeltaInput = self.goalWeeklyWeightDelta.toString()
        }
    }
    
    // MARK: - API

    public func changeDay(to date: Date) {
        
        self.selectedDay = date
        
        self.loadSelectedDayData(for: self.selectedDay)
    }

    public func isDayHasData(date: Date) -> DayEntryData {

        guard let dayEntry = self.entries[date] else { return DayEntryData.Empty }
        
        if dayEntry.food != nil && dayEntry.weight != nil {
            return DayEntryData.Full
        }
        else if dayEntry.food != nil || dayEntry.weight != nil {
            return DayEntryData.Partial
        }
        else {
            return DayEntryData.Empty
        }
    }

    // MARK: - Entry update

    private func updateWeightInEntry(_ weight: Double? = nil) {
        
        self.entries[self.selectedDay] = DayEntry(
            weight: weight,
            food: self.entries[self.selectedDay]?.food
        )
    
        self.saveEntries()
    }
    
    private func updateFoodInEntry(_ food: Int? = nil) {
        
        self.entries[self.selectedDay] = DayEntry(
            weight: self.entries[self.selectedDay]?.weight,
            food: food
        )
        
        self.saveEntries()
    }

    public func updateWeightFromInput() {

        if let numberValue = NumberFormatter().number(from: self.weightInput) {
            
            let value = numberValue.doubleValue.rounded(to: 2)
            
            if Utils.isWeightValueValid(value: value, unit: self.weightUnit) {

                self.weight = value

                self.updateWeightInEntry(self.weight)

                self.updateReminders(ReminderType.Weight)
            }
            else {
                
                self.showMessage(
                    text: Utils.getWeightOutsideOfValidRangeText(unit: self.weightUnit),
                    time: 3
                )
            }
        }
        else {
            
            self.weight = 0.0
            
            self.updateWeightInEntry()
            
            self.updateReminders(ReminderType.Weight)
        }
        
        HealthStoreManager.addEntry(
            type: HealthStoreManager.WEIGHT_ID,
            date: self.selectedDay,
            value: (
                self.weight > 0
                    ? Utils.convertWeight(value: self.weight, from: self.weightUnit, to: WeightUnit.kg)
                    : nil
            )
        )
        
        if self.weight == 0.0 {
            self.areWeightEntriesLoaded = false
        }

        self.weightInput = self.weight > 0 ? self.weight.toString() : ""
    }

    public func updateEnergyFromInput() {

        if let numberValue = NumberFormatter().number(from: self.foodInput) {
            
            let value = numberValue.intValue
            
            if Utils.isFoodValueValid(value: value, unit: self.energyUnit) {

                self.food = value
                
                self.updateFoodInEntry(self.food)

                self.updateReminders(ReminderType.Food)
            }
            else {
                
                self.showMessage(
                    text: Utils.getFoodOutsideOfValidRangeText(unit: self.energyUnit),
                    time: 3
                )
            }
        }
        else {

            self.food = 0
            
            self.updateFoodInEntry()
            
            self.updateReminders(ReminderType.Food)
        }
        
        HealthStoreManager.addEntry(
            type: HealthStoreManager.ENERGY_ID,
            date: self.selectedDay,
            value: (
                self.food > 0
                    ? Double(Utils.convertEnergy(value: self.food, from: self.energyUnit, to: EnergyUnit.kcal))
                    : nil
            )
        )
        
        if self.food == 0 {
            self.areEnergyEntriesLoaded = false
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

        self.goalWeightInput = self.goalWeight > 0 ? self.goalWeight.toString() : ""
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

        self.goalWeeklyWeightDeltaInput = (
            self.goalWeeklyWeightDelta >= 0 ? self.goalWeeklyWeightDelta.toString() : ""
        )
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
    
    public func saveWeightReminderDateFromInput() {
        
        if let format = DateFormatter.dateFormat(fromTemplate: "jm", options: 0, locale: Locale.current),
           let date = Date.from(self.reminderWeightDateInput, format: format) {
            
            self.reminderWeightDate = date
            
            self.saveWeightReminder()
        }
        else {
            self.reminderWeightDateInput = self.reminderWeightDate.timeString
        }
    }
    
    public func saveFoodReminderDateFromInput() {
        
        if let format = DateFormatter.dateFormat(fromTemplate: "jm", options: 0, locale: Locale.current),
           let date = Date.from(self.reminderFoodDateInput, format: format) {
            
            self.reminderFoodDate = date
            
            self.saveFoodReminder()
        }
        else {
            self.reminderFoodDateInput = self.reminderFoodDate.timeString
        }
    }
    
    private func getNextDateTimeComponents(hasEntry: Bool, time: Date) -> DateComponents {
    
        let nextNotificationDay = (
            hasEntry ? calendar.date(byAdding: .day, value: 1, to: Date.today) ?? Date() : Date()
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
    
    private func saveWeightReminder() {
        
        let nextDateTimeComponents = self.getNextDateTimeComponents(
            hasEntry: self.todayEntry.weight != nil,
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
    
    private func saveFoodReminder() {

        let nextDateTimeComponents = self.getNextDateTimeComponents(
            hasEntry: self.todayEntry.food != nil,
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
                    self.saveWeightReminder()
                case Optional(ReminderType.Food):
                    self.saveFoodReminder()
                default:
                    self.saveWeightReminder()
                    self.saveFoodReminder()
            }
        }
    }

    // MARK: - Other
    
    public func hideMessage() {
        
        self.messageText = ""
    }
    
    private func showMessage(text: String, time: TimeInterval) {
        
        self.messageText = text
        
        Timer.scheduledTimer(
            withTimeInterval: time,
            repeats: false,
            block: { _ in self.hideMessage() }
        )
    }
    
    
    private func showLoader(text: String = "") {
        
        self.loaderText = text
        self.showLoader = true
    }
    
    private func hideLoader() {
        
        self.showLoader = false
        self.loaderText = ""
    }
    
    public func nextTutorialStep() {
        
        self.tutorialStep = self.tutorialStep.next
        self.save(key: AppStateKey.TutorialStep, value: self.tutorialStep.rawValue)
    }
    
    public func saveTheme(_ theme: UIThemeType) {
        
        self.currentTheme = theme
        self.save(key: AppStateKey.CurrentTheme, value: self.currentTheme.rawValue)
        
        self.uiTheme = UIThemeManager.getUITheme(theme: self.currentTheme)
    }
    
    public func unlockTheme() {
        
        if StoreManager.shared.areProductsLoaded {
            
            self.showLoader(text: Label.tryRestore)
            
            StoreObserver.shared.restore()
        }
        else if StoreObserver.shared.isAuthorizedForPayments {
            
            self.showLoader(text: Label.fetchProducts)
            
            StoreManager.shared.fetchProducts(identifiers: ProductIds.allCases.map { $0.rawValue })
        }
        else {

            self.showMessage(text: Label.notAuthorized, time: 10)
        }
    }
    
    public func buyPremiumModal(isOpen: Bool) {
        
        self.showBuyModal = isOpen
    }
    
    public func buyPremium() {
        
        if let product = StoreManager.shared.products[StoreManager.shared.PREMIUM_PRODUCT_ID] {
            
            self.showLoader(text: Label.tryPurchase)
            
            StoreObserver.shared.buy(product)
        }
    }
    
    private func confirmPurchaseOfPremium(productId: ProductIdentifier) {
        
        if productId == StoreManager.shared.PREMIUM_PRODUCT_ID {
            
            self.isPremiumVersion = true
            self.save(key: AppStateKey.IsPremiumVersion, value: self.isPremiumVersion)
            
            self.hideLoader()
        }
    }
}

// MARK: - StoreManagerDelegate

extension AppState: StoreManagerDelegate {
    
    public func storeManagerRequestResponse(_ response: [ ProductIdentifier : SKProduct ]) {

        Utils.log(source: "storeManagerDidReceiveResponse")
        
        for product in response.values {

            Utils.log(
                source: "storeManagerDidReceiveResponse",
                message: "Product: \(product.localizedTitle) \(product.price)"
            )
        }
        
        self.showLoader(text: Label.tryRestore)
        
        StoreObserver.shared.restore()
    }
    
    public func storeManagerRequestError(_ message: String) {
        
        Utils.log(source: "storeManagerRequestError", message: message)
        
        self.showMessage(
            text: "\(Label.productRequestError):\n\(message)",
            time: 8
        )
        
        self.hideLoader()
    }
}

// MARK: - StoreObserverDelegate

extension AppState: StoreObserverDelegate {
    
    // MARK: - Restore
    
    public func storeObserverFinishedRestore() {
        
        Utils.log(source: "storeObserverFinishedRestore")
        
        if !self.isPremiumVersion {

            self.buyPremiumModal(isOpen: true)
        }
        
        self.hideLoader()
    }
    
    public func storeObserverCompletedRestoreOf(product: ProductIdentifier) {
        
        Utils.log(source: "storeObserverCompletedRestoreOf", message: product)
        
        self.confirmPurchaseOfPremium(productId: product)
    }
    
    public func storeObserverCancelledRestore() {
        
        Utils.log(source: "storeObserverCancelledRestore")
        
        self.hideLoader()
    }

    public func storeObserverFailedRestore(_ message: String) {
        
        Utils.log(source: "storeObserverFailedRestore", message: message)
        
        self.showMessage(text: message, time: 10)
        
        self.hideLoader()
    }
    
    // MARK: - Purchase
    
    public func storeObserverCompletedPurchaseOf(product: ProductIdentifier) {
        
        Utils.log(source: "storeObserverCompletedPurchaseOf", message: product)
        
        self.confirmPurchaseOfPremium(productId: product)
    }
    
    public func storeObserverCancelledPurchase() {
        
        Utils.log(source: "storeObserverCancelledPurchase")
        
        self.hideLoader()
    }
    
    public func storeObserverFailedPurchase(_ message: String) {
        
        Utils.log(source: "storeObserverFailedPurchase", message: message)

        self.showMessage(text: message, time: 10)
        
        self.hideLoader()
    }
}
