//
//  DayButton.swift
//  TDEE Calculator
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
    
    var button: some View {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        
        let stringDate = dateFormatter.string(from: self.day)
        
        let color = self.isSelectedDay
            ? Color.white
            : ( self.isSelectedMonth ? Color.appPrimaryText : Color.appPrimaryTextLight )
        
        let button = Button(
            action: { self.selectDayFunc(self.day) },
            label: { Text(stringDate).padding(.top, -1) }
        )
            .buttonStyle(DayButtonStyle(color: color, isSelected: isSelectedDay))
        
        return button
    }
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
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
            
            self.button
        }
            .frame(width: 40, height: 40, alignment: .top)
        
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
