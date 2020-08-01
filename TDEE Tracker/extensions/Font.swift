//
//  Font.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/3/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import Foundation
import SwiftUI


extension Font {
    
    private static let OSWALD_EXTRA_LIGHT = "Oswald-ExtraLight"
    private static let OSWALD_LIGHT = "Oswald-Light"
    private static let OSWALD_REGULAR = "Oswald-Regular"
    private static let OSWALD_MEDIUM = "Oswald-Medium"
    private static let OSWALD_BOLD = "Oswald-Bold"

    
    // MARK: - Calendar
    
    public static let appCalendarMonth = Self.custom(Self.OSWALD_MEDIUM, size: 24)
    public static let appCalendarWeekday = Self.custom(Self.OSWALD_EXTRA_LIGHT, size: 14)
    
    public static let appCalendarDaySmall = Self.custom(Self.OSWALD_EXTRA_LIGHT, size: 18)
    public static let appCalendarDayMedium = Self.custom(Self.OSWALD_EXTRA_LIGHT, size: 22)
    public static let appCalendarDayBig = Self.custom(Self.OSWALD_EXTRA_LIGHT, size: 24)
    
    public static let appCalendarDaySelectedSmall = Self.custom(Self.OSWALD_MEDIUM, size: 18)
    public static let appCalendarDaySelectedMedium = Self.custom(Self.OSWALD_MEDIUM, size: 22)
    public static let appCalendarDaySelectedBig = Self.custom(Self.OSWALD_MEDIUM, size: 24)
    
    // MARK: - Entry Page
    
    public static let appEntryRecommendedLabel = Self.custom(Self.OSWALD_LIGHT, size: 15)
    public static let appEntryRecommendedAmount = Self.custom(Self.OSWALD_BOLD, size: 32)
    
    public static let appEntryValue = Self.custom(Self.OSWALD_BOLD, size: 36)
    public static let appEntryUnit = Self.custom(Self.OSWALD_LIGHT, size: 24)
    
    // MARK: - Trends Page

    public static let appTrendsItemLabelMedium = Self.custom(Self.OSWALD_LIGHT, size: 18)
    public static let appTrendsItemLabelBig = Self.custom(Self.OSWALD_LIGHT, size: 20)
    
    public static let appTrendsItemValueMedium = Self.custom(Self.OSWALD_BOLD, size: 32)
    public static let appTrendsItemValueBig = Self.custom(Self.OSWALD_BOLD, size: 34)
    
    public static let appTrendsItemUnitMedium = Self.custom(Self.OSWALD_LIGHT, size: 14)
    public static let appTrendsItemUnitBig = Self.custom(Self.OSWALD_LIGHT, size: 16)
    
    // MARK: - Setup Page

    public static let appSetupToggleValue = Self.custom(Self.OSWALD_BOLD, size: 18)
    public static let appSetupThemeButton = Self.custom(Self.OSWALD_BOLD, size: 24)
    
    public static let appSetupPremiumTitle = Self.custom(Self.OSWALD_MEDIUM, size: 24)
    public static let appSetupPremiumHint = Self.custom(Self.OSWALD_LIGHT, size: 18)
    
    public static let appSetupPremiumBuy = Self.custom(Self.OSWALD_BOLD, size: 20)
    public static let appSetupPremiumCancel = Self.custom(Self.OSWALD_REGULAR, size: 16)
    
    // MARK: - Progress Page
    
    public static let appProgressChartSegment = Self.custom(Self.OSWALD_LIGHT, size: 10)
    public static let appProgressCirclePercent = Self.custom(Self.OSWALD_LIGHT, size: 64)
    public static let appProgressCircleValues = Self.custom(Self.OSWALD_MEDIUM, size: 32)
    public static let appProgressCircleEstimate = Self.custom(Self.OSWALD_LIGHT, size: 28)
    
    // MARK: - Welcome Page
    
    public static let appWelcomeTitle = Self.custom(Self.OSWALD_MEDIUM, size: 48)
    public static let appWelcomeSubtitle = Self.custom(Self.OSWALD_LIGHT, size: 28)
    public static let appWelcomeHint = Self.custom(Self.OSWALD_LIGHT, size: 22)
    
    // MARK: - General

    public static let appWarningText = Self.custom(Self.OSWALD_MEDIUM, size: 16)
    public static let appNavbarElement = Self.custom(Self.OSWALD_LIGHT, size: 12)
    public static let appDefaultButtonLabel = Self.custom(Self.OSWALD_MEDIUM, size: 18)

    public static let appInputLabel = Self.custom(Self.OSWALD_LIGHT, size: 18)
    public static let appInputValue = Self.custom(Self.OSWALD_BOLD, size: 32)
    public static let appInputUnit = Self.custom(Self.OSWALD_LIGHT, size: 14)

}

