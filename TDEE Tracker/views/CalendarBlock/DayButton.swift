//
//  DayButton.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/2/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI



struct DayButton: View {
    
    let day: Date
    
    let selectDayFunc: (Date) -> ()
    
    let isToday: Bool
    let isSelectedDay: Bool
    let isSelectedMonth: Bool
    
    let hasData: DayEntryData
    
    let defaultFont: Font
    let selectedFont: Font

    let buttonSize: CGFloat
    
    let selectedTextColor: Color
    let defaultTextColor: Color
    let alternativeTextColor: Color
    
    let accentColor: Color
    let accentAlternativeColor: Color
    

    var color: Color {

        if self.isSelectedDay {
            
            return self.selectedTextColor
        }
        else if self.isSelectedMonth {
            
            return self.defaultTextColor
        }
        else {
            
            return self.alternativeTextColor
        }
    }
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            if self.hasData == DayEntryData.Full {

                Circle()
                    .size(CGSize(width: 4, height: 4))
                    .foregroundColor(self.accentColor)
            }
            else if self.hasData == DayEntryData.Partial {
                
                Circle()
                    .size(CGSize(width: 4, height: 4))
                    .foregroundColor(self.accentAlternativeColor)
            }
            
            Button(self.day.dayString, action: { self.selectDayFunc(self.day) })
                .buttonStyle(CalendarDayButtonStyle(
                    buttonSize: self.buttonSize,
                    font: ( self.isSelectedDay || self.isToday ) ? self.selectedFont : self.defaultFont,
                    textColor: self.color,
                    backgroundColor: self.isSelectedDay ? self.accentColor : nil
                ))
        }
            .frame(width: self.buttonSize, height: self.buttonSize, alignment: .top)
        
    }
}

struct DayButton_Previews: PreviewProvider {
    
    static let day = Date()
    
    static let defaultFont: Font = Font.appCalendarDayMedium
    static let selectedFont: Font = Font.appCalendarDaySelectedMedium
    
    static let selectedColor: Color = UIThemeManager.DEFAULT.mainTextColor
    static let defaultColor: Color = UIThemeManager.DEFAULT.calendarTextDefaultColor
    static let alternativeColor: Color = UIThemeManager.DEFAULT.calendarTextAltColor
    
    static let accentColor: Color = UIThemeManager.DEFAULT.calendarAccentColor
    static let accentAlternativeColor: Color = UIThemeManager.DEFAULT.calendarAccentAlternativeColor
    
