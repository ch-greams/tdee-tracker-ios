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
    
    let calendarFont: CGFloat
    let calendarDayButton: CGFloat
    let calendarDaySpacing: CGFloat
    
    // MARK: - Entry Page
    
    let entryInputPadding: CGFloat
    let entryHintBlockPadding: CGFloat
    let entryBlockerHeight: CGFloat
    
    // MARK: - Trends Page
    
    let trendsElementPadding: CGFloat
    let trendsItemLabelFontSize: CGFloat
    let trendsItemValueFontSize: CGFloat
    let trendsItemUnitFontSize: CGFloat
    
    // MARK: - Progress Page
    
    let progressPageSpacing: CGFloat
    let progressChartHeight: CGFloat
    let progressCircleDiameter: CGFloat
    let progressCircleWidth: CGFloat
    
    // MARK: - Setup Page
    
    let setupInputHeight: CGFloat
    let setupTargetDeltaPadding: CGFloat
    
}

struct UITheme {
    
    let backgroundColor: Color
    
    let inputBackgroundColor: Color
    let inputBackgroundColorName: String
    let inputAccentColor: Color
    let inputAccentColorName: String
    let inputAccentAlternativeColor: Color
    let inputAccentAlternativeColorName: String
    let inputConfirmButtonColor: Color
    
    let mainTextColor: Color
    let mainTextColorName: String
    let secondaryTextColor: Color
    
    let calendarWeekHighlight: Color
    let calendarTextDefaultColor: Color
    let calendarTextAltColor: Color
    let calendarAccentColor: Color
    let calendarAccentColorName: String
    let calendarAccentAlternativeColor: Color
    let calendarAccentAlternativeColorName: String
    
    let trendsSeparatorColor: Color
    
    let navbarAccentColor: Color
    let navbarAccentColorName: String
    let navbarBackgroundColor: Color
    
    let warningBackgroundColor: Color
}

enum Theme {
    case Default
    case Alternative
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

        calendarFont: 24,
        calendarDayButton: 46,
        calendarDaySpacing: 8,
        
        entryInputPadding: 36,
        entryHintBlockPadding: 20,
        entryBlockerHeight: 252,
        
        trendsElementPadding: 12,
        trendsItemLabelFontSize: 20,
        trendsItemValueFontSize: 34,
        trendsItemUnitFontSize: 16,
        
        progressPageSpacing: 34,
        progressChartHeight: 210,
        progressCircleDiameter: 380,
        progressCircleWidth: 56,
        
