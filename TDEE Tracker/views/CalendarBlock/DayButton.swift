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
    
    let selectedColor: Color
    let defaultColor: Color
    let alternativeColor: Color
    

    var button: some View {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        
        let stringDate = dateFormatter.string(from: self.day)
        
        let color = self.isSelectedDay
            ? self.selectedColor
            : ( self.isSelectedMonth ? self.defaultColor : self.alternativeColor )
        
        let button = Button(stringDate, action: { self.selectDayFunc(self.day) })
            .buttonStyle(DayButtonStyle(
                buttonSize: self.buttonSize,
                fontSize: self.fontSize,
                color: color,
                isSelected: isSelectedDay
            ))
        
        return button
    }
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            if self.hasData == DayEntryData.Full {

                Circle()
                    .size(CGSize(width: 4, height: 4))
                    .foregroundColor(.appPrimary)
            }
            else if self.hasData == DayEntryData.Partial {
                
                Circle()
                    .size(CGSize(width: 4, height: 4))
                    .foregroundColor(.appSecondary)
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
                    selectedColor: Self.selectedColor,
                    defaultColor: Self.defaultColor,
                    alternativeColor: Self.alternativeColor
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
                    selectedColor: Self.selectedColor,
                    defaultColor: Self.defaultColor,
                    alternativeColor: Self.alternativeColor
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
                    selectedColor: Self.selectedColor,
                    defaultColor: Self.defaultColor,
                    alternativeColor: Self.alternativeColor
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
                    selectedColor: Self.selectedColor,
                    defaultColor: Self.defaultColor,
                    alternativeColor: Self.alternativeColor
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
                    selectedColor: Self.selectedColor,
                    defaultColor: Self.defaultColor,
                    alternativeColor: Self.alternativeColor
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
                    selectedColor: Self.selectedColor,
                    defaultColor: Self.defaultColor,
                    alternativeColor: Self.alternativeColor
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
                    selectedColor: Self.selectedColor,
                    defaultColor: Self.defaultColor,
                    alternativeColor: Self.alternativeColor
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
                    selectedColor: Self.selectedColor,
                    defaultColor: Self.defaultColor,
                    alternativeColor: Self.alternativeColor
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
                    selectedColor: Self.selectedColor,
                    defaultColor: Self.defaultColor,
                    alternativeColor: Self.alternativeColor
                )
            }
        }
    }
}
