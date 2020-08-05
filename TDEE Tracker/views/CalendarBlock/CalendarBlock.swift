//
//  Calendar.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/2/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI



struct CalendarBlockStyle {
    
    // MARK: - Sizes
    
    public let calendarBlockMonthBPadding: CGFloat = 4 // SE = 4
    
    public let calendarBlockDaysVPaddingCollapsed: CGFloat = 6
    public let calendarBlockDaysVPadding: CGFloat = 14
    public let calendarBlockDaysHPadding: CGFloat = 8
    
    public let calendarWeekdayHSpacing: CGFloat
    public let calendarDayButtonSize: CGFloat
    
    // MARK: - Fonts

    public let calendarWeekdayTitleFont: Font = .custom(FontOswald.ExtraLight, size: 14)
    
    // MARK: - Init
    
    init(uiSizes: UISizes) {
        
        self.calendarWeekdayHSpacing = uiSizes.calendarDaySpacing
        self.calendarDayButtonSize = uiSizes.calendarDayButton
    }
}


struct CalendarBlock: View {
    
    private let style: CalendarBlockStyle = CalendarBlockStyle(uiSizes: UISizes.current)
    
    @EnvironmentObject var appState: AppState
    
    let selectedDay: Date
    let isCollapsed: Bool
    let isTrendsPage: Bool


    var weekdayTitles: some View {
        
        HStack(alignment: .center, spacing: self.style.calendarWeekdayHSpacing) {
            
            ForEach(Utils.getShortWeekdayNames(), id: \.self) { day in
                
                Text(day.uppercased())
                    .font(self.style.calendarWeekdayTitleFont)
                    .frame(
                        width: self.style.calendarDayButtonSize,
                        height: self.style.calendarDayButtonSize
                    )
                    .foregroundColor(self.appState.uiTheme.calendarTextDefaultColor)
            }
        }
    }
    
    var body: some View {
    
        VStack(alignment: .center, spacing: 0) {
            
            CalendarBlockMonth(selectedDay: self.selectedDay, isCollapsed: self.isCollapsed)
                .padding(.bottom, self.style.calendarBlockMonthBPadding)
            
            VStack(alignment: .center, spacing: 0) {

                self.weekdayTitles
                
                CalendarBlockDays(
                    selectedDay: self.selectedDay,
                    isCollapsed: self.isCollapsed,
                    isTrendsPage: self.isTrendsPage
                )
            }
                .padding(.vertical, (
                    self.isCollapsed
                        ? self.style.calendarBlockDaysVPaddingCollapsed
                        : self.style.calendarBlockDaysVPadding
                ))
                .background(self.appState.uiTheme.inputBackgroundColor)
                .padding(.horizontal, self.style.calendarBlockDaysHPadding)
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