        setupInputHeight: 74,
        setupTargetDeltaPadding: 12
    )
    
    public static let IPHONE_11_PRO: UISizes = UISizes(
        
        welcomeConfirmButtonPadding: 30,

        mainViewPadding: 30,
        mainViewNavbarPadding: 720,
        
        navbarHeight: 84,
        navbarPadding: 12,
        navbarSpacing: 54,
        
        calendarFont: 22,
        calendarDayButton: 40,
        calendarDaySpacing: 8,
        
        entryInputPadding: 30,
        entryHintBlockPadding: 16,
        entryBlockerHeight: 230,
        
        trendsElementPadding: 10,
        trendsItemLabelFontSize: 18,
        trendsItemValueFontSize: 32,
        trendsItemUnitFontSize: 14,
        
        progressPageSpacing: 32,
        progressChartHeight: 180,
        progressCircleDiameter: 340,
        progressCircleWidth: 40,
        
        setupInputHeight: 74,
        setupTargetDeltaPadding: 12
    )
    
    public static let IPHONE_8_PLUS: UISizes = UISizes(
        
        welcomeConfirmButtonPadding: 24,

        mainViewPadding: 0,
        mainViewNavbarPadding: 655,
        
        navbarHeight: 60,
        navbarPadding: 8,
        navbarSpacing: 62,

        calendarFont: 24,
        calendarDayButton: 44,
        calendarDaySpacing: 8,
        
        entryInputPadding: 18,
        entryHintBlockPadding: 10,
        entryBlockerHeight: 184,
        
        trendsElementPadding: 4,
        trendsItemLabelFontSize: 18,
        trendsItemValueFontSize: 32,
        trendsItemUnitFontSize: 14,
        
        progressPageSpacing: 16,
        progressChartHeight: 180,
        progressCircleDiameter: 340,
        progressCircleWidth: 40,
        
        setupInputHeight: 68,
        setupTargetDeltaPadding: 12
    )

    public static let IPHONE_8: UISizes = UISizes(
        
        welcomeConfirmButtonPadding: 24,

        mainViewPadding: 0,
        mainViewNavbarPadding: 586,
        
        navbarHeight: 60,
        navbarPadding: 8,
        navbarSpacing: 54,

        calendarFont: 18,
        calendarDayButton: 36,
        calendarDaySpacing: 12,
        
        entryInputPadding: 16,
        entryHintBlockPadding: 6,
        entryBlockerHeight: 174,
        
        trendsElementPadding: 3,
        trendsItemLabelFontSize: 18,
        trendsItemValueFontSize: 32,
        trendsItemUnitFontSize: 14,
        
        progressPageSpacing: 8,
        progressChartHeight: 160,
        progressCircleDiameter: 310,
        progressCircleWidth: 40,
        
        setupInputHeight: 58,
        setupTargetDeltaPadding: 8
    )
    
    // MARK: - UITheme
    
    public static let THEME_DEFAULT: UITheme = UITheme(

        backgroundColor: Color.BACKGROUND_COLOR,

        inputBackgroundColor: Color.INPUT_BACKGROUND_COLOR,
        inputBackgroundColorName: Color.INPUT_BACKGROUND_NAME,
        inputAccentColor: Color.INPUT_ACCENT_COLOR,
        inputAccentColorName: Color.INPUT_ACCENT_NAME,
        inputAccentAlternativeColor: Color.INPUT_ACCENT_ALTERNATIVE_COLOR,
        inputAccentAlternativeColorName: Color.INPUT_ACCENT_ALTERNATIVE_NAME,
        inputConfirmButtonColor: Color.INPUT_CONFIRM_BUTTON_COLOR,
        
        mainTextColor: Color.MAIN_TEXT_COLOR,
        mainTextColorName: Color.MAIN_TEXT_NAME,
        secondaryTextColor: Color.SECONDARY_TEXT_COLOR,
        
        calendarWeekHighlight: Color.CALENDAR_WEEK_HIGHLIGHT_COLOR,
        calendarTextDefaultColor: Color.CALENDAR_TEXT_DEFAULT_COLOR,
        calendarTextAltColor: Color.CALENDAR_TEXT_ALTERNATIVE_COLOR,
        calendarAccentColor: Color.CALENDAR_ACCENT_COLOR,
        calendarAccentColorName: Color.CALENDAR_ACCENT_NAME,
        calendarAccentAlternativeColor: Color.CALENDAR_ACCENT_ALTERNATIVE_COLOR,
        calendarAccentAlternativeColorName: Color.CALENDAR_ACCENT_ALTERNATIVE_NAME,
        
        trendsSeparatorColor: Color.TRENDS_SEPARATOR_COLOR,
        
        navbarAccentColor: Color.NAVBAR_ACCENT_COLOR,
        navbarAccentColorName: Color.NAVBAR_ACCENT_NAME,
        navbarBackgroundColor: Color.NAVBAR_BACKGROUND_COLOR,
        
        warningBackgroundColor: Color.WARNING_BACKGROUND_COLOR
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

    public static func getUITheme(theme: Theme = Theme.Default) -> UITheme {
        
        switch theme {
            case Theme.Alternative:
                return Self.THEME_DEFAULT
            default:
                return Self.THEME_DEFAULT
        }
    }
}
