//
//  Calendar.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/2/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI



struct CalendarBlock: View {
    
    let selectedDay: Date
    let isTrendsPage: Bool


    func getWeekdayTitles() -> some View {
        
        let dateFormatter = DateFormatter()
        
        let weekdays = dateFormatter.shortWeekdaySymbols.compactMap { $0.uppercased() }
        
        // Try this fix if weekdays order won't change with locale change
        // let weekdaysSorted = Array(weekdays[ firstWeekday - 1 ..< weekdays.count ]) + weekdays[ 0 ..< firstWeekday - 1]
        
        return HStack(alignment: .center) {
            ForEach(weekdays, id: \.self) { day in
                Text(day)
                    .font(.appCalendarWeekday)
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color.appPrimaryText)
            }
        }
    }
    
    var body: some View {
    
        VStack(alignment: .center, spacing: 0) {
            
            CalendarBlockMonth(selectedDay: self.selectedDay)
            
            VStack(alignment: .center, spacing: 0) {

                self.getWeekdayTitles()
                
                CalendarBlockDays(selectedDay: self.selectedDay, isTrendsPage: self.isTrendsPage)

            }
            .frame(width: 358, height: 320)
            .background(Color(.white))
            .padding(8)
            .clipped()
            .shadow(color: .gray, radius: 1, x: 1, y: 1)
        }

    }
}

struct CalendarBlock_EntryPage_Previews: PreviewProvider {
    
    static let appState = AppState()

    static var previews: some View {
        
        CalendarBlock(selectedDay: Date(), isTrendsPage: false)
            .padding(.top, 8)
            .background(Color.appPrimary)
            .environmentObject(appState)

    }
}

struct CalendarBlock_TrendsPage_Previews: PreviewProvider {
    
    static let appState = AppState()
    
    static var previews: some View {
        
        CalendarBlock(selectedDay: Date(), isTrendsPage: true)
            .padding(.top, 8)
            .background(Color.appPrimary)
            .environmentObject(appState)

    }
}

