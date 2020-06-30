//
//  TrendsPage.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/7/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI

struct TrendsPage: View {

    @EnvironmentObject var appState: AppState

    
    var body: some View {

        ZStack(alignment: .top) {

            Color.appPrimary.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 0) {

                CalendarBlock(
                    selectedDay: self.appState.selectedDay,
                    isTrendsPage: true
                )
                
                WeeklyTrendsBlock(
                    weightUnitLabel: self.appState.weightUnit.rawValue,
                    energyUnitLabel: self.appState.energyUnit.rawValue,
                    selectedDay: self.appState.selectedDay,
                    summary: self.appState.selectedWeekSummary,
                    trendsChange: self.appState.trendsChange
                )
            }
        }
    }
}

struct TrendsPage_Previews: PreviewProvider {

    static let appState = AppState()
    
    static var previews: some View {
        TrendsPage().environmentObject(appState)
    }
}
