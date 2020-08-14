//
//  Font.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/3/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


public enum FontOswald: String {
    
    case ExtraLight = "Oswald-ExtraLight"
    case Light = "Oswald-Light"
    case Regular = "Oswald-Regular"
    case Medium = "Oswald-Medium"
    case Bold = "Oswald-Bold"
}

extension Font {
    
    public static func custom(_ font: FontOswald, size: CGFloat) -> Font {
        Self.custom(font.rawValue, size: size)
    }
}