    static var previews: some View {
        
        VStack {
            
            HStack {
                
                // Selected Day
                DayButton(
                    day: Self.day,
                    selectDayFunc: { print($0) },
                    isToday: false,
                    isSelectedDay: true,
                    isSelectedMonth: true,
                    hasData: DayEntryData.Full,
                    defaultFont: defaultFont,
                    selectedFont: selectedFont,
                    buttonSize: 40,
                    selectedTextColor: Self.selectedColor,
                    defaultTextColor: Self.defaultColor,
                    alternativeTextColor: Self.alternativeColor,
                    accentColor: Self.accentColor,
                    accentAlternativeColor: Self.accentAlternativeColor
                )
                
                // Not selected Day, current month
                DayButton(
                    day: Self.day,
                    selectDayFunc: { print($0) },
                    isToday: false,
                    isSelectedDay: false,
                    isSelectedMonth: true,
                    hasData: DayEntryData.Full,
                    defaultFont: defaultFont,
                    selectedFont: selectedFont,
                    buttonSize: 40,
                    selectedTextColor: Self.selectedColor,
                    defaultTextColor: Self.defaultColor,
                    alternativeTextColor: Self.alternativeColor,
                    accentColor: Self.accentColor,
                    accentAlternativeColor: Self.accentAlternativeColor
                )
                
                // Not selected Day, other month
                DayButton(
                    day: Self.day,
                    selectDayFunc: { print($0) },
                    isToday: false,
                    isSelectedDay: false,
                    isSelectedMonth: false,
                    hasData: DayEntryData.Full,
                    defaultFont: defaultFont,
                    selectedFont: selectedFont,
                    buttonSize: 40,
                    selectedTextColor: Self.selectedColor,
                    defaultTextColor: Self.defaultColor,
                    alternativeTextColor: Self.alternativeColor,
                    accentColor: Self.accentColor,
                    accentAlternativeColor: Self.accentAlternativeColor
                )
            }
            
            HStack {
                
                // Selected Day
                DayButton(
                    day: Self.day,
                    selectDayFunc: { print($0) },
                    isToday: false,
                    isSelectedDay: true,
                    isSelectedMonth: true,
                    hasData: DayEntryData.Partial,
                    defaultFont: defaultFont,
                    selectedFont: selectedFont,
                    buttonSize: 40,
                    selectedTextColor: Self.selectedColor,
                    defaultTextColor: Self.defaultColor,
                    alternativeTextColor: Self.alternativeColor,
                    accentColor: Self.accentColor,
                    accentAlternativeColor: Self.accentAlternativeColor
                )
                
                // Not selected Day, current month
                DayButton(
                    day: Self.day,
                    selectDayFunc: { print($0) },
                    isToday: false,
                    isSelectedDay: false,
                    isSelectedMonth: true,
                    hasData: DayEntryData.Partial,
                    defaultFont: defaultFont,
                    selectedFont: selectedFont,
                    buttonSize: 40,
                    selectedTextColor: Self.selectedColor,
                    defaultTextColor: Self.defaultColor,
                    alternativeTextColor: Self.alternativeColor,
                    accentColor: Self.accentColor,
                    accentAlternativeColor: Self.accentAlternativeColor
                )
                
                // Not selected Day, other month
                DayButton(
                    day: Self.day,
                    selectDayFunc: { print($0) },
                    isToday: false,
                    isSelectedDay: false,
                    isSelectedMonth: false,
                    hasData: DayEntryData.Partial,
                    defaultFont: defaultFont,
                    selectedFont: selectedFont,
                    buttonSize: 40,
                    selectedTextColor: Self.selectedColor,
                    defaultTextColor: Self.defaultColor,
                    alternativeTextColor: Self.alternativeColor,
                    accentColor: Self.accentColor,
                    accentAlternativeColor: Self.accentAlternativeColor
                )
            }
            
            HStack {
                
                // Selected Day
                DayButton(
                    day: Self.day,
                    selectDayFunc: { print($0) },
                    isToday: false,
                    isSelectedDay: true,
                    isSelectedMonth: true,
                    hasData: DayEntryData.Empty,
                    defaultFont: defaultFont,
                    selectedFont: selectedFont,
                    buttonSize: 40,
                    selectedTextColor: Self.selectedColor,
                    defaultTextColor: Self.defaultColor,
                    alternativeTextColor: Self.alternativeColor,
                    accentColor: Self.accentColor,
                    accentAlternativeColor: Self.accentAlternativeColor
                )
                
                // Not selected Day, current month
                DayButton(
                    day: Self.day,
                    selectDayFunc: { print($0) },
                    isToday: false,
                    isSelectedDay: false,
                    isSelectedMonth: true,
                    hasData: DayEntryData.Empty,
                    defaultFont: defaultFont,
                    selectedFont: selectedFont,
                    buttonSize: 40,
                    selectedTextColor: Self.selectedColor,
                    defaultTextColor: Self.defaultColor,
                    alternativeTextColor: Self.alternativeColor,
                    accentColor: Self.accentColor,
                    accentAlternativeColor: Self.accentAlternativeColor
                )
                
                // Not selected Day, other month
                DayButton(
                    day: Self.day,
                    selectDayFunc: { print($0) },
                    isToday: false,
                    isSelectedDay: false,
                    isSelectedMonth: false,
                    hasData: DayEntryData.Empty,
                    defaultFont: defaultFont,
                    selectedFont: selectedFont,
                    buttonSize: 40,
                    selectedTextColor: Self.selectedColor,
                    defaultTextColor: Self.defaultColor,
                    alternativeTextColor: Self.alternativeColor,
                    accentColor: Self.accentColor,
                    accentAlternativeColor: Self.accentAlternativeColor
                )
            }
            
            HStack {
                
                // Selected Day
                DayButton(
                    day: Self.day,
                    selectDayFunc: { print($0) },
                    isToday: true,
                    isSelectedDay: true,
                    isSelectedMonth: true,
                    hasData: DayEntryData.Empty,
                    defaultFont: defaultFont,
                    selectedFont: selectedFont,
                    buttonSize: 40,
                    selectedTextColor: Self.selectedColor,
                    defaultTextColor: Self.defaultColor,
                    alternativeTextColor: Self.alternativeColor,
                    accentColor: Self.accentColor,
                    accentAlternativeColor: Self.accentAlternativeColor
                )
                
                // Not selected Day, current month
                DayButton(
                    day: Self.day,
                    selectDayFunc: { print($0) },
                    isToday: true,
                    isSelectedDay: false,
                    isSelectedMonth: true,
                    hasData: DayEntryData.Empty,
                    defaultFont: defaultFont,
                    selectedFont: selectedFont,
                    buttonSize: 40,
                    selectedTextColor: Self.selectedColor,
                    defaultTextColor: Self.defaultColor,
                    alternativeTextColor: Self.alternativeColor,
                    accentColor: Self.accentColor,
                    accentAlternativeColor: Self.accentAlternativeColor
                )
                
                // Not selected Day, other month
                DayButton(
                    day: Self.day,
                    selectDayFunc: { print($0) },
                    isToday: true,
                    isSelectedDay: false,
                    isSelectedMonth: false,
                    hasData: DayEntryData.Empty,
                    defaultFont: defaultFont,
                    selectedFont: selectedFont,
                    buttonSize: 40,
                    selectedTextColor: Self.selectedColor,
                    defaultTextColor: Self.defaultColor,
                    alternativeTextColor: Self.alternativeColor,
                    accentColor: Self.accentColor,
                    accentAlternativeColor: Self.accentAlternativeColor
                )
            }
        }
    }
}
