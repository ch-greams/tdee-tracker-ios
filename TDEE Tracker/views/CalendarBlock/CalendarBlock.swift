//
//  Calendar.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/2/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI



struct CalendarBlock: View {
    
    @EnvironmentObject var appState: AppState
    
    let selectedDay: Date
    let isCollapsed: Bool
    let isTrendsPage: Bool


    var weekdayTitles: some View {
        
        let weekdayNames = Utils.getShortWeekdayNames()
        
        return HStack(alignment: .center, spacing: self.appState.uiSizes.calendarDaySpacing) {
            ForEach(weekdayNames, id: \.self) { day in
                Text(day.uppercased())
                    .font(.appCalendarWeekday)
                    .frame(
                        width: self.appState.uiSizes.calendarDayButton,
                        height: self.appState.uiSizes.calendarDayButton
                    )
                    .foregroundColor(self.appState.uiTheme.calendarTextDefaultColor)
            }
        }
    }
    
    var body: some View {
    
        VStack(alignment: .center, spacing: 8) {
            
            CalendarBlockMonth(selectedDay: self.selectedDay, isCollapsed: self.isCollapsed)
            
            VStack(alignment: .center, spacing: 0) {

                self.weekdayTitles
                
                CalendarBlockDays(
                    selectedDay: self.selectedDay,
                    isCollapsed: self.isCollapsed,
                    isTrendsPage: self.isTrendsPage
                )
            }
                .padding(.vertical, self.isCollapsed ? 6 : 16)
                .background(self.appState.uiTheme.inputBackgroundColor)
                .padding(.horizontal, 8)
                .clipped()
                .shadow(color: .SHADOW_COLOR, radius: 1, x: 1, y: 1)
                .disabled(self.isCollapsed)
        }
    }
}

struct CalendarBlock_EntryPage_Previews: PreviewProvider {
    
    static let appState = AppState()

    static var previews: some View {
        
        CalendarBlock(selectedDay: Utils.todayDate, isCollapsed: false, isTrendsPage: false)
            .padding(.vertical, 8)
            .background(Self.appState.uiTheme.backgroundColor)
            .environmentObject(appState)
    }
}

struct CalendarBlock_EntryPage_Collapsed_Previews: PreviewProvider {
    
    static let appState = AppState()

    static var previews: some View {
        
        CalendarBlock(selectedDay: Utils.todayDate, isCollapsed: true, isTrendsPage: false)
            .padding(.vertical, 8)
            .background(Self.appState.uiTheme.backgroundColor)
            .environmentObject(appState)
    }
}


struct CalendarBlock_TrendsPage_Previews: PreviewProvider {
    
    static let appState = AppState()
    
    static var previews: some View {
        
        CalendarBlock(selectedDay: Utils.todayDate, isCollapsed: false, isTrendsPage: true)
            .padding(.vertical, 8)
            .background(Self.appState.uiTheme.backgroundColor)
            .environmentObject(appState)
    }
}

