//
//  CalendarBlockDays.swift
//  TDEE Tracker
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
            hasData: self.appState.isDayHasData(date: day),
            defaultFont: self.appState.uiSizes.calendarDayFont,
            selectedFont: self.appState.uiSizes.calendarDaySelectedFont,
            buttonSize: self.appState.uiSizes.calendarDayButton,
            selectedTextColor: self.appState.uiTheme.mainTextColor,
            defaultTextColor: self.appState.uiTheme.calendarTextDefaultColor,
            alternativeTextColor: self.appState.uiTheme.calendarTextAltColor,
            accentColor: self.appState.uiTheme.calendarAccentColor,
            accentAlternativeColor: self.appState.uiTheme.calendarAccentAlternativeColor
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

                    self.appState.uiTheme.calendarAccentColor.frame(height: 10)
                }
                else {
                    
                    self.appState.uiTheme.calendarWeekHighlight.frame(height: 30)
                }
            }

            HStack(alignment: .center, spacing: self.appState.uiSizes.calendarDaySpacing) {
                ForEach(0 ..< week.count) { iDay in
                    
                    self.getDay(day: week[iDay], isSelectedWeek: isSelectedWeek)
                }
            }
                .padding(.vertical, 1)

        }
    }

    var weeks: Array<Array<Date>> {
        
        var weeks: Array<Array<Date>> = []
        
        let monthScope = self.calendar.dateComponents([.year, .month], from: selectedDay)
        
        guard let fd = calendar.date(from: monthScope), let firstDay = fd.startOfWeek else {
            return weeks
        }
        
        for weekIndex in 0 ..< 6 {
            
            if let dayInTheWeek = calendar.date(byAdding: .day, value: weekIndex * 7, to: firstDay) {

                let days = ( 0 ..< 7 ).compactMap {
                    calendar.date(byAdding: .day, value: $0, to: dayInTheWeek)
                }
                
                weeks.append(days)
            }
        }

        return weeks
    }
    
    var body: some View {
        
        let weeks = self.weeks
        
        return VStack(alignment: .center, spacing: 0) {
            ForEach(0 ..< weeks.count) { iWeek in
                
                self.getWeekdays(weeks: weeks, iWeek: iWeek)
            }
        }
    }
}

struct CalendarBlockDays_EntryPage_Previews: PreviewProvider {
    
    static let appState = AppState()
    
    static var previews: some View {
            
        CalendarBlockDays(selectedDay: Date(), isTrendsPage: false)
            .background(self.appState.uiTheme.inputBackgroundColor)
            .environmentObject(appState)
    }
}

struct CalendarBlockDays_TrendsPage_Previews: PreviewProvider {
    
    static let appState = AppState()

    static var previews: some View {
            
        CalendarBlockDays(selectedDay: Date(), isTrendsPage: true)
            .background(self.appState.uiTheme.inputBackgroundColor)
            .environmentObject(appState)
    }
}

