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
    public static let goalWeightHint = "Goal weight can be higher or lower than today's weight".localize
    public static let deltaWeightHint = "Based on your current weight weekly change must not be bigger than".localize
    
    public static let settingsHint = "Parameters can be changed at any time in the application settings".localize
    
    // MARK: - Tutorial
    
    public static let tutorialFirstStep = "Let's review controls!\nPress on the message to continue.".localize
    public static let tutorialSecondStep = "All you need to do is enter your weight...".localize
    public static let tutorialThirdStep = "And food consupmtion value, each day.".localize
    public static let tutorialFourthStep = "After one week, app will provide recommendation on how much food you should eat.".localize
    
    // MARK: - Entry Page
    
    public static let notEnoughDataHint = "Not enough data to give recommendation".localize
    public static let recommendedAmount = "Recommended\ndaily amount".localize
    
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
    
    public static let themeDefault = "Jade".localize
    public static let themeCyan = "Turqoise".localize
    public static let themeBlue = "Azure".localize
    public static let themePurple = "Plum".localize
    public static let themePink = "Rose".localize
    public static let themeBronze = "Bronze".localize
    
    // MARK: - Notifications
    
    public static let addEntry = "Add Entry".localize

    public static let addWeightNotification = "How much do you weight today?".localize
    public static let addFoodNotification = "How much did you eat today?".localize

    // MARK: - Premium Purchase
    
    public static let buyPremiumTitle = "TDEE Tracker Premium".localize
    public static let buyPremiumDescription = "Premium version of TDEE Tracker unlocks all existing themes.\nIt does not include any extra features, as everything else is available for free.".localize
    
    public static let buyFor = "BUY FOR".localize
    public static let getFree = "GET IT FOR FREE".localize
    public static let unavailable = "UNAVAILABLE".localize
    public static let cancel = "CANCEL".localize
    
    public static let tryRestore = "Checking Purchases".localize
    public static let fetchProducts = "Connecting to iTunes".localize
    public static let tryPurchase = "Making a Purchase".localize
    
    // MARK: - Apple Health
    
    public static let integrations = "INTEGRATIONS".localize
    public static let appleHealth = "Apple Health".localize
    public static let appleHealthHint = "Apple Health integration requires permissions to be granted in Settings > Privacy > Health > TDEE Tracker".localize
    
    // MARK: - Store Messages
    
    public static let notAuthorized = "You are not authorized to make payments.\nIn-App Purchases may be restricted on your device.".localize
    public static let productRequestError = "iTunes Connection Error".localize
    public static let purchaseError = "Error During Purchase of".localize
}
