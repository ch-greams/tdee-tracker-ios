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
    let welcomeConfirmButtonPadding: CGFloat
    let welcomeHintFontSize: CGFloat
    
    // MARK: - Navbar
    
    let navbarHeight: CGFloat
    let navbarPadding: CGFloat
    let navbarSpacing: CGFloat
    
    // MARK: - Calendar

    let calendarMonthFontSize: CGFloat
    let calendarMonthButtonHeight: CGFloat
    let calendarDayFontSize: CGFloat
    let calendarDaySelectedFontSize: CGFloat
    let calendarDayButton: CGFloat
    let calendarDaySpacing: CGFloat
    
    // MARK: - Entry Page
    
    let entryInputBaseSize: CGFloat
    let entryInputPadding: CGFloat
    let entryInputPaddingOpenOffset: CGFloat
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
    
    public static let current: UISizes = UISizes.getUISizes(device: UIDevice.modelName)
    
    // MARK: - Constants
    
    
    public static let IPHONE_12_PRO_MAX: UISizes = UISizes(
        
        welcomeSubTitleVPadding: 40,
        welcomeInputsVSpacing: 16,
        welcomeConfirmButtonPadding: 30,
        welcomeHintFontSize: 24,
        
        navbarHeight: 84,
        navbarPadding: 12,
        navbarSpacing: 62,

        calendarMonthFontSize: 24,
        calendarMonthButtonHeight: 44,
        calendarDayFontSize: 24,
        calendarDaySelectedFontSize: 24,
        calendarDayButton: 48,
        calendarDaySpacing: 8,
        
        entryInputBaseSize: 40,
        entryInputPadding: 39,
        entryInputPaddingOpenOffset: 0,
        entryHintBlockPadding: 20,
        entryBlockerIconPadding: 86,

        entryHintFontSize: 18,
        entryHintLabelFontSize: 18,
        entryHintHPadding: 34,
        
        trendsElementPadding: 17,
        trendsItemLabelFontSize: 20,
        trendsItemValueFontSize: 34,
        trendsItemUnitFontSize: 16,
        
        progressPageSpacing: 38,
        progressChartHeight: 210,
        progressCircleDiameter: 380,
        progressCircleWidth: 56,
        
        setupDefaultButtonHeight: 44,
        setupInputHeight: 74,
        setupInputLabelFontSize: 18,
        setupTargetDeltaPadding: 12,
        targetDeltaHPadding: 40,
        
        keyboardButtonWidth: 132,
        keyboardButtonHeight: 50,
        keyboardBottomPadding: 40
    )
    
    public static let IPHONE_11_PRO_MAX: UISizes = UISizes(
        
        welcomeSubTitleVPadding: 40,
        welcomeInputsVSpacing: 16,
        welcomeConfirmButtonPadding: 30,
        welcomeHintFontSize: 24,
        
        navbarHeight: 84,
        navbarPadding: 12,
        navbarSpacing: 62,

        calendarMonthFontSize: 24,
        calendarMonthButtonHeight: 44,
        calendarDayFontSize: 24,
        calendarDaySelectedFontSize: 24,
        calendarDayButton: 46,
        calendarDaySpacing: 8,
        
        entryInputBaseSize: 40,
        entryInputPadding: 39,
        entryInputPaddingOpenOffset: 0,
        entryHintBlockPadding: 20,
        entryBlockerIconPadding: 86,

        entryHintFontSize: 18,
        entryHintLabelFontSize: 18,
        entryHintHPadding: 34,
        
        trendsElementPadding: 17,
        trendsItemLabelFontSize: 20,
        trendsItemValueFontSize: 34,
        trendsItemUnitFontSize: 16,
        
        progressPageSpacing: 34,
        progressChartHeight: 210,
        progressCircleDiameter: 380,
        progressCircleWidth: 56,
        
        setupDefaultButtonHeight: 44,
        setupInputHeight: 74,
        setupInputLabelFontSize: 18,
        setupTargetDeltaPadding: 12,
        targetDeltaHPadding: 40,
        
        keyboardButtonWidth: 132,
        keyboardButtonHeight: 50,
        keyboardBottomPadding: 40
    )
    
    public static let IPHONE_12_PRO: UISizes = UISizes(
        
        welcomeSubTitleVPadding: 20,
        welcomeInputsVSpacing: 16,
        welcomeConfirmButtonPadding: 30,
        welcomeHintFontSize: 22,
        
        navbarHeight: 84,
        navbarPadding: 12,
        navbarSpacing: 54,
        
        calendarMonthFontSize: 24,
        calendarMonthButtonHeight: 44,
        calendarDayFontSize: 22,
        calendarDaySelectedFontSize: 22,
        calendarDayButton: 42,
        calendarDaySpacing: 8,
        
        entryInputBaseSize: 36,
        entryInputPadding: 32,
        entryInputPaddingOpenOffset: -1,
        entryHintBlockPadding: 16,
        entryBlockerIconPadding: 75,
        
        entryHintFontSize: 17,
        entryHintLabelFontSize: 15,
        entryHintHPadding: 36,
        
        trendsElementPadding: 16,
        trendsItemLabelFontSize: 18,
        trendsItemValueFontSize: 32,
        trendsItemUnitFontSize: 14,
        
        progressPageSpacing: 36,
        progressChartHeight: 180,
        progressCircleDiameter: 340,
        progressCircleWidth: 40,
        
        setupDefaultButtonHeight: 44,
        setupInputHeight: 74,
        setupInputLabelFontSize: 18,
        setupTargetDeltaPadding: 12,
        targetDeltaHPadding: 32,
        
        keyboardButtonWidth: 120,
        keyboardButtonHeight: 50,
        keyboardBottomPadding: 40
    )
    
    public static let IPHONE_11_PRO: UISizes = UISizes(
        
        welcomeSubTitleVPadding: 20,
        welcomeInputsVSpacing: 16,
        welcomeConfirmButtonPadding: 30,
        welcomeHintFontSize: 22,
        
        navbarHeight: 84,
        navbarPadding: 12,
        navbarSpacing: 54,
        
        calendarMonthFontSize: 24,
        calendarMonthButtonHeight: 44,
        calendarDayFontSize: 22,
        calendarDaySelectedFontSize: 22,
        calendarDayButton: 40,
        calendarDaySpacing: 8,
        
        entryInputBaseSize: 36,
        entryInputPadding: 32,
        entryInputPaddingOpenOffset: -1,
        entryHintBlockPadding: 16,
        entryBlockerIconPadding: 75,
        
        entryHintFontSize: 17,
        entryHintLabelFontSize: 15,
        entryHintHPadding: 36,
        
        trendsElementPadding: 16,
        trendsItemLabelFontSize: 18,
        trendsItemValueFontSize: 32,
        trendsItemUnitFontSize: 14,
        
        progressPageSpacing: 32,
        progressChartHeight: 180,
        progressCircleDiameter: 340,
        progressCircleWidth: 40,
        
        setupDefaultButtonHeight: 44,
        setupInputHeight: 74,
        setupInputLabelFontSize: 18,
        setupTargetDeltaPadding: 12,
        targetDeltaHPadding: 32,
        
        keyboardButtonWidth: 120,
        keyboardButtonHeight: 50,
        keyboardBottomPadding: 40
    )
    
    public static let IPHONE_8_PLUS: UISizes = UISizes(
        
        welcomeSubTitleVPadding: 20,
        welcomeInputsVSpacing: 16,
        welcomeConfirmButtonPadding: 24,
        welcomeHintFontSize: 22,
        
        navbarHeight: 60,
        navbarPadding: 8,
        navbarSpacing: 62,

        calendarMonthFontSize: 24,
        calendarMonthButtonHeight: 44,
        calendarDayFontSize: 24,
        calendarDaySelectedFontSize: 24,
        calendarDayButton: 44,
        calendarDaySpacing: 8,
        
        entryInputBaseSize: 36,
        entryInputPadding: 22,
        entryInputPaddingOpenOffset: 4,
        entryHintBlockPadding: 10,
        entryBlockerIconPadding: 52,
        
        entryHintFontSize: 17,
        entryHintLabelFontSize: 17,
        entryHintHPadding: 40,
        
        trendsElementPadding: 7,
        trendsItemLabelFontSize: 18,
        trendsItemValueFontSize: 32,
        trendsItemUnitFontSize: 14,
        
        progressPageSpacing: 16,
        progressChartHeight: 180,
        progressCircleDiameter: 340,
        progressCircleWidth: 40,
        
        setupDefaultButtonHeight: 44,
        setupInputHeight: 68,
        setupInputLabelFontSize: 18,
        setupTargetDeltaPadding: 12,
        targetDeltaHPadding: 40,
        
        keyboardButtonWidth: 132,
        keyboardButtonHeight: 44,
        keyboardBottomPadding: 8
    )

    public static let IPHONE_8: UISizes = UISizes(
        
        welcomeSubTitleVPadding: 20,
        welcomeInputsVSpacing: 16,
        welcomeConfirmButtonPadding: 24,
        welcomeHintFontSize: 22,
        
        navbarHeight: 60,
        navbarPadding: 8,
        navbarSpacing: 54,

        calendarMonthFontSize: 24,
        calendarMonthButtonHeight: 44,
        calendarDayFontSize: 18,
        calendarDaySelectedFontSize: 18,
        calendarDayButton: 36,
        calendarDaySpacing: 12,
        
        entryInputBaseSize: 36,
        entryInputPadding: 21,
        entryInputPaddingOpenOffset: -4,
        entryHintBlockPadding: 6,
        entryBlockerIconPadding: 47,
        
        entryHintFontSize: 17,
        entryHintLabelFontSize: 16,
        entryHintHPadding: 30,
        
        trendsElementPadding: 5,
        trendsItemLabelFontSize: 18,
        trendsItemValueFontSize: 32,
        trendsItemUnitFontSize: 14,
        
        progressPageSpacing: 8,
        progressChartHeight: 160,
        progressCircleDiameter: 310,
        progressCircleWidth: 40,
        
        setupDefaultButtonHeight: 44,
        setupInputHeight: 58,
        setupInputLabelFontSize: 18,
        setupTargetDeltaPadding: 8,
        targetDeltaHPadding: 28,
        
        keyboardButtonWidth: 120,
        keyboardButtonHeight: 50,
        keyboardBottomPadding: 6
    )

    public static let IPHONE_SE: UISizes = UISizes(
        
        welcomeSubTitleVPadding: 4,
        welcomeInputsVSpacing: 4,
        welcomeConfirmButtonPadding: 24,
        welcomeHintFontSize: 18,
        
        navbarHeight: 56,
        navbarPadding: 6,
        navbarSpacing: 42,

        calendarMonthFontSize: 16,
        calendarMonthButtonHeight: 36,
        calendarDayFontSize: 18,
        calendarDaySelectedFontSize: 18,
        calendarDayButton: 30,
        calendarDaySpacing: 12,
        
        entryInputBaseSize: 30,
        entryInputPadding: 16,
        entryInputPaddingOpenOffset: -2,
        entryHintBlockPadding: 0,
        entryBlockerIconPadding: 47,
        
        entryHintFontSize: 14,
        entryHintLabelFontSize: 12,
        entryHintHPadding: 28,
        
        trendsElementPadding: 3,
        trendsItemLabelFontSize: 12,
        trendsItemValueFontSize: 28,
        trendsItemUnitFontSize: 12,
        
        progressPageSpacing: 2,
        progressChartHeight: 120,
        progressCircleDiameter: 272,
        progressCircleWidth: 30,
        
        setupDefaultButtonHeight: 40,
        setupInputHeight: 58,
        setupInputLabelFontSize: 14,
        setupTargetDeltaPadding: 8,
        targetDeltaHPadding: 20,
        
        keyboardButtonWidth: 102,
        keyboardButtonHeight: 40,
        keyboardBottomPadding: 6
    )

    // MARK: - Functions
    
    public static func getUISizes(device: UIDeviceModel) -> UISizes {
        
        Utils.log(source: "UISizes.getUISizes", message: device.rawValue)
        
        switch device {
            
            case UIDeviceModel.iPhone12ProMax:
                
                return Self.IPHONE_12_PRO_MAX
            
            case UIDeviceModel.iPhoneXR,
                 UIDeviceModel.iPhoneXSMax,
                 UIDeviceModel.iPhone11,
                 UIDeviceModel.iPhone11ProMax:
                
                return Self.IPHONE_11_PRO_MAX
            
            case UIDeviceModel.iPhone12,
                 UIDeviceModel.iPhone12Pro:
                
                return Self.IPHONE_12_PRO
                
            case UIDeviceModel.iPhoneX,
                 UIDeviceModel.iPhoneXS,
                 UIDeviceModel.iPhone11Pro,
                 UIDeviceModel.iPhone12Mini:
                
                return Self.IPHONE_11_PRO

            case UIDeviceModel.iPhone6sPlus,
                 UIDeviceModel.iPhone7Plus,
                 UIDeviceModel.iPhone8Plus:
                
                let isZoomed = UIScreen.main.nativeScale > 3
                
                return isZoomed ? Self.IPHONE_8 : Self.IPHONE_8_PLUS

            case UIDeviceModel.iPhone6s,
                 UIDeviceModel.iPhone7,
                 UIDeviceModel.iPhone8,
                 UIDeviceModel.iPhoneSE_2ndGen,
                 
                 UIDeviceModel.iPad5thGen,
                 UIDeviceModel.iPad6thGen,
                 UIDeviceModel.iPad7thGen,
                 UIDeviceModel.iPadAir2,
                 UIDeviceModel.iPadAir_3rdGen,
                 UIDeviceModel.iPadMini4,
                 UIDeviceModel.iPadMini_5thGen,
                 UIDeviceModel.iPadPro9i,
                 UIDeviceModel.iPadPro10i,
                 UIDeviceModel.iPadPro11i_1stGen,
                 UIDeviceModel.iPadPro11i_2ndGen,
                 UIDeviceModel.iPadPro12i_1stGen,
                 UIDeviceModel.iPadPro12i_2ndGen,
                 UIDeviceModel.iPadPro12i_3rdGen,
                 UIDeviceModel.iPadPro12i_4thGen:
                
                let isZoomed = UIScreen.main.nativeScale > 2
                
                return isZoomed ? Self.IPHONE_SE : Self.IPHONE_8
            
            case UIDeviceModel.iPodTouch_7thGen,
                 UIDeviceModel.iPhoneSE_1stGen:
            
                return Self.IPHONE_SE
            
            case UIDeviceModel.UnidentifiedSimulator,
                 UIDeviceModel.Undefined:
                
                return Self.IPHONE_8
        }
    }
}
