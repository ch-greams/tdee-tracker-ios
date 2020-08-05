//
//  UIConstants.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 7/1/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI

struct UISizes {
    
    public static let current: UISizes = UIConstants.getUISizes(device: UIDevice.modelName)
    
    // MARK: - Welcome Page
    
    let welcomeConfirmButtonPadding: CGFloat
    
    // MARK: - Main View
    
    let mvVisibleScreenOffset: CGFloat
    let mvVisibleScreenHeight: CGFloat
    
    // MARK: - Navbar
    
    let navbarHeight: CGFloat
    let navbarPadding: CGFloat
    let navbarSpacing: CGFloat
    
    // MARK: - Calendar

    let calendarDayFontSize: CGFloat
    let calendarDaySelectedFontSize: CGFloat
    let calendarDayButton: CGFloat
    let calendarDaySpacing: CGFloat
    
    // MARK: - Entry Page
    
    let entryInputPadding: CGFloat
    let entryHintBlockPadding: CGFloat
    let entryBlockerIconPadding: CGFloat
    let entryOpenInputOffset: CGFloat
    
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



class UIConstants {
    
    // MARK: - UISizes
    
    public static let IPHONE_11_PRO_MAX: UISizes = UISizes(
        
        welcomeConfirmButtonPadding: 30,
        
        mvVisibleScreenOffset: 36,
        mvVisibleScreenHeight: 796,
        
        navbarHeight: 84,
        navbarPadding: 12,
        navbarSpacing: 62,

        calendarDayFontSize: 24,
        calendarDaySelectedFontSize: 24,
        calendarDayButton: 46,
        calendarDaySpacing: 8,
        
        entryInputPadding: 36,
        entryHintBlockPadding: 20,
        entryBlockerIconPadding: 86,
        entryOpenInputOffset: -2,
        
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

        mvVisibleScreenOffset: 36,
        mvVisibleScreenHeight: 714,
        
        navbarHeight: 84,
        navbarPadding: 12,
        navbarSpacing: 54,
        
        calendarDayFontSize: 22,
        calendarDaySelectedFontSize: 22,
        calendarDayButton: 40,
        calendarDaySpacing: 8,
        
        entryInputPadding: 30,
        entryHintBlockPadding: 16,
        entryBlockerIconPadding: 75,
        entryOpenInputOffset: -8,
        
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

        mvVisibleScreenOffset: 0,
        mvVisibleScreenHeight: 655,
        
        navbarHeight: 60,
        navbarPadding: 8,
        navbarSpacing: 62,

        calendarDayFontSize: 24,
        calendarDaySelectedFontSize: 24,
        calendarDayButton: 44,
        calendarDaySpacing: 8,
        
        entryInputPadding: 18,
        entryHintBlockPadding: 10,
        entryBlockerIconPadding: 52,
        entryOpenInputOffset: 8,
        
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

        mvVisibleScreenOffset: 0,
        mvVisibleScreenHeight: 586,
        
        navbarHeight: 60,
        navbarPadding: 8,
        navbarSpacing: 54,

        calendarDayFontSize: 18,
        calendarDaySelectedFontSize: 18,
        calendarDayButton: 36,
        calendarDaySpacing: 12,
        
        entryInputPadding: 16,
        entryHintBlockPadding: 6,
        entryBlockerIconPadding: 47,
        entryOpenInputOffset: 0,
        
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

    public static let IPHONE_SE: UISizes = UISizes(
        
        welcomeConfirmButtonPadding: 24,

        mvVisibleScreenOffset: 0,
        mvVisibleScreenHeight: 491,
        
        navbarHeight: 56,
        navbarPadding: 6,
        navbarSpacing: 42,

        calendarDayFontSize: 18,
        calendarDaySelectedFontSize: 18,
        calendarDayButton: 28,
        calendarDaySpacing: 12,
        
        entryInputPadding: 10,
        entryHintBlockPadding: 0,
        entryBlockerIconPadding: 47,
        entryOpenInputOffset: 0,
        
        trendsElementPadding: 2,
        trendsItemLabelFontSize: 14,
        trendsItemValueFontSize: 28,
        trendsItemUnitFontSize: 12,
        
        progressPageSpacing: 8,
        progressChartHeight: 160,
        progressCircleDiameter: 310,
        progressCircleWidth: 40,
        
        setupInputHeight: 58,
        setupTargetDeltaPadding: 8
    )

    
    
    public static func getUISizes(device: UIDeviceModel) -> UISizes {
        
        print(device.rawValue)
        
        switch device {
            
            case UIDeviceModel.iPhoneXR,
                 UIDeviceModel.iPhoneXSMax,
                 UIDeviceModel.iPhone11,
                 UIDeviceModel.iPhone11ProMax:
                
                return Self.IPHONE_11_PRO_MAX
            
            case UIDeviceModel.iPhoneX,
                 UIDeviceModel.iPhoneXS,
                 UIDeviceModel.iPhone11Pro:
                
                return Self.IPHONE_11_PRO

            case UIDeviceModel.iPhone6sPlus,
                 UIDeviceModel.iPhone7Plus,
                 UIDeviceModel.iPhone8Plus:
                
                return Self.IPHONE_8_PLUS

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
                
                return Self.IPHONE_8
            
            case UIDeviceModel.iPodTouch_7thGen,
                 UIDeviceModel.iPhoneSE_1stGen:
            
                return Self.IPHONE_SE
            
            case UIDeviceModel.UnidentifiedSimulator,
                 UIDeviceModel.Undefined:
                
                return Self.IPHONE_8
        }
    }
}
