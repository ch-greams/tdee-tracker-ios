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
    
    var day: Date
    @Binding var selectedDay: Date
    
    func getButton() -> some View {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        
        let stringDate = dateFormatter.string(from: self.day)
        
        let isSelected = Calendar.current.isDate(self.day, equalTo: self.selectedDay, toGranularity: .day)
        
        let isActiveMonth = Calendar.current
            .isDate(day, equalTo: self.selectedDay, toGranularity: .month)
        
        let color = isSelected
            ? Color.white
            : ( isActiveMonth ? Color.appPrimaryText : Color.appPrimaryTextLight )

        
        let button = Button(stringDate) {

            self.selectedDay = self.day
        }
        .buttonStyle(DayButtonStyle(color: color, isSelected: isSelected))
        
        return button
    }
    
    var body: some View {
        getButton()
    }
}

struct DayButton_Previews: PreviewProvider {
    
    static var day = Date(timeIntervalSinceReferenceDate: 0)
    
    static var otherDay = Date(timeIntervalSinceReferenceDate: 1000000)
    
    static var otherMonth = Date(timeIntervalSinceReferenceDate: 10000000)
    
    static var previews: some View {
        
        HStack {
            
            // Selected Day
            DayButton(day: Self.day, selectedDay: .constant(Self.day))
            
            // Not selected Day, current month
            DayButton(day: Self.day, selectedDay: .constant(Self.otherDay))
            
            // Not selected Day, other month
            DayButton(day: Self.day, selectedDay: .constant(Self.otherMonth))
        }
    }
}
