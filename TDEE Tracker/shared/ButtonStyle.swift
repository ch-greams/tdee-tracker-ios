//
//  ButtonStyle.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/25/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct ToggleButtonStyle: ButtonStyle {
    
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


struct DayButtonStyle: ButtonStyle {
    
    let buttonSize: CGFloat
    let fontSize: CGFloat
    
    let textColor: Color
    let backgroundColor: Color
    
    let isSelected: Bool
 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(
                self.isSelected
                    ? .appCalendarDaySelected(self.fontSize)
                    : .appCalendarDay(self.fontSize)
            )
            .frame(width: self.buttonSize, height: self.buttonSize, alignment: .center)
            .foregroundColor(self.textColor)
            .background(self.isSelected ? self.backgroundColor : nil)
            .cornerRadius(buttonSize / 2)
    }
}


struct ChangeMonthButtonStyle: ButtonStyle {
    
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


struct AppDefaultButtonStyle: ButtonStyle {
 
    let backgroundColor: Color
    let textColor: Color
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 176, height: 44)
            .font(.appDefaultButtonLabel)
            .foregroundColor(self.textColor)
            .background(self.backgroundColor)
    }
}


struct ReminderTimeButtonStyle: ButtonStyle {
 
    let backgroundColor: Color
    let accentColor: Color
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 180, height: 44)
            .border(self.accentColor)
            .background(self.backgroundColor)
            .font(.appInputValue)
            .foregroundColor(self.accentColor)
    }
}
