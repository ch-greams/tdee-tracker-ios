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
    
    public static let current: UISizes = UISizes()
    
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
    
    init() {
        
        // NOTE: 9:19.5 ~0.46 for iPhones with notch
        // NOTE: 9:16   ~0.56 for iPhones without notch
        let hasNotch: Bool = ( Self.SCREEN_WIDTH_CURRENT / Self.SCREEN_HEIGHT_CURRENT ) < 0.5

        if hasNotch {
            
            let widthMultiplier: CGFloat = Self.SCREEN_WIDTH_CURRENT / Self.SCREEN_WIDTH_S
            let heightMultiplier: CGFloat = Self.SCREEN_HEIGHT_CURRENT / Self.SCREEN_HEIGHT_M
            
            let scale = ( widthMultiplier + heightMultiplier ) / 2

            // Self.SCREEN_WIDTH_S x Self.SCREEN_HEIGHT_M

            self.welcomeSubTitleVPadding = scale * 20
            self.welcomeInputsVSpacing = scale * 16
            self.welcomeHintFontSize = scale * 22

            self.navbarHeight = scale * 84
            self.navbarPadding = scale * 12
            self.navbarSpacing = scale * 54

            self.calendarMonthFontSize = scale * 20
            self.calendarMonthButtonHeight = scale * 44
            self.calendarDayFontSize = scale * 24
            self.calendarDayButton = scale * 44

            self.entryInputBaseSize = scale * 36
            self.entryInputPadding = scale * 27
            self.entryHintBlockPadding = scale * 16
            self.entryBlockerIconPadding = scale * 75

            self.entryHintFontSize = scale * 17
            self.entryHintLabelFontSize = scale * 15
            self.entryHintHPadding = scale * 30

            self.trendsElementPadding = scale * 10
            self.trendsItemLabelFontSize = scale * 18
            self.trendsItemValueFontSize = scale * 32
            self.trendsItemUnitFontSize = scale * 14

            self.progressPageSpacing = scale * 32
            self.progressChartHeight = scale * 180
            self.progressCircleDiameter = scale * 340
            self.progressCircleWidth = scale * 40

            self.setupDefaultButtonHeight = scale * 44
            self.setupInputHeight = scale * 74
            self.setupInputLabelFontSize = scale * 18
            self.setupTargetDeltaPadding = scale * 12
            self.targetDeltaHPadding = scale * 28

            self.keyboardButtonWidth = scale * 120
            self.keyboardButtonHeight = scale * 50
            self.keyboardBottomPadding = scale * 40
        }
        else {

            let widthMultiplier: CGFloat = Self.SCREEN_WIDTH_CURRENT / Self.SCREEN_WIDTH_XS
            let heightMultiplier: CGFloat = Self.SCREEN_HEIGHT_CURRENT / Self.SCREEN_HEIGHT_XXS
            
            let scale = ( widthMultiplier + heightMultiplier ) / 2
            
            // Self.SCREEN_WIDTH_XS x Self.SCREEN_HEIGHT_XXS

            self.welcomeSubTitleVPadding = scale * 4
            self.welcomeInputsVSpacing = scale * 4
            self.welcomeHintFontSize = scale * 18

            self.navbarHeight = scale * 56
            self.navbarPadding = scale * 6
            self.navbarSpacing = scale * 42

            self.calendarMonthFontSize = scale * 16
            self.calendarMonthButtonHeight = scale * 36
            self.calendarDayFontSize = scale * 18
            self.calendarDayButton = scale * 31

            self.entryInputBaseSize = scale * 30
            self.entryInputPadding = scale * 14
            self.entryHintBlockPadding = scale * 0
            self.entryBlockerIconPadding = scale * 47

            self.entryHintFontSize = scale * 14
            self.entryHintLabelFontSize = scale * 12
            self.entryHintHPadding = scale * 28

            self.trendsElementPadding = scale * 2
            self.trendsItemLabelFontSize = scale * 12
            self.trendsItemValueFontSize = scale * 28
            self.trendsItemUnitFontSize = scale * 12

            self.progressPageSpacing = scale * 2
            self.progressChartHeight = scale * 120
            self.progressCircleDiameter = scale * 272
            self.progressCircleWidth = scale * 30

            self.setupDefaultButtonHeight = scale * 40
            self.setupInputHeight = scale * 58
            self.setupInputLabelFontSize = scale * 14
            self.setupTargetDeltaPadding = scale * 8
            self.targetDeltaHPadding = scale * 20

            self.keyboardButtonWidth = scale * 102
            self.keyboardButtonHeight = scale * 40
            self.keyboardBottomPadding = scale * 6
        }
    }
}
