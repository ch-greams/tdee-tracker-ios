//
//  Calendar.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/2/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI

struct CalendarBlock: View {
    
    let calendar = Calendar.current
    
    @State private var selectedDay: Date = Date()
    @State private var selectedMonth: DateComponents = Calendar.current.dateComponents([.year, .month], from: Date())
    
    let days = [ "MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN" ]
    
    func getDay(day: Date) -> some View {
        
        return DayButton(
            day: day,
            isActiveMonth: self.calendar.dateComponents([.year, .month], from: day) == self.selectedMonth,
            selectedDay: self.$selectedDay
        )
    }
    
    func getWeekdays(
        weeks: Array<Array<Date>>, iWeek: Int
    ) -> some View {
        
        return HStack {
            ForEach(0 ..< weeks[iWeek].count) { iDay in
                
                self.getDay(day: weeks[iWeek][iDay])
            }
        }
        .padding(.vertical, 6)
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
        
        return VStack {
            ForEach(0 ..< weeks.count) { iWeek in
                
                self.getWeekdays(weeks: weeks, iWeek: iWeek)
            }
        }
    }
    
    var body: some View {
        
        VStack {
            HStack {
                ForEach(self.days, id: \.self) { day in
                    Text("\(day)")
                        .font(.appCalendarWeekday)
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color.appPrimaryText)
                }
            }

            self.getDaysInCurrentMonth()

        }
        .frame(width: 358, height: 320)
        .background(Color(.white))
        .padding(8)
        .clipped()
        .shadow(color: .gray, radius: 1, x: 1, y: 1)
        
    }
}

struct CalendarBlock_Previews: PreviewProvider {
    static var previews: some View {
        CalendarBlock()
    }
}
