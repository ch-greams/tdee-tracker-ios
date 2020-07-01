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
    
    @Binding var isOpen: Bool


    var body: some View {
        
        let weightUnitLabel = self.appState.weightUnit.rawValue
        let energyUnitLabel = self.appState.energyUnit.rawValue
        
        let doneAction = {
            UIApplication.shared.endEditing()
            
            self.appState.saveGoalWeightFromInput()
            self.appState.saveGoalWeeklyDeltaFromInput()
            
            self.isOpen = false
        }
        
        return VStack(alignment: .center, spacing: 0) {
            
            SetupBlockTitle(title: "Goal")
            
            InputBlock.Number(
                title: "Goal Weight",
                unit: weightUnitLabel,
                input: self.$appState.goalWeightInput,
                onCommit: self.appState.saveGoalWeightFromInput,
                openInput: { self.isOpen = true },
                isOpen: false
            )
            
            InputBlock.Number(
                title: "Weekly Change",
                unit: weightUnitLabel,
                input: self.$appState.goalWeeklyWeightDeltaInput,
                onCommit: self.appState.saveGoalWeeklyDeltaFromInput,
                openInput: { self.isOpen = true },
                isOpen: false
            )
            
            TargetDelta(value: self.appState.goalTargetFoodDelta, unit: energyUnitLabel)
            
            if self.isOpen {
                Button("CONFIRM", action: doneAction)
                    .buttonStyle(AppDefaultButtonStyle())
            }
        }
    }
}

struct SetupGoalBlock_Previews: PreviewProvider {

    static let appState = AppState()
    
    static var previews: some View {
        SetupGoalBlock(isOpen: .constant(true))
            .padding(.vertical, 8)
            .background(Color.appPrimary)
            .environmentObject(appState)
    }
}
