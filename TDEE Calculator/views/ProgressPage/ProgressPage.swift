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

        let currentValue = self.appState.currentWeight - self.appState.startWeight
        let goalValue = self.appState.goalWeight - self.appState.startWeight
        
        return ZStack(alignment: .top) {

            Color.appPrimary.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 0) {
            
                Text("Starting from April 12th")
                    .font(.appCalendarMonth)
                    .foregroundColor(.white)
                
                DeltaChart(weeklyDeltas: self.appState.weeklyWeightDeltas)
                    .padding(.top, 20)

                ProgressCircle(
                    currentValue: currentValue,
                    goalValue: goalValue,
                    unit: "kg",
                    estimatedTimeLeft: self.appState.estimatedTimeLeft
                )
                    .padding(.top, 40)
            }
        }
    }
}

struct ProgressPage_Previews: PreviewProvider {
    
    static let appState = AppState()
    
    static var previews: some View {
        ProgressPage().environmentObject(appState)
    }
}
