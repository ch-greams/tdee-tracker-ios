//
//  ButtonStyle.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/25/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


// MARK: - General

struct AppDefaultButtonStyleSizes {
    
    // MARK: - Sizes
    
    public let width: CGFloat = 176
    public let height: CGFloat
    
    // MARK: - Fonts

    public let font: Font = .custom(FontOswald.Medium, size: 18)
    
    // MARK: - Init
    
    init(uiSizes: UISizes) {
        
        self.height = uiSizes.setupDefaultButtonHeight
    }
}

struct AppDefaultButtonStyle: ButtonStyle {
    
    private let sizes = AppDefaultButtonStyleSizes(uiSizes: UISizes.current)
 
    let backgroundColor: Color
    let textColor: Color
    
    var withBorder: Bool = false
    
    var font: Font?
    
    var width: CGFloat?
    var height: CGFloat?
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(
                width: self.width ?? self.sizes.width,
                height: self.height ?? self.sizes.height
            )
            .background(self.backgroundColor)
            .foregroundColor(self.textColor)
            .font(self.font ?? self.sizes.font)
            .border(self.withBorder ? self.textColor : self.backgroundColor)
    }
}


// MARK: - Calendar

struct CalendarDayButtonStyleSizes {
    
    // MARK: - Fonts

    public let defaultFont: Font
    public let selectedFont: Font
    
    // MARK: - Init
    
    init(uiSizes: UISizes) {
        
        self.defaultFont = .custom(FontOswald.ExtraLight, size: uiSizes.calendarDayFontSize)
        self.selectedFont = .custom(FontOswald.Medium, size: uiSizes.calendarDaySelectedFontSize)
    }
}


struct CalendarDayButtonStyle: ButtonStyle {
    
    private let sizes = CalendarDayButtonStyleSizes(uiSizes: UISizes.current)
    
    let buttonSize: CGFloat
    let isSelected: Bool
    
    let textColor: Color
    let backgroundColor: Color?

 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: self.buttonSize, height: self.buttonSize, alignment: .center)
            .background(self.backgroundColor)
            .foregroundColor(self.textColor)
            .font(self.isSelected ? self.sizes.selectedFont : self.sizes.defaultFont)
            .cornerRadius(buttonSize / 2)
    }
}


struct CalendarChangeMonthButtonStyleSizes {
    
    // MARK: - Sizes
    
    public let width: CGFloat = 80
    
    public let hPadding: CGFloat = 8
    
    public let height: CGFloat
    
    // MARK: - Init
    
    init(uiSizes: UISizes) {
        
        self.height = uiSizes.calendarMonthButtonHeight
    }
}


struct CalendarChangeMonthButtonStyle: ButtonStyle {
    
    private let sizes = CalendarChangeMonthButtonStyleSizes(uiSizes: UISizes.current)
    
    let backgroundColor: Color
 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: self.sizes.width, height: self.sizes.height)
            .background(backgroundColor)
            .padding(.horizontal, self.sizes.hPadding)
            .clipped()
            .shadow(color: .SHADOW_COLOR, radius: 1, x: 1, y: 1)
    }
}


// MARK: - Input

struct InputToggleButtonStyleSizes {
    
    // MARK: - Sizes
    
    public let width: CGFloat = 90
    public let height: CGFloat = 40
    
    // MARK: - Fonts

    public let font: Font = .custom(FontOswald.Bold, size: 18)
}


struct InputToggleButtonStyle: ButtonStyle {
    
    private let sizes = InputToggleButtonStyleSizes()
    
    let isSelected: Bool
    let backgroundColor: Color
    let accentColor: Color
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: self.sizes.width, height: self.sizes.height)
            .background(self.isSelected ? self.accentColor : self.backgroundColor)
            .foregroundColor(!self.isSelected ? self.accentColor : self.backgroundColor)
            .font(self.sizes.font)
    }
}


struct InputSelectButtonStyleSizes {
    
    // MARK: - Sizes
    
    public let widthCollapsed: CGFloat = 126
    public let width: CGFloat = 180
    public let height: CGFloat = 44
    
    // MARK: - Fonts
    
    public let valueFont: Font = .custom(FontOswald.Bold, size: 32)
    public let buttonLabelFont: Font = .custom(FontOswald.Bold, size: 24)
}


struct InputSelectButtonStyle: ButtonStyle {
    
    private let sizes = InputSelectButtonStyleSizes()
 
    let backgroundColor: Color
    let accentColor: Color
    
    let isThemeButton: Bool

    var isSelected: Bool = false

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(
                width: isThemeButton ? self.sizes.widthCollapsed : self.sizes.width,
                height: self.sizes.height
            )
            .background(isSelected ? self.accentColor : self.backgroundColor)
            .foregroundColor(!isSelected ? self.accentColor : self.backgroundColor)
            .font(isThemeButton ? self.sizes.buttonLabelFont : self.sizes.valueFont)
            .border(self.accentColor)
    }
}
