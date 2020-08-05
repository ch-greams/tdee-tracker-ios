//
//  CalendarBlockMonth.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/5/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct CalendarBlockMonthStyle {
    
    // MARK: - Sizes
    
    public let monthChangeButtonIconWidth: CGFloat = 44
    public let monthChangeButtonIconHeight: CGFloat = 28
    
    // MARK: - Fonts

    public let monthLabel: Font = .custom(FontOswald.Medium, size: 24) // SE = 20
}


struct CalendarBlockMonth: View {
    
    private let style: CalendarBlockMonthStyle = CalendarBlockMonthStyle()
    
    @EnvironmentObject var appState: AppState
    
    let calendar = Calendar.current

    let selectedDay: Date
    let isCollapsed: Bool
    
    var monthTitle: Text {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL YYYY"
        
        let monthString = dateFormatter.string(from: selectedDay)
        
        return Text(monthString.uppercased())
            .font(self.style.monthLabel)
            .foregroundColor(self.appState.uiTheme.mainTextColor)
    }
    
    func changeMonth(delta: Int) -> Void {
        
        if let nextMonth = calendar.date(byAdding: .month, value: delta, to: selectedDay) {
            
            let nextMonthScope = calendar.dateComponents([.year, .month], from: nextMonth)
            
            if let nextDay = calendar.date(from: nextMonthScope) {
                
                appState.changeDay(to: nextDay)
            }
        }
    }
    
    func getMonthChangeButton(icon: String, delta: Int) -> some View {

        Button(action: { self.changeMonth(delta: delta) }) {

            CustomImage(name: icon, colorName: self.appState.uiTheme.calendarAccentColorName)
                .frame(
                    width: self.style.monthChangeButtonIconWidth,
                    height: self.style.monthChangeButtonIconHeight
                )
        }
            .buttonStyle(CalendarChangeMonthButtonStyle(
                backgroundColor: self.appState.uiTheme.inputBackgroundColor
            ))
            .opacity(self.isCollapsed ? 0.5 : 1)
            .disabled(self.isCollapsed)
        
    }
    
    var body: some View {

        HStack(alignment: .center) {

            self.getMonthChangeButton(icon: "arrow-back-sharp", delta: -1)
            
            Spacer()
            
            self.monthTitle
            
            Spacer()
            
            self.getMonthChangeButton(icon: "arrow-forward-sharp", delta: 1)
        }
    }
}

struct CalendarBlockMonth_Previews: PreviewProvider {
    
    static let appState = AppState()
    
    static var previews: some View {
        CalendarBlockMonth(selectedDay: Date(), isCollapsed: false)
            .padding(.vertical, 8)
            .background(UIThemeManager.DEFAULT.backgroundColor)
            .environmentObject(Self.appState)
    }
}
