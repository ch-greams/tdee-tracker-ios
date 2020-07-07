//
//  ProgressPage.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/18/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct ProgressPage: View {
    
    @EnvironmentObject var appState: AppState
    
    var body: some View {

        let formatter = DateFormatter()
        formatter.dateFormat = Label.progressDateFormat
        let startDateStr = formatter.string(from: self.appState.firstEntryDate)
        
        let title = "\(Label.startingFrom) \(startDateStr)".uppercased()
        
        let progressData = self.appState.progressData
        
        return VStack(alignment: .center, spacing: 0) {
            
            Text(title)
                .font(.appCalendarMonth)
                .foregroundColor(self.appState.uiTheme.mainTextColor)
                .padding(.top, 4)
            
            DeltaChart(
                totalStepsHeight: self.appState.uiSizes.progressChartHeight,
                weeklyDeltas: self.appState.weeklyWeightDeltas,
                weightUnit: self.appState.weightUnit.localized,
                mainColor: self.appState.uiTheme.mainTextColor
            )
                .padding(.vertical, self.appState.uiSizes.progressPageSpacing)

            ProgressCircle(
                circleDiameter: self.appState.uiSizes.progressCircleDiameter,
                circleWidth: self.appState.uiSizes.progressCircleWidth,
                currentWeightValue: progressData.progressWeight,
                goalWeightValue: progressData.goalWeight,
                unit: self.appState.weightUnit.localized,
                estimatedTimeLeft: progressData.estimatedTimeLeft,
                mainColor: self.appState.uiTheme.mainTextColor
            )
        }
    }
}

struct ProgressPage_Previews: PreviewProvider {
    
    static let appState = AppState()
    
    static var previews: some View {
        
        ZStack(alignment: .top) {
            
            Self.appState.uiTheme.backgroundColor.edgesIgnoringSafeArea(.all)
            
            ProgressPage().environmentObject(appState)
        }
    }
}
