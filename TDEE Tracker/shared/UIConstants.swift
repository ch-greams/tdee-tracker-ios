//
//  UIConstants.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 7/1/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI

struct UISizes {
    
    // MARK: - Welcome Page
    
    let welcomeConfirmButtonPadding: CGFloat
    
    // MARK: - Main View
    
    let mainViewPadding: CGFloat
    let mainViewNavbarPadding: CGFloat
    
    // MARK: - Navbar
    
    let navbarHeight: CGFloat
    let navbarPadding: CGFloat
    let navbarSpacing: CGFloat
    
    // MARK: - Calendar

    let calendarDayFont: Font
    let calendarDaySelectedFont: Font
    let calendarDayButton: CGFloat
    let calendarDaySpacing: CGFloat
    
    // MARK: - Entry Page
    
    let entryInputPadding: CGFloat
    let entryHintBlockPadding: CGFloat
    let entryBlockerHeight: CGFloat
    let entryOpenInputOffset: CGFloat
    
    // MARK: - Trends Page
    
    let trendsElementPadding: CGFloat
    let trendsItemLabelFont: Font
    let trendsItemValueFont: Font
    let trendsItemUnitFont: Font
    
    // MARK: - Progress Page
    
    let progressPageSpacing: CGFloat
    let progressChartHeight: CGFloat
    let progressCircleDiameter: CGFloat
    let progressCircleWidth: CGFloat
    
    // MARK: - Setup Page
    
    let setupInputHeight: CGFloat
    let setupTargetDeltaPadding: CGFloat
    let setupScrollHeight: CGFloat
}



class UIConstants {
    
    // MARK: - UISizes
    
    public static let IPHONE_11_PRO_MAX: UISizes = UISizes(
        
        welcomeConfirmButtonPadding: 30,
        
        mainViewPadding: 30,
        mainViewNavbarPadding: 802,
        
        navbarHeight: 84,
        navbarPadding: 12,
        navbarSpacing: 62,

        calendarDayFont: Font.appCalendarDayBig,
        calendarDaySelectedFont: Font.appCalendarDaySelectedBig,
        calendarDayButton: 46,
        calendarDaySpacing: 8,
        
        entryInputPadding: 36,
        entryHintBlockPadding: 20,
        entryBlockerHeight: 252,
        entryOpenInputOffset: -2,
        
        trendsElementPadding: 12,
        trendsItemLabelFont: Font.appTrendsItemLabelBig,
        trendsItemValueFont: Font.appTrendsItemValueBig,
        trendsItemUnitFont: Font.appTrendsItemUnitBig,
        
        progressPageSpacing: 34,
        progressChartHeight: 210,
        progressCircleDiameter: 380,
        progressCircleWidth: 56,
        
        setupInputHeight: 74,
        setupTargetDeltaPadding: 12,
        setupScrollHeight: 772
    )
    
    public static let IPHONE_11_PRO: UISizes = UISizes(
        
        welcomeConfirmButtonPadding: 30,

        mainViewPadding: 30,
        mainViewNavbarPadding: 720,
        
        navbarHeight: 84,
        navbarPadding: 12,
        navbarSpacing: 54,
        
        calendarDayFont: Font.appCalendarDayMedium,
        calendarDaySelectedFont: Font.appCalendarDaySelectedMedium,
        calendarDayButton: 40,
        calendarDaySpacing: 8,
        
        entryInputPadding: 30,
        entryHintBlockPadding: 16,
        entryBlockerHeight: 230,
        entryOpenInputOffset: -8,
        
        trendsElementPadding: 10,
        trendsItemLabelFont: Font.appTrendsItemLabelMedium,
        trendsItemValueFont: Font.appTrendsItemValueMedium,
        trendsItemUnitFont: Font.appTrendsItemUnitMedium,
        
        progressPageSpacing: 32,
        progressChartHeight: 180,
        progressCircleDiameter: 340,
        progressCircleWidth: 40,
        
        setupInputHeight: 74,
        setupTargetDeltaPadding: 12,
        setupScrollHeight: 690
    )
    
    public static let IPHONE_8_PLUS: UISizes = UISizes(
        
        welcomeConfirmButtonPadding: 24,

        mainViewPadding: 0,
        mainViewNavbarPadding: 655,
        
        navbarHeight: 60,
        navbarPadding: 8,
        navbarSpacing: 62,

        calendarDayFont: Font.appCalendarDayBig,
        calendarDaySelectedFont: Font.appCalendarDaySelectedBig,
        calendarDayButton: 44,
        calendarDaySpacing: 8,
        
        entryInputPadding: 18,
        entryHintBlockPadding: 10,
        entryBlockerHeight: 184,
        entryOpenInputOffset: 8,
        
        trendsElementPadding: 4,
        trendsItemLabelFont: Font.appTrendsItemLabelMedium,
        trendsItemValueFont: Font.appTrendsItemValueMedium,
        trendsItemUnitFont: Font.appTrendsItemUnitMedium,
        
        progressPageSpacing: 16,
        progressChartHeight: 180,
        progressCircleDiameter: 340,
        progressCircleWidth: 40,
        
        setupInputHeight: 68,
        setupTargetDeltaPadding: 12,
        setupScrollHeight: 655
    )

    public static let IPHONE_8: UISizes = UISizes(
        
        welcomeConfirmButtonPadding: 24,

        mainViewPadding: 0,
        mainViewNavbarPadding: 586,
        
        navbarHeight: 60,
        navbarPadding: 8,
        navbarSpacing: 54,

        calendarDayFont: Font.appCalendarDaySmall,
        calendarDaySelectedFont: Font.appCalendarDaySelectedSmall,
        calendarDayButton: 36,
        calendarDaySpacing: 12,
        
        entryInputPadding: 16,
        entryHintBlockPadding: 6,
        entryBlockerHeight: 174,
        entryOpenInputOffset: 0,
        
        trendsElementPadding: 3,
        trendsItemLabelFont: Font.appTrendsItemLabelMedium,
        trendsItemValueFont: Font.appTrendsItemValueMedium,
        trendsItemUnitFont: Font.appTrendsItemUnitMedium,
        
        progressPageSpacing: 8,
        progressChartHeight: 160,
        progressCircleDiameter: 310,
        progressCircleWidth: 40,
        
        setupInputHeight: 58,
        setupTargetDeltaPadding: 8,
        setupScrollHeight: 586
    )

    
    public static func getUISizes(device: String) -> UISizes {
        
        print(device)
        
        switch device {
            
            case "iPhone 11",
                 "iPhone 11 Pro Max":
                return Self.IPHONE_11_PRO_MAX
            
            case "iPhone 11 Pro":
                return Self.IPHONE_11_PRO

            case "iPhone 8 Plus":
                return Self.IPHONE_8_PLUS

            case "iPhone 8",
                 "iPhone SE (2nd generation)":
                return Self.IPHONE_8

            default:
                return Self.IPHONE_11_PRO
        }
    }
}
