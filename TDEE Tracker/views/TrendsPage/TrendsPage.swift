//
//  TrendsPage.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/7/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct TrendsPageStyle {
    
    public let calendarBlockBPadding: CGFloat = 8
}



struct TrendsPage: View {
    
    private let style: TrendsPageStyle = TrendsPageStyle()

    @EnvironmentObject var appState: AppState

    
    var body: some View {

        VStack(alignment: .center, spacing: 0) {

            CalendarBlock(
                selectedDay: self.appState.selectedDay,
                isCollapsed: false,
                isTrendsPage: true
            )
                .padding(.bottom, self.style.calendarBlockBPadding)
            
            WeeklyTrendsBlock(
                weightUnitLabel: self.appState.weightUnit.localized,
                energyUnitLabel: self.appState.energyUnit.localized,
                selectedDay: self.appState.selectedDay,
                summary: self.appState.selectedWeekSummary,
                trendsChange: self.appState.trendsChange,
                backgroundColor: self.appState.uiTheme.inputBackgroundColor,
                accentColor: self.appState.uiTheme.trendsSeparatorColor,
                textColor: self.appState.uiTheme.secondaryTextColor,
                iconColor: self.appState.uiTheme.secondaryTextColorName
            )
        }
    }
}

struct TrendsPage_Previews: PreviewProvider {

    static let appState = AppState()
    
    static var previews: some View {
        
        ZStack(alignment: .top) {
            
            Self.appState.uiTheme.backgroundColor.edgesIgnoringSafeArea(.all)
        
            TrendsPage().environmentObject(appState)
        }
    }
}
