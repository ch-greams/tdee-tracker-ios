//
//  UISizes.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 7/1/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct UISizes {
    
    // NOTE: 9:19.5 ~0.46 for iPhones with notch
    // NOTE: 9:16   ~0.56 for iPhones without notch
    public static let hasNotch: Bool = ( Self.SCREEN_WIDTH_CURRENT / Self.SCREEN_HEIGHT_CURRENT ) < 0.5
    
    public static let scale: CGFloat = {
        
        if Self.hasNotch {

            let widthMultiplier: CGFloat = Self.SCREEN_WIDTH_CURRENT / Self.SCREEN_WIDTH_S
            let heightMultiplier: CGFloat = Self.SCREEN_HEIGHT_CURRENT / Self.SCREEN_HEIGHT_M

            return ( widthMultiplier + heightMultiplier ) / 2
        }
        else {

            let widthMultiplier: CGFloat = Self.SCREEN_WIDTH_CURRENT / Self.SCREEN_WIDTH_XS
            let heightMultiplier: CGFloat = Self.SCREEN_HEIGHT_CURRENT / Self.SCREEN_HEIGHT_XXS

            return ( widthMultiplier + heightMultiplier ) / 2
        }
    }()
    
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
}
