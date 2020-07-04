//
//  Color.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/2/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
    
    // Colors without assets are unused
    
    public static var appFadeName = "black-50"
    public static var appPrimaryName = "teal"
    public static var appPrimaryLightName = "tealLight"
    public static var appPrimaryDarkName = "tealDark"
    public static var appSecondaryName = "deepOrange"
    
    public static var appFade: Color {
        Color(Self.appFadeName, bundle: nil)
    }
    
    public static var appPrimary: Color {
        Color(Self.appPrimaryName, bundle: nil)
    }

    public static var appPrimaryLight: Color {
        Color(Self.appPrimaryLightName, bundle: nil)
    }

    public static var appPrimaryDark: Color {
        Color(Self.appPrimaryDarkName, bundle: nil)
    }

    public static var appPrimaryText: Color {
        Color("greyDark")
    }

    public static var appPrimaryTextLight: Color {
        Color("greyLight")
    }

    
    public static var appSecondary: Color {
        Color(Self.appSecondaryName, bundle: nil)
    }

    public static var appSecondaryLight: Color {
        Color(red: 1.00, green: 0.64, blue: 0.44)
    }

    public static var appSecondaryDark: Color {
        Color(red: 0.78, green: 0.25, blue: 0.09)
    }

    public static var appSecondaryText: Color {
        Color(red: 0.00, green: 0.00, blue: 0.00)
    }

    // MARK: New Color Setup
    
    
    public static let BACKGROUND_NAME = "background"
    
    public static let INPUT_BACKGROUND_NAME = "inputBackground"
    public static let MAIN_TEXT_NAME = "mainText"
    
    public static let CALENDAR_TEXT_ALTERNATIVE_NAME = "calendarTextAlternative"
    public static let CALENDAR_TEXT_DEFAULT_NAME = "calendarTextDefault"
    public static let CALENDAR_WEEK_HIGHLIGHT_NAME = "calendarWeekHighlight"
    
    
    public static let BACKGROUND_COLOR: Color = Color(Self.BACKGROUND_NAME)
    
    public static let INPUT_BACKGROUND_COLOR = Color(Self.INPUT_BACKGROUND_NAME)
    public static let MAIN_TEXT_COLOR = Color(Self.MAIN_TEXT_NAME)
    
    public static let CALENDAR_TEXT_ALTERNATIVE_COLOR = Color(Self.CALENDAR_TEXT_ALTERNATIVE_NAME)
    public static let CALENDAR_TEXT_DEFAULT_COLOR = Color(Self.CALENDAR_TEXT_DEFAULT_NAME)
    public static let CALENDAR_WEEK_HIGHLIGHT_COLOR = Color(Self.CALENDAR_WEEK_HIGHLIGHT_NAME)
}

