//
//  ButtonStyle.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/25/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


// MARK: - General

struct AppDefaultButtonStyle: ButtonStyle {
 
    let backgroundColor: Color
    let textColor: Color
    
    var withBorder: Bool = false
    var font: Font = .appDefaultButtonLabel
    
    var width: CGFloat = 176
    var height: CGFloat = 44
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: self.width, height: self.height)
            .border(self.withBorder ? self.textColor : self.backgroundColor)
            .font(self.font)
            .foregroundColor(self.textColor)
            .background(self.backgroundColor)
    }
}


// MARK: - Calendar

struct CalendarDayButtonStyle: ButtonStyle {
    
    let buttonSize: CGFloat
    let font: Font
    
    let textColor: Color
    let backgroundColor: Color?

 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(self.font)
            .frame(width: self.buttonSize, height: self.buttonSize, alignment: .center)
            .foregroundColor(self.textColor)
            .background(self.backgroundColor)
            .cornerRadius(buttonSize / 2)
    }
}

struct CalendarChangeMonthButtonStyle: ButtonStyle {
    
    let backgroundColor: Color
 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 80, height: 44)
            .background(backgroundColor)
            .padding(.horizontal, 8)
            .clipped()
            .shadow(color: .SHADOW_COLOR, radius: 1, x: 1, y: 1)
    }
}


// MARK: - Input

struct InputToggleButtonStyle: ButtonStyle {
    
    let isSelected: Bool
    let backgroundColor: Color
    let accentColor: Color
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 90, height: 40)
            .font(.appSetupToggleValue)
            .foregroundColor(!self.isSelected ? self.accentColor : self.backgroundColor)
            .background(self.isSelected ? self.accentColor : self.backgroundColor)
    }
}

struct InputSelectButtonStyle: ButtonStyle {
 
    let backgroundColor: Color
    let accentColor: Color
    var font = Font.appInputValue
    var isSelected: Bool = false

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 180, height: 44)
            .border(self.accentColor)
            .background(isSelected ? self.accentColor : self.backgroundColor)
            .font(self.font)
            .foregroundColor(!isSelected ? self.accentColor : self.backgroundColor)
    }
}
