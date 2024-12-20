//
//  Calendar.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/2/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI



struct CalendarBlockSizes {
    
    // MARK: - Sizes
    
    public let calendarBlockMonthBPadding: CGFloat
    
    public let calendarBlockDaysVPaddingCollapsed: CGFloat
    public let calendarBlockDaysVPadding: CGFloat
    public let calendarBlockDaysHPadding: CGFloat
    public let calendarWeekdayHSpacing: CGFloat

    public let calendarDayButtonSize: CGFloat
    
    // MARK: - Fonts

    public let calendarWeekdayTitleFont: Font
    
    // MARK: - Init
    
    init(hasNotch: Bool, scale: CGFloat) {
        
        self.calendarBlockMonthBPadding = scale * 5
    
        self.calendarBlockDaysVPaddingCollapsed = scale * 6
        self.calendarBlockDaysVPadding = scale * 8
        self.calendarBlockDaysHPadding = 8

        self.calendarWeekdayTitleFont = .custom(FontOswald.ExtraLight, size: scale * 14)

        if hasNotch {
            self.calendarDayButtonSize = scale * 44
            self.calendarWeekdayHSpacing = scale * 6
        }
        else {
            self.calendarDayButtonSize = scale * 31
            self.calendarWeekdayHSpacing = scale * 10
        }
    }
}


struct CalendarBlock: View {
    
    private let sizes = CalendarBlockSizes(hasNotch: UISizes.hasNotch, scale: UISizes.scale)
    
    @EnvironmentObject var appState: AppState
    
    let selectedDay: Date
    let isCollapsed: Bool
    let isTrendsPage: Bool


    var weekdayTitles: some View {
        
        HStack(alignment: .center, spacing: self.sizes.calendarWeekdayHSpacing) {
            
            ForEach(Utils.getShortWeekdayNames(), id: \.self) { day in
                
                Text(day.uppercased())
                    .font(self.sizes.calendarWeekdayTitleFont)
                    .frame(
                        width: self.sizes.calendarDayButtonSize,
                        height: self.sizes.calendarDayButtonSize
                    )
                    .foregroundColor(self.appState.uiTheme.calendarTextDefaultColor)
            }
        }
    }
    
    var body: some View {
    
        VStack(alignment: .center, spacing: 0) {
            
            CalendarBlockMonth(selectedDay: self.selectedDay, isCollapsed: self.isCollapsed)
                .padding(.bottom, self.sizes.calendarBlockMonthBPadding)
            
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
                        ? self.sizes.calendarBlockDaysVPaddingCollapsed
                        : self.sizes.calendarBlockDaysVPadding
                ))
                .background(self.appState.uiTheme.inputBackgroundColor)
                .padding(.horizontal, self.sizes.calendarBlockDaysHPadding)
                .clipped()
                .shadow(color: .SHADOW_COLOR, radius: 1, x: 1, y: 1)
                .disabled(self.isCollapsed)
        }
    }
}

struct CalendarBlock_EntryPage_Previews: PreviewProvider {
    
    static let appState = AppState()

    static var previews: some View {
        
        CalendarBlock(selectedDay: Date.today, isCollapsed: false, isTrendsPage: false)
            .padding(.vertical, 8)
            .background(Self.appState.uiTheme.backgroundColor)
            .environmentObject(appState)
    }
}

struct CalendarBlock_EntryPage_Collapsed_Previews: PreviewProvider {
    
    static let appState = AppState()

    static var previews: some View {
        
        CalendarBlock(selectedDay: Date.today, isCollapsed: true, isTrendsPage: false)
            .padding(.vertical, 8)
            .background(Self.appState.uiTheme.backgroundColor)
            .environmentObject(appState)
    }
}


struct CalendarBlock_TrendsPage_Previews: PreviewProvider {
    
    static let appState = AppState()
    
    static var previews: some View {
        
        CalendarBlock(selectedDay: Date.today, isCollapsed: false, isTrendsPage: true)
            .padding(.vertical, 8)
            .background(Self.appState.uiTheme.backgroundColor)
            .environmentObject(appState)
    }
}

