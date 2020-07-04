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
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 90, height: 40)
            .font(.appSetupToggleValue)
            .foregroundColor(!self.isSelected ? Color.appPrimary : Color.appWhite)
            .background(self.isSelected ? Color.appPrimary : Color.appWhite)
    }
}


struct DayButtonStyle: ButtonStyle {
    
    let buttonSize: CGFloat
    let fontSize: CGFloat
    
    let color: Color
    let isSelected: Bool
 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(
                self.isSelected
                    ? .appCalendarDaySelected(self.fontSize)
                    : .appCalendarDay(self.fontSize)
            )
            .frame(width: self.buttonSize, height: self.buttonSize, alignment: .center)
            .foregroundColor(self.color)
            .background(self.isSelected ? Color.appPrimary : nil)
            .cornerRadius(buttonSize / 2)
    }
}


struct ChangeMonthButtonStyle: ButtonStyle {
 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 44, height: 10)
            .padding()
            .foregroundColor(.appPrimary)
            .background(Color(hue: 0, saturation: 0, brightness: 0.96))
            .padding(.horizontal, 8)
            .clipped()
            .shadow(color: .gray, radius: 1, x: 1, y: 1)
    }
}


struct AppDefaultButtonStyle: ButtonStyle {
 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 176, height: 44)
            .font(.appDefaultButtonLabel)
            .foregroundColor(.appPrimary)
            .background(Color.appWhite)
    }
}


struct ReminderTimeButtonStyle: ButtonStyle {
 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 180, height: 44)
            .border(Color.appPrimary)
            .background(Color.appWhite)
            .font(.appInputValue)
            .foregroundColor(.appPrimary)
    }
}