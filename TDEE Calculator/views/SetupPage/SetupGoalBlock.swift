//
//  SetupGoalBlock.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/10/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI

struct SetupGoalBlock: View {
    
    @EnvironmentObject var appState: AppState
    
    @Binding var isGoalOpen: Bool


    var body: some View {
        
        let weightUnitLabel = self.appState.weightUnit.rawValue
        let energyUnitLabel = self.appState.energyUnit.rawValue
        
        return VStack(alignment: .center, spacing: 0) {
            
            SetupBlockTitle(title: "Goal")
            
            InputBlock.Number(
                title: "Goal Weight",
                unit: weightUnitLabel,
                input: self.$appState.goalWeightInput,
                updateInput: {
                
                    if let value = NumberFormatter().number(from: self.appState.goalWeightInput) {
                        self.appState.goalWeight = value.doubleValue
                    }
                    
                    self.appState.refreshGoalBasedValues()
                    self.appState.saveGoalWeight()
                    
                    self.appState.goalWeightInput = String(self.appState.goalWeight)
                },
                openInput: { self.isGoalOpen = true }
            )
            
            InputBlock.Number(
                title: "Weekly Change",
                unit: weightUnitLabel,
                input: self.$appState.goalWeeklyDeltaInput,
                updateInput: {

                    if let value = NumberFormatter().number(from: self.appState.goalWeeklyDeltaInput) {
                        self.appState.goalWeeklyDelta = value.doubleValue
                    }
                    
                    self.appState.refreshGoalBasedValues()
                    self.appState.saveGoalWeeklyDelta()

                    self.appState.goalWeeklyDeltaInput = String(self.appState.goalWeeklyDelta)
                },
                openInput: { self.isGoalOpen = true }
            )
            
            TargetSurplus(value: self.appState.goalTargetFoodSurplus, unit: energyUnitLabel)
            
        }
    }
}

struct SetupGoalBlock_Previews: PreviewProvider {

    static let appState = AppState()
    
    static var previews: some View {
        SetupGoalBlock(isGoalOpen: .constant(true))
            .padding(.vertical, 8)
            .background(Color.appPrimary)
            .environmentObject(appState)
    }
}
