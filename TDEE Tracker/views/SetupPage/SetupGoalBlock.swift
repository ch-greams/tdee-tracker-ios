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
        
        let weightUnitLabel = self.appState.weightUnit.localized
        let energyUnitLabel = self.appState.energyUnit.localized
        
        return VStack(alignment: .center, spacing: 0) {
            
            SetupBlockTitle(
                title: Label.goal,
                textColor: self.appState.uiTheme.mainTextColor
            )
            
            InputBlock.Number(
                title: Label.goalWeight,
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
                backgroundColorName: self.appState.uiTheme.inputBackgroundColorName,
                confirmButtonColor: self.appState.uiTheme.inputConfirmButtonColor,
                accentColor: self.appState.uiTheme.inputAccentColor
            )

            InputBlock.Number(
                title: Label.weeklyChange,
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
                backgroundColorName: self.appState.uiTheme.inputBackgroundColorName,
                confirmButtonColor: self.appState.uiTheme.inputConfirmButtonColor,
                accentColor: self.appState.uiTheme.inputAccentColor
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
            .background(UIThemeManager.DEFAULT.backgroundColor)
            .environmentObject(appState)
    }
}
