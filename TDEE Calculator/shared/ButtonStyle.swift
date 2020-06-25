//
//  ButtonStyle.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/25/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct ToggleButtonStyle: ButtonStyle {
    
    var isSelected: Bool
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 90, height: 40)
            .font(.appSetupToggleValue)
            .foregroundColor(!self.isSelected ? Color.appPrimary : Color.white)
            .background(self.isSelected ? Color.appPrimary : Color.white)
            .border(Color.appPrimary)
    }
}


struct DayButtonStyle: ButtonStyle {
    
    var color: Color
    var isSelected: Bool
 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 40, height: 40)
            .font(isSelected ? .appCalendarDaySelected : .appCalendarDay)
            .foregroundColor(color)
            .background(self.isSelected ? Color.appPrimary : nil)
            .cornerRadius(20)
            
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


struct WelcomeActionButtonStyle: ButtonStyle {
 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 176, height: 44)
            .foregroundColor(.appPrimary)
            .background(Color.white)
            
    }
}

