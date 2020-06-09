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
    
    @EnvironmentObject var appState: AppState
    
    let selectedDay: Date
    let isTrendsPage: Bool
    
    func getDay(day: Date, isSelectedWeek: Bool) -> some View {
        
        let isSelectedDay = calendar
            .isDate(day, equalTo: self.selectedDay, toGranularity: .day)
        
        let isSelectedMonth = calendar
            .isDate(day, equalTo: self.selectedDay, toGranularity: .month)
        
        return DayButton(
            day: day,
            selectDayFunc: self.appState.changeDay,
            isSelectedDay: isSelectedDay || ( self.isTrendsPage && isSelectedWeek ),
            isSelectedMonth: isSelectedMonth,
            hasData: self.appState.isDayHasData(date: day)
        )
    }
    
    func getWeekdays(weeks: Array<Array<Date>>, iWeek: Int) -> some View {
        
        let checkIfDayIsSelected = {
            self.calendar.isDate($0, equalTo: self.selectedDay, toGranularity: .day)
        }
        
        let week = weeks[iWeek]
        
        let isSelectedWeek = week.contains(where: checkIfDayIsSelected)
        
        return ZStack {
            
            if isSelectedWeek {

                if self.isTrendsPage {
                    Color.appPrimary.frame(height: 10)
                }
                else {
                    Color.appPrimaryWeekBackground.frame(height: 30)
                }
            }

            HStack {
                ForEach(0 ..< week.count) { iDay in
                    
                    self.getDay(day: week[iDay], isSelectedWeek: isSelectedWeek)
                }
            }
            .padding(.vertical, 1.0)

        }
    }

    func getWeeks() -> Array<Array<Date>> {
        
        var weeks: Array<Array<Date>> = []
        
        let monthScope = self.calendar.dateComponents([.year, .month], from: selectedDay)
        
        let firstDayOfTheMonth = calendar.date(from: monthScope)!
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

struct CalendarBlockDays_EntryPage_Previews: PreviewProvider {
    
    static let appState = AppState()
    
    static var previews: some View {
            
        CalendarBlockDays(selectedDay: Date(), isTrendsPage: false)
            .environmentObject(appState)
    }
}

struct CalendarBlockDays_TrendsPage_Previews: PreviewProvider {
    
    static let appState = AppState()

    static var previews: some View {
            
        CalendarBlockDays(selectedDay: Date(), isTrendsPage: true)
            .environmentObject(appState)
    }
}

