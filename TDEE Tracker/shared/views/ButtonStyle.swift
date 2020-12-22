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
    
    public let width: CGFloat
    public let height: CGFloat
    
    // MARK: - Fonts

    public let font: Font
    
    // MARK: - Init
    
    init(hasNotch: Bool, scale: CGFloat) {
        
        self.width = scale * 176

        self.font = .custom(FontOswald.Medium, size: scale * 18)

        if hasNotch {
            self.height = scale * 44
        }
        else {
            self.height = scale * 40
        }
    }
}

struct AppDefaultButtonStyle: ButtonStyle {
    
    private let sizes = AppDefaultButtonStyleSizes(hasNotch: UISizes.hasNotch, scale: UISizes.scale)
 
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
    
    init(hasNotch: Bool, scale: CGFloat) {
        
        if hasNotch {
            self.defaultFont = .custom(FontOswald.ExtraLight, size: scale * 24)
            self.selectedFont = .custom(FontOswald.Medium, size: scale * 24)
        }
        else {
            self.defaultFont = .custom(FontOswald.ExtraLight, size: scale * 18)
            self.selectedFont = .custom(FontOswald.Medium, size: scale * 18)
        }
    }
}


struct CalendarDayButtonStyle: ButtonStyle {
    
    private let sizes = CalendarDayButtonStyleSizes(hasNotch: UISizes.hasNotch, scale: UISizes.scale)
    
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
    
    public let width: CGFloat
    public let hPadding: CGFloat
    
    public let height: CGFloat
    
    // MARK: - Init
    
    init(hasNotch: Bool, scale: CGFloat) {
        
        self.width = scale * 80
        self.hPadding = 8

        if hasNotch {
            self.height = scale * 44
        }
        else {
            self.height = scale * 36
        }
    }
}


struct CalendarChangeMonthButtonStyle: ButtonStyle {
    
    private let sizes = CalendarChangeMonthButtonStyleSizes(hasNotch: UISizes.hasNotch, scale: UISizes.scale)
    
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
    
    public let width: CGFloat
    public let height: CGFloat
    
    // MARK: - Fonts

    public let font: Font

    // MARK: - Init
    
    init(hasNotch: Bool, scale: CGFloat) {
        
        self.width = scale * 90
        self.height = scale * 40

        self.font = .custom(FontOswald.Bold, size: scale * 18)
    }
}


struct InputToggleButtonStyle: ButtonStyle {
    
    private let sizes = InputToggleButtonStyleSizes(hasNotch: UISizes.hasNotch, scale: UISizes.scale)
    
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


struct InputCheckButtonStyleSizes {
    
    // MARK: - Sizes
    
    public let width: CGFloat
    public let height: CGFloat

    // MARK: - Init
    
    init(hasNotch: Bool, scale: CGFloat) {

        self.width = scale * 88
        self.height = scale * 44
    }
}


struct InputCheckButtonStyle: ButtonStyle {
    
    private let sizes = InputCheckButtonStyleSizes(hasNotch: UISizes.hasNotch, scale: UISizes.scale)
 
    let backgroundColor: Color
    let accentColor: Color

    let isSelected: Bool

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: self.sizes.width, height: self.sizes.height)
            .background(isSelected ? self.accentColor : self.backgroundColor)
            .foregroundColor(!isSelected ? self.accentColor : self.backgroundColor)
            .border(self.accentColor)
    }
}


struct KeyboardButtonStyleSizes {
    
    // MARK: - Sizes
    
    public let width: CGFloat
    public let height: CGFloat
    
    // MARK: - Init
    
    init(hasNotch: Bool, scale: CGFloat) {

        if hasNotch {
            self.width = scale * 120
            self.height = scale * 50
        }
        else {
            self.width = scale * 102
            self.height = scale * 40
        }
    }
}

struct KeyboardButtonStyle: ButtonStyle {
    
    private let sizes = KeyboardButtonStyleSizes(hasNotch: UISizes.hasNotch, scale: UISizes.scale)
 
    let backgroundColor: Color
    let textColor: Color

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: self.sizes.width, height: self.sizes.height, alignment: .center)
            .background(configuration.isPressed ? self.backgroundColor.opacity(0.5) : self.backgroundColor)
            .foregroundColor(self.textColor)
            .animation(.default)
    }
}

