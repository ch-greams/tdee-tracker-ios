//
//  Font.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/3/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import Foundation
import SwiftUI


public enum FontOswald: String {
    
    case ExtraLight = "Oswald-ExtraLight"
    case Light = "Oswald-Light"
    case Regular = "Oswald-Regular"
    case Medium = "Oswald-Medium"
    case Bold = "Oswald-Bold"
}

extension Font {
    
    // MARK: - Calendar
    
    public static let appCalendarMonth = Self.custom(FontOswald.Medium.rawValue, size: 24)
    public static let appCalendarWeekday = Self.custom(FontOswald.ExtraLight.rawValue, size: 14)
    
    public static let appCalendarDaySmall = Self.custom(FontOswald.ExtraLight.rawValue, size: 18)
    public static let appCalendarDayMedium = Self.custom(FontOswald.ExtraLight.rawValue, size: 22)
    public static let appCalendarDayBig = Self.custom(FontOswald.ExtraLight.rawValue, size: 24)
    
    public static let appCalendarDaySelectedSmall = Self.custom(FontOswald.Medium.rawValue, size: 18)
    public static let appCalendarDaySelectedMedium = Self.custom(FontOswald.Medium.rawValue, size: 22)
    public static let appCalendarDaySelectedBig = Self.custom(FontOswald.Medium.rawValue, size: 24)
    
    // MARK: - Entry Page
    
    public static let appEntryRecommendedLabel = Self.custom(FontOswald.Light.rawValue, size: 15)
    public static let appEntryRecommendedAmount = Self.custom(FontOswald.Bold.rawValue, size: 32)
    
    public static let appEntryValue = Self.custom(FontOswald.Bold.rawValue, size: 36)
    public static let appEntryUnit = Self.custom(FontOswald.Light.rawValue, size: 24)
    
    // MARK: - Trends Page

    public static let appTrendsItemLabelMedium = Self.custom(FontOswald.Light.rawValue, size: 18)
    public static let appTrendsItemLabelBig = Self.custom(FontOswald.Light.rawValue, size: 20)
    
    public static let appTrendsItemValueMedium = Self.custom(FontOswald.Bold.rawValue, size: 32)
    public static let appTrendsItemValueBig = Self.custom(FontOswald.Bold.rawValue, size: 34)
    
    public static let appTrendsItemUnitMedium = Self.custom(FontOswald.Light.rawValue, size: 14)
    public static let appTrendsItemUnitBig = Self.custom(FontOswald.Light.rawValue, size: 16)
    
    // MARK: - Setup Page

    public static let appSetupToggleValue = Self.custom(FontOswald.Bold.rawValue, size: 18)
    public static let appSetupThemeButton = Self.custom(FontOswald.Bold.rawValue, size: 24)
    
    public static let appSetupPremiumTitle = Self.custom(FontOswald.Medium.rawValue, size: 24)
    public static let appSetupPremiumHint = Self.custom(FontOswald.Light.rawValue, size: 18)
    
    public static let appSetupPremiumBuy = Self.custom(FontOswald.Bold.rawValue, size: 20)
    public static let appSetupPremiumCancel = Self.custom(FontOswald.Regular.rawValue, size: 16)
    
    // MARK: - Progress Page
    
    public static let appProgressChartSegment = Self.custom(FontOswald.Light.rawValue, size: 10)
    public static let appProgressCirclePercent = Self.custom(FontOswald.Light.rawValue, size: 64)
    public static let appProgressCircleValues = Self.custom(FontOswald.Medium.rawValue, size: 32)
    public static let appProgressCircleEstimate = Self.custom(FontOswald.Light.rawValue, size: 28)
    
    // MARK: - Welcome Page
    
    public static let appWelcomeTitle = Self.custom(FontOswald.Medium.rawValue, size: 48)
    public static let appWelcomeSubtitle = Self.custom(FontOswald.Light.rawValue, size: 28)
    public static let appWelcomeHint = Self.custom(FontOswald.Light.rawValue, size: 22)
    
    // MARK: - General

    public static let appWarningText = Self.custom(FontOswald.Medium.rawValue, size: 16)
    public static let appNavbarElement = Self.custom(FontOswald.Light.rawValue, size: 12)
    public static let appDefaultButtonLabel = Self.custom(FontOswald.Medium.rawValue, size: 18)

    public static let appInputLabel = Self.custom(FontOswald.Light.rawValue, size: 18)
    public static let appInputValue = Self.custom(FontOswald.Bold.rawValue, size: 32)
    public static let appInputUnit = Self.custom(FontOswald.Light.rawValue, size: 14)

    
    
    public static func customFont(font: FontOswald, size: CGFloat) -> Font {
        Self.custom(font.rawValue, size: size)
    }
}


