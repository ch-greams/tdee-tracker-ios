//
//  DayButton.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/2/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI

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

struct DayButton: View {
    
    let day: Date
    
    let selectDayFunc: (Date) -> ()
    
    let isSelectedDay: Bool
    let isSelectedMonth: Bool
    
    let hasData: DayEntryData
    
    func getButton() -> some View {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        
        let stringDate = dateFormatter.string(from: self.day)
        
        let color = self.isSelectedDay
            ? Color.white
            : ( self.isSelectedMonth ? Color.appPrimaryText : Color.appPrimaryTextLight )

        
        let button = Button(stringDate) {

            self.selectDayFunc(self.day)
        }
        .buttonStyle(DayButtonStyle(color: color, isSelected: isSelectedDay))
        
        return button
    }
    
    var body: some View {
        
        ZStack {
            
            if self.hasData == DayEntryData.Full {

                Circle()
                    .size(CGSize(width: 4, height: 4))
                    .foregroundColor(.appPrimary)
                    .padding(0)
            }
            else if self.hasData == DayEntryData.Partial {
                
                Circle()
                    .size(CGSize(width: 4, height: 4))
                    .foregroundColor(.appSecondary)
                    .padding(0)
            }
            
            getButton()
        }
        .frame(width: 40, height: 40)
        
    }
}

struct DayButton_Previews: PreviewProvider {
    
    static let day = Date()
    
    static var previews: some View {
        
        VStack {
            
            HStack {
                
                // Selected Day
                DayButton(day: Self.day, selectDayFunc: { print($0) }, isSelectedDay: true, isSelectedMonth: true, hasData: DayEntryData.Full)
                
                // Not selected Day, current month
                DayButton(day: Self.day, selectDayFunc: { print($0) }, isSelectedDay: false, isSelectedMonth: true, hasData: DayEntryData.Full)
                
                // Not selected Day, other month
                DayButton(day: Self.day, selectDayFunc: { print($0) }, isSelectedDay: false, isSelectedMonth: false, hasData: DayEntryData.Full)
            }
            
            HStack {
                
                // Selected Day
                DayButton(day: Self.day, selectDayFunc: { print($0) }, isSelectedDay: true, isSelectedMonth: true, hasData: DayEntryData.Partial)
                
                // Not selected Day, current month
                DayButton(day: Self.day, selectDayFunc: { print($0) }, isSelectedDay: false, isSelectedMonth: true, hasData: DayEntryData.Partial)
                
                // Not selected Day, other month
                DayButton(day: Self.day, selectDayFunc: { print($0) }, isSelectedDay: false, isSelectedMonth: false, hasData: DayEntryData.Partial)
            }
            
            HStack {
                
                // Selected Day
                DayButton(day: Self.day, selectDayFunc: { print($0) }, isSelectedDay: true, isSelectedMonth: true, hasData: DayEntryData.Empty)
                
                // Not selected Day, current month
                DayButton(day: Self.day, selectDayFunc: { print($0) }, isSelectedDay: false, isSelectedMonth: true, hasData: DayEntryData.Empty)
                
                // Not selected Day, other month
                DayButton(day: Self.day, selectDayFunc: { print($0) }, isSelectedDay: false, isSelectedMonth: false, hasData: DayEntryData.Empty)
            }
        }
    }
}
