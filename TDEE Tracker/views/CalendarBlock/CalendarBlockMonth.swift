//
//  CalendarBlockMonth.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/5/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct CalendarBlockMonthSizes {
    
    // MARK: - Sizes
    
    public let monthChangeButtonIconWidth: CGFloat = 44
    public let monthChangeButtonIconHeight: CGFloat = 28
    
    // MARK: - Fonts

    public let monthLabelFont: Font
    
    // MARK: - Init
    
    init(uiSizes: UISizes) {
        
        self.monthLabelFont = .custom(FontOswald.Medium, size: uiSizes.calendarMonthFontSize)
    }
}


struct CalendarBlockMonth: View {
    
    private let sizes = CalendarBlockMonthSizes(uiSizes: UISizes.current)
    
    @EnvironmentObject var appState: AppState
    
    let calendar = Calendar.current

    let selectedDay: Date
    let isCollapsed: Bool
    
    var monthTitle: Text {

        Text(selectedDay.toString("LLLL YYYY").uppercased())
            .font(self.sizes.monthLabelFont)
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

        Button(
            action: {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                self.changeMonth(delta: delta)
            },
            label: {
                CustomImage(name: icon, colorName: self.appState.uiTheme.calendarAccentColorName)
                    .frame(
                        width: self.sizes.monthChangeButtonIconWidth,
                        height: self.sizes.monthChangeButtonIconHeight
                    )
            }
        )
            .buttonStyle(CalendarChangeMonthButtonStyle(
                backgroundColor: self.appState.uiTheme.inputBackgroundColor
            ))
            .opacity(self.isCollapsed ? 0.5 : 1)
            .disabled(self.isCollapsed)
        
    }
    
    var body: some View {

        HStack(alignment: .center) {

            self.getMonthChangeButton(icon: "arrow-back-sharp", delta: -1)
            
            self.monthTitle.frame(maxWidth: .infinity)
            
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
