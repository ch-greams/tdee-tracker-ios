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
    
    let weeklyDeltas: [ Int : Double ] = [
      1 : 0.085,
      2 : 0.878,
      3 : 0.03,
      4 : 0.084,
      5 : 0.524,
      6 : 0.098,
      7 : 0.235,
      8 : 0.778,
      9 : 0.23,
      10 : 0.525,
      11 : 0.24,
      12 : 0.966
    ]
    
    var body: some View {

        let currentValue = self.appState.currentWeight - self.appState.startWeight
        let goalValue = self.appState.goalWeight - self.appState.startWeight
        
        return ZStack(alignment: .top) {

            Color.appPrimary.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 0) {
            
                Text("Starting from April 12th")
                    .font(.appCalendarMonth)
                    .foregroundColor(.white)
                
                DeltaChart(weeklyDeltas: weeklyDeltas)
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
