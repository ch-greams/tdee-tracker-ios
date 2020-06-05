//
//  CalendarBlockDays.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/4/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI

struct CalendarBlockDays: View {
    
    let calendar = Calendar.current
    
    let selectedMonth: DateComponents
    
    @Binding var selectedDay: Date
    
    func getDay(day: Date) -> some View {
        
        return DayButton(
            day: day,
            isActiveMonth: self.calendar.dateComponents([.year, .month], from: day) == self.selectedMonth,
            selectedDay: self.$selectedDay
        )
    }
    
    func getWeekdays(weeks: Array<Array<Date>>, iWeek: Int) -> some View {
        
        let checkIfDayIsSelected = {
            Calendar.current.isDate($0, equalTo: self.selectedDay, toGranularity: .day)
        }
        
        let week = weeks[iWeek]
        
        return ZStack {
            
            if week.contains(where: checkIfDayIsSelected) {

                Color.appPrimaryWeekBackground
                    .frame(height: 30.0)
            }

            HStack {
                ForEach(0 ..< week.count) { iDay in
                    
                    self.getDay(day: week[iDay])
                }
            }
            .padding(.vertical, 1.0)
            

        }
    }

    func getWeeks() -> Array<Array<Date>> {
        
        var weeks: Array<Array<Date>> = []
        
        let firstDayOfTheMonth = calendar.date(from: self.selectedMonth)!
        let dayOfWeek = calendar.component(.weekday, from: firstDayOfTheMonth)
        
        
        for weekIndex in 0 ..< 6 {
            
            let dayInTheWeek = calendar.date(byAdding: .day, value: weekIndex * 7, to: firstDayOfTheMonth)!
            let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: dayInTheWeek)!
            
            let days = (weekdays.lowerBound ..< weekdays.upperBound)
                .compactMap {
                    calendar.date(byAdding: .day, value: $0 - dayOfWeek, to: dayInTheWeek)
                }
            
            weeks.append(days)
        }
        
        return weeks
        
    }

    func getDaysInCurrentMonth() -> some View {
        
        let weeks = getWeeks()
        
        return VStack(alignment: .center, spacing: 0) {
            ForEach(0 ..< weeks.count) { iWeek in
                
                self.getWeekdays(weeks: weeks, iWeek: iWeek)
            }
        }
    }
    
    
    var body: some View {
        self.getDaysInCurrentMonth()
    }
}

struct CalendarBlockDays_Previews: PreviewProvider {
    
    static let selectedMonth: DateComponents = Calendar.current.dateComponents([.year, .month], from: Date())
    
    static var previews: some View {
        CalendarBlockDays(selectedMonth: Self.selectedMonth, selectedDay: .constant(Date()))
    }
}
