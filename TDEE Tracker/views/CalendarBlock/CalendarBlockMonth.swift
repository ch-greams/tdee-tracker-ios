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
            .foregroundColor(self.appState.uiTheme.mainTextColor)
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

            CustomImage(name: icon, colorName: Color.appPrimaryName)
                .frame(width: 44, height: 28)
        }
            .buttonStyle(ChangeMonthButtonStyle(
                backgroundColor: self.appState.uiTheme.inputBackgroundColor
            ))
        
    }
    
    var body: some View {

        HStack(alignment: .center) {

            self.getMonthChangeButton(icon: "arrow-back-sharp", delta: -1)
            
            Spacer()
            
            self.monthTitle
            
            Spacer()
            
            self.getMonthChangeButton(icon: "arrow-forward-sharp", delta: 1)
        }
    }
}

struct CalendarBlockMonth_Previews: PreviewProvider {
    
    static let appState = AppState()
    
    static var previews: some View {
        CalendarBlockMonth(selectedDay: Date())
            .padding(.vertical, 8)
            .background(Color.appPrimary)
            .environmentObject(Self.appState)
    }
}
