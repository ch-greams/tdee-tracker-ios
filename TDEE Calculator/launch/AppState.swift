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

    case entries

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

    
    public func getSelectedWeekSummary() -> WeekSummary {
        
        let firstDayOfWeek = self.selectedDay.startOfWeek!
        
        return self.summaries[firstDayOfWeek] ?? WeekSummary(avgFood: 0, avgWeight: 0, deltaWeight: 0, tdee: 0)
    }
}
