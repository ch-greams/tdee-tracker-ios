//
//  SetupGoalBlock.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/10/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct SetupGoalBlockSizes {
    
    // MARK: - Sizes
    
    public let targetDeltaVPadding: CGFloat
    
    // MARK: - Init
    
    init(uiSizes: UISizes) {
        
        self.targetDeltaVPadding = uiSizes.setupTargetDeltaPadding
    }
}



struct SetupGoalBlock: View {
    
    private let sizes = SetupGoalBlockSizes(uiSizes: UISizes.current)
    
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
            
            InputNumber(
                title: Label.goalWeight,
                unit: weightUnitLabel,
                input: self.$appState.goalWeightInput,
                onCommit: {
                    self.appState.saveGoalWeightFromInput()
                    
                    self.appState.currentInput = nil
                    self.isGoalWeightOpen = false
                },
                openInput: {
                    self.appState.currentInput = InputName.GoalWeight
                    self.isGoalWeightOpen = true
                },
                isOpen: self.isGoalWeightOpen,
                isSelected: self.appState.currentInput == InputName.GoalWeight,
                backgroundColor: self.appState.uiTheme.inputBackgroundColor,
                backgroundSelectedColor: self.appState.uiTheme.calendarWeekHighlight,
                confirmButtonColor: self.appState.uiTheme.inputConfirmButtonColor,
                accentColor: self.appState.uiTheme.inputAccentColor
            )

            InputNumber(
                title: Label.weeklyChange,
                unit: weightUnitLabel,
                input: self.$appState.goalWeeklyWeightDeltaInput,
                onCommit: {
                    self.appState.saveGoalWeeklyDeltaFromInput()
                    
                    self.appState.currentInput = nil
                    self.isDeltaWeightOpen = false
                },
                openInput: {
                    self.appState.currentInput = InputName.GoalWeeklyWeightDelta
                    self.isDeltaWeightOpen = true
                },
                isOpen: self.isDeltaWeightOpen,
                isSelected: self.appState.currentInput == InputName.GoalWeeklyWeightDelta,
                backgroundColor: self.appState.uiTheme.inputBackgroundColor,
                backgroundSelectedColor: self.appState.uiTheme.calendarWeekHighlight,
                confirmButtonColor: self.appState.uiTheme.inputConfirmButtonColor,
                accentColor: self.appState.uiTheme.inputAccentColor
            )
            
            TargetDelta(
                value: self.appState.goalTargetFoodDelta,
                unit: energyUnitLabel,
                textColor: self.appState.uiTheme.mainTextColor
            )
                .padding(.vertical, self.sizes.targetDeltaVPadding)
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
