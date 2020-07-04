//
//  CalendarBlockMonth.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/5/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI



struct CalendarBlockMonth: View {
    
    @EnvironmentObject var appState: AppState
    
    let calendar = Calendar.current
    let selectedDay: Date

    
    var monthTitle: Text {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM YYYY"
        
        let monthString = dateFormatter.string(from: selectedDay)
        
        return Text(monthString.uppercased())
            .font(.appCalendarMonth)
            .foregroundColor(.appWhite)
    }
    
    func changeMonth(delta: Int) -> Void {
        
        if let nextMonth = calendar.date(byAdding: .month, value: delta, to: selectedDay) {
            
            let nextMonthScope = calendar.dateComponents([.year, .month], from: nextMonth)
            
            if let nextDay = calendar.date(from: nextMonthScope) {
                
                appState.changeDay(to: nextDay)
            }
        }
    }
    
    func getMonthChangeButton(icon: String, delta: Int) -> some View {

        Button(action: { self.changeMonth(delta: delta) }) {
            Image(systemName: icon)
                .font(.headline)
        }
            .buttonStyle(ChangeMonthButtonStyle())
    }
    
    var body: some View {

        HStack(alignment: .center) {

            self.getMonthChangeButton(icon: "arrow.left", delta: -1)
            
            Spacer()
            
            self.monthTitle
            
            Spacer()
            
            self.getMonthChangeButton(icon: "arrow.right", delta: 1)
        }
    }
}

struct CalendarBlockMonth_Previews: PreviewProvider {
    
    static var previews: some View {
        CalendarBlockMonth(selectedDay: Date())
            .padding(.vertical, 8)
            .background(Color.appPrimary)
    }
}