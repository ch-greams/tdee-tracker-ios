//
//  ProgressPage.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/18/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct ProgressPage: View {
    
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        let startDateStr = formatter.string(from: self.appState.firstEntryDate)
        
        let title = "Starting from \(startDateStr)".uppercased()
        
        let progressData = self.appState.progressData
        
        return VStack(alignment: .center, spacing: 0) {
            
            Text(title)
                .font(.appCalendarMonth)
                .foregroundColor(.appWhite)
                .padding(.top, 4)
            
            DeltaChart(
                totalStepsHeight: self.appState.uiSizes.progressChartHeight,
                weeklyDeltas: self.appState.weeklyWeightDeltas,
                weightUnit: self.appState.weightUnit.rawValue
            )
                .padding(.vertical, self.appState.uiSizes.progressPageSpacing)

            ProgressCircle(
                circleDiameter: self.appState.uiSizes.progressCircleDiameter,
                circleWidth: self.appState.uiSizes.progressCircleWidth,
                currentWeightValue: progressData.progressWeight,
                goalWeightValue: progressData.goalWeight,
                unit: self.appState.weightUnit.rawValue,
                estimatedTimeLeft: progressData.estimatedTimeLeft
            )
        }
    }
}

struct ProgressPage_Previews: PreviewProvider {
    
    static let appState = AppState()
    
    static var previews: some View {
        
        ZStack(alignment: .top) {
            
            Color.appPrimary.edgesIgnoringSafeArea(.all)
            
            ProgressPage().environmentObject(appState)
        }
    }
}
