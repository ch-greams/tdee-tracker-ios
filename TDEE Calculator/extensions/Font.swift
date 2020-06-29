//
//  Font.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/3/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import Foundation
import SwiftUI


extension Font {
    
    // MARK: - Calendar
    
    public static var appCalendarMonth: Font {
        Self.custom("Oswald-Medium", size: 24)
    }

    public static var appCalendarWeekday: Font {
        Self.custom("Oswald-ExtraLight", size: 14)
    }
    
    public static var appCalendarDay: Font {
        Self.custom("Roboto-Thin", size: 24)
    }
    
    public static var appCalendarDaySelected: Font {
        Self.custom("Roboto-Bold", size: 24)
    }
    
    // MARK: - Entry Page
    
    public static var appEntryRecommendedLabel: Font {
        Self.custom("Oswald-Light", size: 15)
    }
    
    public static var appEntryRecommendedAmount: Font {
        Self.custom("Oswald-Bold", size: 40)
    }
    
    public static var appEntryValue: Font {
        Self.custom("Roboto-Light", size: 40)
    }

    public static var appEntryUnit: Font {
        Self.custom("Oswald-Light", size: 24)
    }
    
    // MARK: - Trends Page

    public static var appTrendsItemLabel: Font {
        Self.custom("Oswald-Light", size: 18)
    }
    
    public static var appTrendsItemValue: Font {
        Self.custom("Oswald-Bold", size: 32)
    }

    public static var appTrendsItemUnit: Font {
        Self.custom("Oswald-Light", size: 14)
    }
    
    // MARK: - Setup Page

    public static var appSetupToggleValue: Font {
        Self.custom("Oswald-Bold", size: 18)
    }
    
    // MARK: - Progress Page
    
    public static var appProgressChartSegment: Font {
        Self.custom("Roboto-Light", size: 10)
    }
    
    public static var appProgressCirclePercent: Font {
        Self.custom("Oswald-Light", size: 64)
    }
    
    public static var appProgressCircleValues: Font {
        Self.custom("Oswald-Medium", size: 32)
    }
    
    public static var appProgressCircleEstimate: Font {
        Self.custom("Oswald-Light", size: 28)
    }
    
    // MARK: - Welcome Page
    
    public static var appWelcomeTitle: Font {
        Self.custom("Oswald-Medium", size: 48)
    }
    
    public static var appWelcomeSubtitle: Font {
        Self.custom("Oswald-Light", size: 28)
    }
    
    public static var appWelcomeHint: Font {
        Self.custom("Oswald-Light", size: 22)
    }
    
    // MARK: - Other

    public static var appWarningText: Font {
        Self.custom("Oswald-Light", size: 16)
    }
    
    public static var appNavbarElement: Font {
        Self.custom("Oswald-Light", size: 12)
    }
    
    
//    public static func FHACondFrenchNC(size: CGFloat) -> Font {
//        return Font.custom("FHA Condensed French NC", size: size)
//    }
}

//struct TitleFont: ViewModifier {
//    let size: CGFloat
//
//    func body(content: Content) -> some View {
//        return content.font(.FjallaOne(size: size))
//    }
//}
//
//extension View {
//    func titleFont(size: CGFloat) -> some View {
//        return ModifiedContent(content: self, modifier: TitleFont(size: size))
//    }
//
//    func titleStyle() -> some View {
//        return ModifiedContent(content: self, modifier: TitleFont(size: 16))
//    }
//}

