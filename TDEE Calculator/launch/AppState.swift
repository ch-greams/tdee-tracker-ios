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
    
    
     // MARK: - Lifecycle
    
    init(store: UserDefaults = .standard) {
        
        // MARK: - Standard roperty initialization
        
        self.store = store

        let dayScope = calendar.dateComponents([.year, .month, .day], from: Date())
        self.selectedDay = calendar.date(from: dayScope)!
        
        // MARK: - Other setup
        
        self.loadEntries()
        
        self.loadSelectedDayData(for: self.selectedDay)
    }
    
    // MARK: - Private
    
    private func loadEntries() {
        
        if let savedEntriesData = self.store.data(forKey: AppStateKey.entries.rawValue) {
            
            if let entries: [ Date : DayEntry ] = Self.decode(data: savedEntriesData) {

                self.entries = entries
            }
        }
    }
    
    // NOTE: Do not run this on every change
    private func saveEntries() {
        
        if let encodedData = Self.encode(data: self.entries) {
            
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

    // MARK: - Helpers
    
    private static func encode<T>(data: T) -> Data? {
        
        return try? NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: false)
    }
    
    private static func decode<T>(data: Data) -> T? {

        return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? T
    }
    
    // MARK: - API
    
    func changeDay(to date: Date) {
        
        self.selectedDay = date
        
        self.loadSelectedDayData(for: self.selectedDay)
    }

    func changeEntry(date: Date, entry: DayEntry) {
        
        self.entries[date] = entry
    }
    
    func getEntry(date: Date) -> DayEntry? {
        
        return self.entries[date]
    }
    
    
    func updateWeightInEntry() {
        
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
    
    func updateFoodInEntry() {
        
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

}
