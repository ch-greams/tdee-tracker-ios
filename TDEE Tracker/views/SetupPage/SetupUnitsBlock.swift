//
//  SetupUnitsBlock.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/10/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI



struct SetupUnitsBlock: View {
    
    @EnvironmentObject var appState: AppState
    

    var body: some View {
        
        return VStack(alignment: .center, spacing: 0) {
        
            SetupBlockTitle(
                title: Label.units,
                textColor: self.appState.uiTheme.mainTextColor,
                paddingTop: 6
            )
            
            InputBlock.Toggle(
                title: Label.weight,
                setValue: self.appState.updateWeightUnit as (WeightUnit) -> Void,
                first: WeightUnit.kg,
                second: WeightUnit.lb,
                selected: self.appState.weightUnit as WeightUnit?,
                maxHeight: self.appState.uiSizes.setupInputHeight,
                backgroundColor: self.appState.uiTheme.inputBackgroundColor,
                accentColor: self.appState.uiTheme.inputAccentColor
            )
            
            InputBlock.Toggle(
                title: Label.energy,
                setValue: self.appState.updateEnergyUnit as (EnergyUnit) -> Void,
                first: EnergyUnit.kcal,
                second: EnergyUnit.kj,
                selected: self.appState.energyUnit as EnergyUnit?,
                maxHeight: self.appState.uiSizes.setupInputHeight,
                backgroundColor: self.appState.uiTheme.inputBackgroundColor,
                accentColor: self.appState.uiTheme.inputAccentColor
            )
        }
    }
}

struct SetupUnitsBlock_Previews: PreviewProvider {
    
    static let appState = AppState()
    
    static var previews: some View {
        SetupUnitsBlock()
            .padding(.vertical, 8)
            .background(UIThemeManager.DEFAULT.backgroundColor)
            .environmentObject(appState)
    }
}