struct Font_Calendar_Previews: PreviewProvider {
    static var previews: some View {
        
        ZStack(alignment: .center) {
            
            UIThemeManager.DEFAULT.backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 16) {
                
                // MARK: - Calendar
                
                Text("appCalendarMonth").font(.appCalendarMonth)
                Text("appCalendarWeekday").font(.appCalendarWeekday)

                Text("appCalendarDaySmall").font(.appCalendarDaySmall)
                Text("appCalendarDayMedium").font(.appCalendarDayMedium)
                Text("appCalendarDayBig").font(.appCalendarDayBig)

                Text("appCalendarDaySelectedSmall").font(.appCalendarDaySelectedSmall)
                Text("appCalendarDaySelectedMedium").font(.appCalendarDaySelectedMedium)
                Text("appCalendarDaySelectedBig").font(.appCalendarDaySelectedBig)
                    
            }
                .background(UIThemeManager.DEFAULT.backgroundColor)
                .foregroundColor(UIThemeManager.DEFAULT.mainTextColor)
        }
    }
}

struct Font_Entry_And_Trends_Previews: PreviewProvider {
    static var previews: some View {
        
        ZStack(alignment: .center) {
            
            UIThemeManager.DEFAULT.backgroundColor.edgesIgnoringSafeArea(.all)
            
            ScrollView(.horizontal, showsIndicators: true) {
                
                VStack(alignment: .leading, spacing: 16) {

                    // MARK: - Entry Page

                    Text("appEntryRecommendedLabel").font(.appEntryRecommendedLabel)
                    Text("appEntryRecommendedAmount").font(.appEntryRecommendedAmount)

                    Text("appEntryValue").font(.appEntryValue)
                    Text("appEntryUnit").font(.appEntryUnit)

                    // MARK: - Trends Page

                    Text("appTrendsItemLabelMedium").font(.appTrendsItemLabelMedium)
                    Text("appTrendsItemLabelBig").font(.appTrendsItemLabelBig)

                    Text("appTrendsItemValueMedium").font(.appTrendsItemValueMedium)
                    Text("appTrendsItemValueBig").font(.appTrendsItemValueBig)

                    Text("appTrendsItemUnitMedium").font(.appTrendsItemUnitMedium)
                    Text("appTrendsItemUnitBig").font(.appTrendsItemUnitBig)
                }
                    .padding(.leading, 16)
            }
                .background(UIThemeManager.DEFAULT.backgroundColor)
                .foregroundColor(UIThemeManager.DEFAULT.mainTextColor)
        }
    }
}

struct Font_Progress_And_Setup_Previews: PreviewProvider {
    static var previews: some View {
        
        ZStack(alignment: .center) {
            
            UIThemeManager.DEFAULT.backgroundColor.edgesIgnoringSafeArea(.all)
            
            ScrollView(.horizontal, showsIndicators: true) {
                
                VStack(alignment: .leading, spacing: 16) {
                
                    // MARK: - Setup Page

                    Text("appSetupToggleValue").font(.appSetupToggleValue)
                    Text("appSetupThemeButton").font(.appSetupThemeButton)

                    Text("appSetupPremiumTitle").font(.appSetupPremiumTitle)
                    Text("appSetupPremiumHint").font(.appSetupPremiumHint)

                    Text("appSetupPremiumBuy").font(.appSetupPremiumBuy)
                    Text("appSetupPremiumCancel").font(.appSetupPremiumCancel)

                    // MARK: - Progress Page

                    Text("appProgressChartSegment").font(.appProgressChartSegment)
                    Text("appProgressCirclePercent").font(.appProgressCirclePercent)
                    Text("appProgressCircleValues").font(.appProgressCircleValues)
                    Text("appProgressCircleEstimate").font(.appProgressCircleEstimate)
                }
                    .padding(.leading, 16)
            }
                .background(UIThemeManager.DEFAULT.backgroundColor)
                .foregroundColor(UIThemeManager.DEFAULT.mainTextColor)
        }
    }
}

struct Font_Welcome_And_General_Previews: PreviewProvider {
    static var previews: some View {
        
        ZStack(alignment: .center) {
            
            UIThemeManager.DEFAULT.backgroundColor.edgesIgnoringSafeArea(.all)
            
            ScrollView(.horizontal, showsIndicators: true) {
                
                VStack(alignment: .leading, spacing: 16) {
                
                    // MARK: - Welcome Page

                    Text("appWelcomeTitle").font(.appWelcomeTitle)
                    Text("appWelcomeSubtitle").font(.appWelcomeSubtitle)
                    Text("appWelcomeHint").font(.appWelcomeHint)

                    // MARK: - General

                    Text("appWarningText").font(.appWarningText)
                    Text("appNavbarElement").font(.appNavbarElement)
                    Text("appDefaultButtonLabel").font(.appDefaultButtonLabel)

                    Text("appInputLabel").font(.appInputLabel)
                    Text("appInputValue").font(.appInputValue)
                    Text("appInputUnit").font(.appInputUnit)
                }
                    .padding(.leading, 16)
            }
                .background(UIThemeManager.DEFAULT.backgroundColor)
                .foregroundColor(UIThemeManager.DEFAULT.mainTextColor)
        }
    }
}
