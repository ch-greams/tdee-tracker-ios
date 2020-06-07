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

    

//    public static func FHACondFrenchNC(size: CGFloat) -> Font {
//        return Font.custom("FHA Condensed French NC", size: size)
//    }
//
//    public static func AmericanCaptain(size: CGFloat) -> Font {
//        return Font.custom("American Captain", size: size)
//    }
//
//    public static func FjallaOne(size: CGFloat) -> Font {
//        return Font.custom("FjallaOne-Regular", size: size)
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
