//
//  TrendsPage.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/7/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI

struct TrendsPage: View {

    @EnvironmentObject var appState: AppState

    
    var body: some View {

        VStack(alignment: .center, spacing: 0) {

            CalendarBlock(
                selectedDay: self.appState.selectedDay,
                isTrendsPage: true
            )
                .padding(.bottom, 8)
            
            WeeklyTrendsBlock(
                weightUnitLabel: self.appState.weightUnit.rawValue,
                energyUnitLabel: self.appState.energyUnit.rawValue,
                selectedDay: self.appState.selectedDay,
                summary: self.appState.selectedWeekSummary,
                trendsChange: self.appState.trendsChange,
                trendsElementPadding: self.appState.uiSizes.trendsElementPadding,
                trendsItemLabelFontSize: self.appState.uiSizes.trendsItemLabelFontSize,
                trendsItemValueFontSize: self.appState.uiSizes.trendsItemValueFontSize,
                trendsItemUnitFontSize: self.appState.uiSizes.trendsItemUnitFontSize
            )
        }
    }
}

struct TrendsPage_Previews: PreviewProvider {

    static let appState = AppState()
    
    static var previews: some View {
        
        ZStack(alignment: .top) {
            
            Color.appPrimary.edgesIgnoringSafeArea(.all)
        
            TrendsPage().environmentObject(appState)
        }
    }
}
