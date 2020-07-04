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
    
    let isSelectedDay: Bool
    let isSelectedMonth: Bool
    
    let hasData: DayEntryData
    
    let fontSize: CGFloat
    let buttonSize: CGFloat
    
    let selectedTextColor: Color
    let defaultTextColor: Color
    let alternativeTextColor: Color
    
    let accentColor: Color
    let accentAlternativeColor: Color
    

    var button: some View {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        
        let stringDate = dateFormatter.string(from: self.day)
        
        let color = self.isSelectedDay
            ? self.selectedTextColor
            : ( self.isSelectedMonth ? self.defaultTextColor : self.alternativeTextColor )
        
        let button = Button(stringDate, action: { self.selectDayFunc(self.day) })
            .buttonStyle(DayButtonStyle(
                buttonSize: self.buttonSize,
                fontSize: self.fontSize,
                textColor: color,
                backgroundColor: self.accentColor,
                isSelected: isSelectedDay
            ))
        
        return button
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
            
            self.button
        }
            .frame(width: self.buttonSize, height: self.buttonSize, alignment: .top)
        
    }
}

struct DayButton_Previews: PreviewProvider {
    
    static let day = Date()
    
    static let selectedColor: Color = UIConstants.THEME_DEFAULT.mainTextColor
    static let defaultColor: Color = UIConstants.THEME_DEFAULT.calendarTextDefaultColor
    static let alternativeColor: Color = UIConstants.THEME_DEFAULT.calendarTextAltColor
    
    static let accentColor: Color = UIConstants.THEME_DEFAULT.calendarAccentColor
    static let accentAlternativeColor: Color = UIConstants.THEME_DEFAULT.calendarAccentAlternativeColor
    
    static var previews: some View {
        
        VStack {
            
            HStack {
                
                // Selected Day
                DayButton(
                    day: Self.day,
                    selectDayFunc: { print($0) },
                    isSelectedDay: true,
                    isSelectedMonth: true,
                    hasData: DayEntryData.Full,
                    fontSize: 22,
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
                    isSelectedDay: false,
                    isSelectedMonth: true,
                    hasData: DayEntryData.Full,
                    fontSize: 22,
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
                    isSelectedDay: false,
                    isSelectedMonth: false,
                    hasData: DayEntryData.Full,
                    fontSize: 22,
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
                    isSelectedDay: true,
                    isSelectedMonth: true,
                    hasData: DayEntryData.Partial,
                    fontSize: 22,
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
                    isSelectedDay: false,
                    isSelectedMonth: true,
                    hasData: DayEntryData.Partial,
                    fontSize: 22,
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
                    isSelectedDay: false,
                    isSelectedMonth: false,
                    hasData: DayEntryData.Partial,
                    fontSize: 22,
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
                    isSelectedDay: true,
                    isSelectedMonth: true,
                    hasData: DayEntryData.Empty,
                    fontSize: 22,
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
                    isSelectedDay: false,
                    isSelectedMonth: true,
                    hasData: DayEntryData.Empty,
                    fontSize: 22,
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
                    isSelectedDay: false,
                    isSelectedMonth: false,
                    hasData: DayEntryData.Empty,
                    fontSize: 22,
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
