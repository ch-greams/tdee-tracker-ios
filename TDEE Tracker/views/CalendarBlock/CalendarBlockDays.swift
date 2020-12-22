//
//  CalendarBlockDays.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/4/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct CalendarBlockDaysSizes {
    
    // MARK: - Sizes
    
    public let selectedEntryWeekHighlightHeight: CGFloat
    public let selectedTrendWeekHighlightHeight: CGFloat
    
    public let weekVPadding: CGFloat
    
    public let calendarDayButtonHSpacing: CGFloat

    // MARK: - Init
    
    init(hasNotch: Bool, scale: CGFloat) {
        
        self.selectedEntryWeekHighlightHeight = scale * 30
        self.selectedTrendWeekHighlightHeight = scale * 10
    
        self.weekVPadding = scale * 1
    
        self.calendarDayButtonHSpacing = scale * 10
    }
}



struct CalendarBlockDays: View {
    
    private let calendar = Calendar.current

    private let sizes = CalendarBlockDaysSizes(hasNotch: UISizes.hasNotch, scale: UISizes.scale)

    @EnvironmentObject var appState: AppState
    
    let selectedDay: Date
    let isCollapsed: Bool
    let isTrendsPage: Bool
    
    func getDay(day: Date, isSelectedWeek: Bool) -> some View {
        
        let isToday = calendar
            .isDate(day, equalTo: Date.today, toGranularity: .day)
        
        let isSelectedDay = calendar
            .isDate(day, equalTo: self.selectedDay, toGranularity: .day)
        
        let isSelectedMonth = calendar
            .isDate(day, equalTo: self.selectedDay, toGranularity: .month)
        
        return DayButton(
            day: day,
            selectDayFunc: self.appState.changeDay,
            isToday: isToday,
            isSelectedDay: isSelectedDay || ( self.isTrendsPage && isSelectedWeek ),
            isSelectedMonth: isSelectedMonth,
            hasData: self.appState.isDayHasData(date: day),
            
            selectedTextColor: self.appState.uiTheme.mainTextColor,
            defaultTextColor: self.appState.uiTheme.calendarTextDefaultColor,
            alternativeTextColor: self.appState.uiTheme.calendarTextAltColor,
            accentColor: self.appState.uiTheme.calendarAccentColor,
            accentAlternativeColor: self.appState.uiTheme.calendarAccentAlternativeColor
        )
    }
    
    func getWeekdays(from week: [ Date ]) -> some View {
        
        let checkIfDayIsSelected = {
            self.calendar.isDate($0, equalTo: self.selectedDay, toGranularity: .day)
        }
        
        let isSelectedWeek = week.contains(where: checkIfDayIsSelected)
        
        return ZStack {
            
            if isSelectedWeek {

                if self.isTrendsPage {

                    self.appState.uiTheme.calendarAccentColor
                        .frame(height: self.sizes.selectedTrendWeekHighlightHeight)
                }
                else {
                    
                    self.appState.uiTheme.calendarWeekHighlight
                        .frame(height: self.sizes.selectedEntryWeekHighlightHeight)
                }
            }

            HStack(alignment: .center, spacing: self.sizes.calendarDayButtonHSpacing) {
                ForEach(0 ..< week.count) { iDay in
                    
                    self.getDay(day: week[iDay], isSelectedWeek: isSelectedWeek)
                }
            }
                .padding(.vertical, self.sizes.weekVPadding)

        }
    }

    var weeks: Array<Array<Date>> {
        
        var weeks: Array<Array<Date>> = []
        
        let monthScope = self.calendar.dateComponents([.year, .month], from: selectedDay)
        
        guard let fd = calendar.date(from: monthScope), let firstDay = fd.startOfWeek else {
            return weeks
        }
        
        for weekIndex in 0 ..< 6 {
            
            if let dayInTheWeek = firstDay.addDays(weekIndex * 7) {

                let days = ( 0 ..< 7 ).compactMap { dayInTheWeek.addDays($0) }
                
                weeks.append(days)
            }
        }

        return weeks
    }
    
    var body: some View {
        
        let weeks = (
            self.isCollapsed
                ? self.weeks.filter { $0.contains(self.selectedDay) }
                : self.weeks
        )

        return VStack(alignment: .center, spacing: 0) {
            ForEach(weeks, id: \.self) {
                self.getWeekdays(from: $0)
            }
        }
    }
}

struct CalendarBlockDays_EntryPage_Previews: PreviewProvider {
    
    static let appState = AppState()
    
    static var previews: some View {
            
        CalendarBlockDays(selectedDay: Date.today, isCollapsed: false, isTrendsPage: false)
            .background(self.appState.uiTheme.inputBackgroundColor)
            .environmentObject(appState)
    }
}

struct CalendarBlockDays_EntryPage_Collapsed_Previews: PreviewProvider {
    
    static let appState = AppState()
    
    static var previews: some View {
            
        CalendarBlockDays(selectedDay: Date.today, isCollapsed: true, isTrendsPage: false)
            .background(self.appState.uiTheme.inputBackgroundColor)
            .environmentObject(appState)
    }
}

struct CalendarBlockDays_TrendsPage_Previews: PreviewProvider {
    
    static let appState = AppState()

    static var previews: some View {
            
        CalendarBlockDays(selectedDay: Date.today, isCollapsed: false, isTrendsPage: true)
            .background(self.appState.uiTheme.inputBackgroundColor)
            .environmentObject(appState)
    }
}

