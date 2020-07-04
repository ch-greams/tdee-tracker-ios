//
//  SetupGoalBlock.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/10/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI

struct SetupGoalBlock: View {
    
    @EnvironmentObject var appState: AppState

    @State var isGoalWeightOpen: Bool = false
    @State var isDeltaWeightOpen: Bool = false

    
    
    var body: some View {
        
        let weightUnitLabel = self.appState.weightUnit.rawValue
        let energyUnitLabel = self.appState.energyUnit.rawValue
        
        return VStack(alignment: .center, spacing: 0) {
            
            SetupBlockTitle(
                title: "Goal",
                textColor: self.appState.uiTheme.mainTextColor
            )
            
            InputBlock.Number(
                title: "Goal Weight",
                unit: weightUnitLabel,
                input: self.$appState.goalWeightInput,
                onCommit: {
                    self.appState.saveGoalWeightFromInput()
                    
                    UIApplication.shared.endEditing()
                    self.isGoalWeightOpen = false
                },
                openInput: { self.isGoalWeightOpen = true },
                isOpen: self.isGoalWeightOpen,
                maxHeight: self.appState.uiSizes.setupInputHeight,
                backgroundColor: self.appState.uiTheme.inputBackgroundColor,
                backgroundColorName: self.appState.uiTheme.inputBackgroundColorName
            )

            InputBlock.Number(
                title: "Weekly Change",
                unit: weightUnitLabel,
                input: self.$appState.goalWeeklyWeightDeltaInput,
                onCommit: {
                    self.appState.saveGoalWeeklyDeltaFromInput()
                    
                    UIApplication.shared.endEditing()
                    self.isDeltaWeightOpen = false
                },
                openInput: { self.isDeltaWeightOpen = true },
                isOpen: self.isDeltaWeightOpen,
                maxHeight: self.appState.uiSizes.setupInputHeight,
                backgroundColor: self.appState.uiTheme.inputBackgroundColor,
                backgroundColorName: self.appState.uiTheme.inputBackgroundColorName
            )
            
            TargetDelta(
                value: self.appState.goalTargetFoodDelta,
                unit: energyUnitLabel,
                textColor: self.appState.uiTheme.mainTextColor
            )
                .padding(.vertical, self.appState.uiSizes.setupTargetDeltaPadding)
        }
    }
}

struct SetupGoalBlock_Previews: PreviewProvider {

    static let appState = AppState()
    
    static var previews: some View {
        SetupGoalBlock()
            .padding(.vertical, 8)
            .background(Color.appPrimary)
            .environmentObject(appState)
    }
}
