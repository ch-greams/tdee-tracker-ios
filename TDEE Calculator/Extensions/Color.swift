//
//  Color.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/2/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
    
    // Colors without assets are unused
    
    public static var appPrimary: Color {
        Color("teal", bundle: nil)
    }

    public static var appPrimaryLight: Color {
        Color("tealLight", bundle: nil)
    }

    public static var appPrimaryDark: Color {
        Color("tealDark", bundle: nil)
    }

    public static var appPrimaryText: Color {
        Color("greyDark")
    }

    public static var appPrimaryTextLight: Color {
        Color("greyLight")
    }
    
    public static var appSecondary: Color {
        Color("deepOrange", bundle: nil)
    }

    public static var appSecondaryLight: Color {
        Color(red: 1.00, green: 0.64, blue: 0.44)
    }

    public static var appSecondaryDark: Color {
        Color(red: 0.78, green: 0.25, blue: 0.09)
    }

    public static var appSecondaryText: Color {
        Color(red: 0.00, green: 0.00, blue: 0.00)
    }

}

