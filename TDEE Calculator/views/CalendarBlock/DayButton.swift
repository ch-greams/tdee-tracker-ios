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
    
    @EnvironmentObject var appState: AppState
    
    var day: Date

    let isSelectedDay: Bool
    let isSelectedMonth: Bool
    
    func getButton() -> some View {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        
        let stringDate = dateFormatter.string(from: self.day)
        
        let color = self.isSelectedDay
            ? Color.white
            : ( self.isSelectedMonth ? Color.appPrimaryText : Color.appPrimaryTextLight )

        
        let button = Button(stringDate) {

            self.appState.changeDay(to: self.day)
        }
        .buttonStyle(DayButtonStyle(color: color, isSelected: isSelectedDay))
        
        return button
    }
    
    var body: some View {
        getButton()
    }
}

struct DayButton_Previews: PreviewProvider {
    
    static let day = Date()
    
    static var previews: some View {
        
        HStack {
            
            // Selected Day
            DayButton(day: Self.day, isSelectedDay: true, isSelectedMonth: true)
            
            // Not selected Day, current month
            DayButton(day: Self.day, isSelectedDay: false, isSelectedMonth: true)
            
            // Not selected Day, other month
            DayButton(day: Self.day, isSelectedDay: false, isSelectedMonth: false)
        }
    }
}
