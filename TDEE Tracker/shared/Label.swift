//
//  Label.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 7/5/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct Label {
    
    // MARK: - Inputs
    
    public static let weight = "Weight".localize
    public static let energy = "Energy".localize
    public static let todaysWeight = "Today's Weight".localize
    public static let goalWeight = "Goal Weight".localize
    public static let weeklyChange = "Weekly Change".localize

    public static let inputError = "Value outside of valid range".localize
    
    // MARK: - Buttons
    
    public static let done = "DONE".localize
    public static let next = "NEXT".localize
    public static let confirm = "CONFIRM".localize
    
    // MARK: Target Surplus/Deficit
    
    public static let targetSurplus = "Target Surplus".localize
    public static let targetDeficit = "Target Deficit".localize
    public static let day = "day".localize
    
    // MARK: - Navbar

    public static let entry = "Entry".localize
    public static let trends = "Trends".localize
    public static let progress = "Progress".localize
    public static let settings = "Settings".localize
    
    // MARK: - Date/Time Format
    
    public static let progressDateFormat = "MMMM d".localize
    
    // MARK: - Welcome Page
    
    public static let welcome = "Welcome".localize
    public static let getStarted = "Let’s get started".localize
    
    public static let almostReady = "Almost Ready".localize
    public static let defineGoals = "Define your goals".localize
    
    public static let weightUnitHint = "Please select measurement unit that would be used for bodyweight values".localize
    public static let energyUnitHint = "And this measurement unit will be used for food and energy values".localize
    
    public static let currentWeightHint = "For the best result always measure it at the same time in the morning".localize
    public static let goalWeightHint = "Goal weight is what you strife for".localize
    public static let deltaWeightHint = "Based on your current weight weekly change must not be bigger than".localize
    
    public static let settingsHint = "Parameters can be changed at any time in the application settings".localize
    
    // MARK: - Entry Page
    
    public static let notEnoughDataHint = "After enough entries were added you will see here recommended daily amount".localize
    
    public static let recommendedAmount = "Recommended daily amount".localize
    
    // MARK: - Trends Page
    
    public static let food = "FOOD".localize
    public static let tdee = "TDEE".localize
    public static let weightChange = "WEIGHT CHANGE".localize
    
    // MARK: - Progress Page

    public static let startingFrom = "Starting from".localize
    public static let week = "week".localize
    public static let coupleWeeks = "couple_weeks".localize
    public static let manyWeeks = "many_weeks".localize

    // MARK: - Settings Page
    
    public static let units = "UNITS".localize
    public static let goal = "GOAL".localize
    public static let reminders = "REMINDERS".localize
    public static let theme = "THEME".localize
    
    // MARK: - Themes
    
    public static let apply = "APPLY".localize
    public static let active = "ACTIVE".localize
    
    public static let themeDefault = "Default".localize
    public static let themeBlue = "Blue".localize
    public static let themePurple = "Purple".localize
    public static let themeCyan = "Cyan".localize
    
    // MARK: - Notifications
    
    public static let addEntry = "Add Entry".localize

    public static let addWeightNotification = "It's time to add today's weight".localize
    public static let addFoodNotification = "It's time to add today's food".localize
}
