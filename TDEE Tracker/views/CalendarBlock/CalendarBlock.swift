//
//  Calendar.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/2/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI



struct CalendarBlock: View {
    
    @EnvironmentObject var appState: AppState
    
    let selectedDay: Date
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
                    .foregroundColor(Color.appPrimaryText)
            }
        }
    }
    
    var body: some View {
    
        VStack(alignment: .center, spacing: 8) {
            
            CalendarBlockMonth(selectedDay: self.selectedDay)
            
            VStack(alignment: .center, spacing: 0) {

                self.weekdayTitles
                
                CalendarBlockDays(selectedDay: self.selectedDay, isTrendsPage: self.isTrendsPage)
            }
                .padding(.vertical)
                .background(Color.appWhite)
                .padding(.horizontal, 8)
                .clipped()
                .shadow(color: .gray, radius: 1, x: 1, y: 1)
        }

    }
}

struct CalendarBlock_EntryPage_Previews: PreviewProvider {
    
    static let appState = AppState()

    static var previews: some View {
        
        CalendarBlock(selectedDay: Date(), isTrendsPage: false)
            .padding(.vertical, 8)
            .background(Color.appPrimary)
            .environmentObject(appState)

    }
}

struct CalendarBlock_TrendsPage_Previews: PreviewProvider {
    
    static let appState = AppState()
    
    static var previews: some View {
        
        CalendarBlock(selectedDay: Date(), isTrendsPage: true)
            .padding(.vertical, 8)
            .background(Color.appPrimary)
            .environmentObject(appState)

    }
}

