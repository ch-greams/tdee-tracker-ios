//
//  Calendar.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/2/20.
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


struct CalendarBlock: View {

    @Binding var selectedDay: Date
    
    @State private var selectedMonth: DateComponents = Calendar.current.dateComponents([.year, .month], from: Date())

    
    func getMonthTitle() -> Text {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM YYYY"
        
        let date = Calendar.current.date(from: self.selectedMonth)!
        let monthString = dateFormatter.string(from: date)
        
        return Text(monthString.uppercased())
            .font(.appCalendarMonth)
            .foregroundColor(.white)
    }
    
    func changeMonth(delta: Int) -> Void {
        
        let date = Calendar.current.date(from: self.selectedMonth)!
        let nextMonthDate = Calendar.current.date(byAdding: .month, value: delta, to: date)!
        
        self.selectedMonth = Calendar.current.dateComponents([.year, .month], from: nextMonthDate)
    }
    
    func getButton(type: String, isRight: Bool) -> some View {

        Button(action: { self.changeMonth(delta: isRight ? 1 : -1) }) {
            Image(systemName: "arrow.\(type)")
                .font(.headline)
        }
        .buttonStyle(CustomButtonBackgroundStyle())
    }
    
    func getCalendarTitleBlock() -> some View {
        
        return HStack(alignment: .center) {

            self.getButton(type: "left", isRight: false)
            
            self.getMonthTitle()
                .frame(width: 174.0)
            
            self.getButton(type: "right", isRight: true)
        }
    }
    
    func getWeekdayTitles() -> some View {
        
        let dateFormatter = DateFormatter()
        
        let weekdays = dateFormatter.shortWeekdaySymbols.compactMap { $0.uppercased() }
        
        // Try this fix if weekdays order won't change with locale change
        // let weekdaysSorted = Array(weekdays[ firstWeekday - 1 ..< weekdays.count ]) + weekdays[ 0 ..< firstWeekday - 1]
        
        return HStack(alignment: .center) {
            ForEach(weekdays, id: \.self) { day in
                Text("\(day)")
                    .font(.appCalendarWeekday)
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color.appPrimaryText)
            }
        }
    }
    
    var body: some View {
    
        VStack(alignment: .center, spacing: 0) {
            
            self.getCalendarTitleBlock()
            
            VStack {

                self.getWeekdayTitles()
                
                CalendarBlockDays(
                    selectedMonth: self.selectedMonth,
                    selectedDay: self.$selectedDay
                )

            }
            .frame(width: 358, height: 320)
            .background(Color(.white))
            .padding(8)
            .clipped()
            .shadow(color: .gray, radius: 1, x: 1, y: 1)
        }

    }
}

struct CalendarBlock_Previews: PreviewProvider {
    
    static var previews: some View {
        CalendarBlock(selectedDay: .constant(Date()))
            .padding(.top, 8)
            .background(Color.appPrimary)
    }
}
