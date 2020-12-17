//
//  UISizes.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 7/1/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct UISizes {
    
    // MARK: - Welcome Page
    
    let welcomeSubTitleVPadding: CGFloat
    let welcomeInputsVSpacing: CGFloat
    let welcomeHintFontSize: CGFloat
    
    // MARK: - Navbar
    
    let navbarHeight: CGFloat
    let navbarPadding: CGFloat
    let navbarSpacing: CGFloat
    
    // MARK: - Calendar

    let calendarMonthFontSize: CGFloat
    let calendarMonthButtonHeight: CGFloat
    let calendarDayFontSize: CGFloat
    let calendarDayButton: CGFloat
    
    // MARK: - Entry Page
    
    let entryInputBaseSize: CGFloat
    let entryInputPadding: CGFloat
    let entryHintBlockPadding: CGFloat
    let entryBlockerIconPadding: CGFloat
    
    let entryHintFontSize: CGFloat
    let entryHintLabelFontSize: CGFloat
    let entryHintHPadding: CGFloat
    
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
    
    let setupDefaultButtonHeight: CGFloat
    let setupInputHeight: CGFloat
    let setupInputLabelFontSize: CGFloat
    let setupTargetDeltaPadding: CGFloat
    let targetDeltaHPadding: CGFloat
    
    // MARK: - Shared
    
    let keyboardButtonWidth: CGFloat
    let keyboardButtonHeight: CGFloat
    let keyboardBottomPadding: CGFloat
    
    public static let current: UISizes = Self.getSizes()
    
    // MARK: - Constants
    
    private static let SCREEN_WIDTH_CURRENT: CGFloat = UIScreen.main.bounds.width
    private static let SCREEN_HEIGHT_CURRENT: CGFloat = UIScreen.main.bounds.height
    
    private static let SCREEN_HEIGHT_XXL: CGFloat = 926
    private static let SCREEN_HEIGHT_XL: CGFloat = 896
    private static let SCREEN_HEIGHT_L: CGFloat = 844
    private static let SCREEN_HEIGHT_M: CGFloat = 812
    private static let SCREEN_HEIGHT_S: CGFloat = 736
    private static let SCREEN_HEIGHT_XS: CGFloat = 667
    private static let SCREEN_HEIGHT_XXS: CGFloat = 568

    private static let SCREEN_WIDTH_XL: CGFloat = 428
    private static let SCREEN_WIDTH_L: CGFloat = 414
    private static let SCREEN_WIDTH_M: CGFloat = 390
    private static let SCREEN_WIDTH_S: CGFloat = 375
    private static let SCREEN_WIDTH_XS: CGFloat = 320

    // MARK: - Functions
    
    private static func getSizes() -> UISizes {
        
        // NOTE: ~0.46 for iPhones with notch
        // NOTE: ~0.56 for iPhones without notch
        let hasNotch: Bool = ( Self.SCREEN_WIDTH_CURRENT / Self.SCREEN_HEIGHT_CURRENT ) < 0.5
        
        let widthMultiplier: CGFloat = Self.SCREEN_WIDTH_CURRENT / Self.SCREEN_WIDTH_S
        let heightMultiplier: CGFloat = Self.SCREEN_HEIGHT_CURRENT / Self.SCREEN_HEIGHT_M
        
        Utils.log(source: "getSizes", message: "dimensions = \(Self.SCREEN_WIDTH_CURRENT / Self.SCREEN_HEIGHT_CURRENT)")
        Utils.log(source: "getSizes", message: "hasNotch = \(hasNotch)")
        
        Utils.log(source: "getSizes", message: "widthMultiplier = \(widthMultiplier)")
        Utils.log(source: "getSizes", message: "heightMultiplier = \(heightMultiplier)")
        
        if hasNotch {
            return UISizes(
                
                welcomeSubTitleVPadding: heightMultiplier * 20,
                welcomeInputsVSpacing: heightMultiplier * 16,
                welcomeHintFontSize: heightMultiplier * 22,
                
                navbarHeight: heightMultiplier * 84,
                navbarPadding: heightMultiplier * 12,
                navbarSpacing: widthMultiplier * 54,

                calendarMonthFontSize: widthMultiplier * 20,
                calendarMonthButtonHeight: heightMultiplier * 44,
                calendarDayFontSize: heightMultiplier * 24,
                calendarDayButton: heightMultiplier * 44,
                
                entryInputBaseSize: heightMultiplier * 36,
                entryInputPadding: heightMultiplier * 27,
                entryHintBlockPadding: heightMultiplier * 16,
                entryBlockerIconPadding: heightMultiplier * 75,
                
                entryHintFontSize: widthMultiplier * 17,
                entryHintLabelFontSize: widthMultiplier * 15,
                entryHintHPadding: widthMultiplier * 30,
                
                trendsElementPadding: heightMultiplier * 10,
                trendsItemLabelFontSize: heightMultiplier * 18,
                trendsItemValueFontSize: heightMultiplier * 32,
                trendsItemUnitFontSize: heightMultiplier * 14,
                
                progressPageSpacing: heightMultiplier * 32,
                progressChartHeight: heightMultiplier * 180,
                progressCircleDiameter: heightMultiplier * 340,
                progressCircleWidth: heightMultiplier * 40,
                
                setupDefaultButtonHeight: heightMultiplier * 44,
                setupInputHeight: heightMultiplier * 74,
                setupInputLabelFontSize: heightMultiplier * 18,
                setupTargetDeltaPadding: heightMultiplier * 12,
                targetDeltaHPadding: widthMultiplier * 28,
                
                keyboardButtonWidth: widthMultiplier * 120,
                keyboardButtonHeight: heightMultiplier * 50,
                keyboardBottomPadding: heightMultiplier * 40
            )
        }
        else {
            return UISizes(
                
                welcomeSubTitleVPadding: getSizeByHeight(xxl: 40, xl: 40, l: 20, m: 20, s: 20, xs: 20, xxs: 4),
                welcomeInputsVSpacing: getSizeByHeight(xxl: 16, xl: 16, l: 16, m: 16, s: 16, xs: 16, xxs: 4),
                welcomeHintFontSize: getSizeByHeight(xxl: 24, xl: 24, l: 22, m: 22, s: 22, xs: 22, xxs: 18),
                
                navbarHeight: getSizeByHeight(xxl: 84, xl: 84, l: 84, m: 84, s: 60, xs: 60, xxs: 56),
                navbarPadding: getSizeByHeight(xxl: 12, xl: 12, l: 12, m: 12, s: 8, xs: 8, xxs: 6),
                navbarSpacing: getSizeByWidth(xl: 62, l: 62, m: 54, s: 54, xs: 42),

                calendarMonthFontSize: getSizeByWidth( xl: 24, l: 24, m: 24, s: 24, xs: 16),
                calendarMonthButtonHeight: getSizeByHeight(xxl: 44, xl: 44, l: 44, m: 44, s: 44, xs: 44, xxs: 36),
                calendarDayFontSize: getSizeByHeight(xxl: 24, xl: 24, l: 24, m: 24, s: 24, xs: 19, xxs: 18),
                calendarDayButton: getSizeByHeight(xxl: 48, xl: 46, l: 44, m: 44, s: 44, xs: 39, xxs: 31),
                
                entryInputBaseSize: getSizeByHeight(xxl: 40, xl: 40, l: 36, m: 36, s: 36, xs: 36, xxs: 30),
                entryInputPadding: getSizeByHeight(xxl: 39, xl: 39, l: 32, m: 27, s: 22, xs: 16, xxs: 14),
                entryHintBlockPadding: getSizeByHeight(xxl: 20, xl: 20, l: 16, m: 16, s: 10, xs: 6, xxs: 0),
                entryBlockerIconPadding: getSizeByHeight(xxl: 86, xl: 86, l: 75, m: 75, s: 52, xs: 47, xxs: 47),
                
                entryHintFontSize: getSizeByWidth(xl: 18, l: 17, m: 17, s: 17, xs: 14),
                entryHintLabelFontSize: getSizeByWidth(xl: 18, l: 17, m: 15, s: 15, xs: 12),
                entryHintHPadding: getSizeByWidth(xl: 34, l: 34, m: 34, s: 30, xs: 28),
                
                trendsElementPadding: getSizeByHeight(xxl: 17, xl: 17, l: 14, m: 10, s: 7, xs: 3, xxs: 2),
                trendsItemLabelFontSize: getSizeByHeight(xxl: 20, xl: 20, l: 18, m: 18, s: 18, xs: 18, xxs: 12),
                trendsItemValueFontSize: getSizeByHeight(xxl: 34, xl: 34, l: 32, m: 32, s: 32, xs: 32, xxs: 28),
                trendsItemUnitFontSize: getSizeByHeight(xxl: 16, xl: 16, l: 14, m: 14, s: 14, xs: 14, xxs: 12),
                
                progressPageSpacing: getSizeByHeight(xxl: 38, xl: 34, l: 34, m: 32, s: 16, xs: 8, xxs: 2),
                progressChartHeight: getSizeByHeight(xxl: 210, xl: 210, l: 180, m: 180, s: 180, xs: 160, xxs: 120),
                progressCircleDiameter: getSizeByHeight(xxl: 380, xl: 380, l: 340, m: 340, s: 340, xs: 310, xxs: 272),
                progressCircleWidth: getSizeByHeight(xxl: 56, xl: 56, l: 40, m: 40, s: 40, xs: 40, xxs: 30),
                
                setupDefaultButtonHeight: getSizeByHeight(xxl: 44, xl: 44, l: 44, m: 44, s: 44, xs: 44, xxs: 40),
                setupInputHeight: getSizeByHeight(xxl: 74, xl: 74, l: 74, m: 74, s: 68, xs: 58, xxs: 58),
                setupInputLabelFontSize: getSizeByHeight(xxl: 18, xl: 18, l: 18, m: 18, s: 18, xs: 18, xxs: 14),
                setupTargetDeltaPadding: getSizeByHeight(xxl: 12, xl: 12, l: 12, m: 12, s: 12, xs: 8, xxs: 8),
                targetDeltaHPadding: getSizeByWidth(xl: 40, l: 40, m: 32, s: 28, xs: 20),
                
                keyboardButtonWidth: getSizeByWidth(xl: 132, l: 132, m: 120, s: 120, xs: 102),
                keyboardButtonHeight: getSizeByHeight(xxl: 50, xl: 50, l: 50, m: 50, s: 50, xs: 50, xxs: 40),
                keyboardBottomPadding: getSizeByHeight(xxl: 40, xl: 40, l: 40, m: 40, s: 8, xs: 6, xxs: 6)
            )
        }
    }
    
    private static func getSizeByHeight(
        xxl: CGFloat, xl: CGFloat, l: CGFloat, m: CGFloat, s: CGFloat, xs: CGFloat, xxs: CGFloat
    ) -> CGFloat {
        
        if SCREEN_HEIGHT_CURRENT >= SCREEN_HEIGHT_XXL {
            return xxl
        }
        else if SCREEN_HEIGHT_CURRENT >= SCREEN_HEIGHT_XL {
            return xl
        }
        else if SCREEN_HEIGHT_CURRENT >= SCREEN_HEIGHT_L {
            return l
        }
        else if SCREEN_HEIGHT_CURRENT >= SCREEN_HEIGHT_M {
            return m
        }
        else if SCREEN_HEIGHT_CURRENT >= SCREEN_HEIGHT_S {
            return s
        }
        else if SCREEN_HEIGHT_CURRENT >= SCREEN_HEIGHT_XS {
            return xs
        }
        else {
            return xxs
        }
    }
    
    private static func getSizeByWidth(
        xl: CGFloat, l: CGFloat, m: CGFloat, s: CGFloat, xs: CGFloat
    ) -> CGFloat {
        
        if SCREEN_WIDTH_CURRENT >= SCREEN_WIDTH_XL {
            return xl
        }
        else if SCREEN_WIDTH_CURRENT >= SCREEN_WIDTH_L {
            return l
        }
        else if SCREEN_WIDTH_CURRENT >= SCREEN_WIDTH_M {
            return m
        }
        else if SCREEN_WIDTH_CURRENT >= SCREEN_WIDTH_S {
            return s
        }
        else {
            return xs
        }
    }
}
