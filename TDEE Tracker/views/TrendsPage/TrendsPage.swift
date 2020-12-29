//
//  TrendsPage.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/7/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct TrendsPageSizes {
    
    public let calendarBlockBPadding: CGFloat

    // MARK: - Init
    
    init(hasNotch: Bool, scale: CGFloat) {

        self.calendarBlockBPadding = scale * 8
    }
}



struct TrendsPage: View {
    
    private let sizes = TrendsPageSizes(hasNotch: UISizes.hasNotch, scale: UISizes.scale)

    @EnvironmentObject var appState: AppState

    
    var body: some View {

        VStack(alignment: .center, spacing: 0) {

            CalendarBlock(
                selectedDay: self.appState.selectedDay,
                isCollapsed: false,
                isTrendsPage: true
            )
                .padding(.bottom, self.sizes.calendarBlockBPadding)
            
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
