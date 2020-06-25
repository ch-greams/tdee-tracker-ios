//
//  CalendarBlockMonth.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/5/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct CustomButtonBackgroundStyle: ButtonStyle {
 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 44.0, height: 10.0)
            .padding()
            .foregroundColor(.appPrimary)
            .background(Color(hue: 0, saturation: 0, brightness: 0.96))
            .padding(.horizontal, 8)
            .clipped()
            .shadow(color: .gray, radius: 1, x: 1, y: 1)
            
    }
}


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
            .foregroundColor(.white)
    }
    
    func changeMonth(delta: Int) -> Void {
        
        let nextMonth = calendar.date(byAdding: .month, value: delta, to: selectedDay)!
        
        let nextMonthScope = calendar.dateComponents([.year, .month], from: nextMonth)
        
        appState.changeDay(to: calendar.date(from: nextMonthScope)!)
    }
    
    func getMonthChangeButton(icon: String, delta: Int) -> some View {

        Button(action: { self.changeMonth(delta: delta) }) {
            Image(systemName: icon)
                .font(.headline)
        }
            .buttonStyle(CustomButtonBackgroundStyle())
    }
    
    var body: some View {

        HStack(alignment: .center) {

            self.getMonthChangeButton(icon: "arrow.left", delta: -1)
            
            self.monthTitle.frame(width: 174.0)
            
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
