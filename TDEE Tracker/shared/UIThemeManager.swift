//
//  UIThemeManager.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 7/5/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI



enum UIThemeType: String, Localizable, CaseIterable {
    case Default = ""
    case Blue = "alt_"
    
    var localized: String {
        switch self {
            case UIThemeType.Default:
                return Label.themeDefault
            case UIThemeType.Blue:
                return Label.themeBlue
        }
    }
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
    let secondaryTextColorName: String
    
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



struct UIThemeManager {
    
    public static let DEFAULT = UIThemeManager.getTheme()
    
    public static let ALL_THEMES = UIThemeType.allCases.map {
        ( key: $0, value: Self.getUITheme(theme: $0) )
    }

    // MARK: - Constants
    
    private static let BACKGROUND = "background"

    private static let INPUT_BACKGROUND = "inputBackground"
    private static let INPUT_ACCENT = "inputAccent"
    private static let INPUT_ACCENT_ALTERNATIVE = "inputAccentAlternative"
    private static let INPUT_CONFIRM_BUTTON = "inputConfirmButton"
    
    private static let MAIN_TEXT = "mainText"
    private static let SECONDARY_TEXT = "secondaryText"
    
    private static let CALENDAR_TEXT_ALTERNATIVE = "calendarTextAlternative"
    private static let CALENDAR_TEXT_DEFAULT = "calendarTextDefault"
    private static let CALENDAR_WEEK_HIGHLIGHT = "calendarWeekHighlight"
    private static let CALENDAR_ACCENT = "calendarAccent"
    private static let CALENDAR_ACCENT_ALTERNATIVE = "calendarAccentAlternative"
    
    private static let TRENDS_SEPARATOR = "trendsSeparator"
    
    private static let NAVBAR_ACCENT = "navbarAccent"
    private static let NAVBAR_BACKGROUND = "navbarBackground"
    
    private static let WARNING_BACKGROUND = "warningBackground"

    // MARK: - Functions
    
    private static func getColorName(_ color: String, theme: String) -> String {
        return "\(theme)\(color)"
    }
    
    private static func getTheme(theme: String = "") -> UITheme {
        
        let backgroundColorName = Self.getColorName(Self.BACKGROUND, theme: theme)
        
        let inputBackgroundColorName = Self.getColorName(Self.INPUT_BACKGROUND, theme: theme)
        let inputAccentColorName = Self.getColorName(Self.INPUT_ACCENT, theme: theme)
        let inputAccentAlternativeColorName = Self.getColorName(Self.INPUT_ACCENT_ALTERNATIVE, theme: theme)
        let inputConfirmButtonColorName = Self.getColorName(Self.INPUT_CONFIRM_BUTTON, theme: theme)

        let mainTextColorName = Self.getColorName(Self.MAIN_TEXT, theme: theme)
        let secondaryTextColorName = Self.getColorName(Self.SECONDARY_TEXT, theme: theme)

        let calendarWeekHighlightName = Self.getColorName(Self.CALENDAR_WEEK_HIGHLIGHT, theme: theme)
        let calendarTextDefaultColorName = Self.getColorName(Self.CALENDAR_TEXT_DEFAULT, theme: theme)
        let calendarTextAltColorName = Self.getColorName(Self.CALENDAR_TEXT_ALTERNATIVE, theme: theme)
        let calendarAccentColorName = Self.getColorName(Self.CALENDAR_ACCENT, theme: theme)
        let calendarAccentAlternativeColorName = Self.getColorName(Self.CALENDAR_ACCENT_ALTERNATIVE, theme: theme)

        let trendsSeparatorColorName = Self.getColorName(Self.TRENDS_SEPARATOR, theme: theme)

        let navbarAccentColorName = Self.getColorName(Self.NAVBAR_ACCENT, theme: theme)
        let navbarBackgroundColorName = Self.getColorName(Self.NAVBAR_BACKGROUND, theme: theme)

        let warningBackgroundColorName = Self.getColorName(Self.WARNING_BACKGROUND, theme: theme)
        
        return UITheme(

            backgroundColor: Color(backgroundColorName),
            
            inputBackgroundColor: Color(inputBackgroundColorName),
            inputBackgroundColorName: inputBackgroundColorName,
            inputAccentColor: Color(inputAccentColorName),
            inputAccentColorName: inputAccentColorName,
            inputAccentAlternativeColor: Color(inputAccentAlternativeColorName),
            inputAccentAlternativeColorName: inputAccentAlternativeColorName,
            inputConfirmButtonColor: Color(inputConfirmButtonColorName),

            mainTextColor: Color(mainTextColorName),
            mainTextColorName: mainTextColorName,
            secondaryTextColor: Color(secondaryTextColorName),
            secondaryTextColorName: secondaryTextColorName,

            calendarWeekHighlight: Color(calendarWeekHighlightName),
            calendarTextDefaultColor: Color(calendarTextDefaultColorName),
            calendarTextAltColor: Color(calendarTextAltColorName),
            calendarAccentColor: Color(calendarAccentColorName),
            calendarAccentColorName: calendarAccentColorName,
            calendarAccentAlternativeColor: Color(calendarAccentAlternativeColorName),
            calendarAccentAlternativeColorName: calendarAccentAlternativeColorName,

            trendsSeparatorColor: Color(trendsSeparatorColorName),

            navbarAccentColor: Color(navbarAccentColorName),
            navbarAccentColorName: navbarAccentColorName,
            navbarBackgroundColor: Color(navbarBackgroundColorName),

            warningBackgroundColor: Color(warningBackgroundColorName)
        )
    }

    public static func getUITheme(theme: UIThemeType = UIThemeType.Default) -> UITheme {
        
        return Self.getTheme(theme: theme.rawValue)
    }
}

