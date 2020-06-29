//
//  SetupUnitsBlock.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/10/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI



struct SetupUnitsBlock: View {
    
    @EnvironmentObject var appState: AppState
    

    var body: some View {
        
        return VStack(alignment: .center, spacing: 0) {
        
            SetupBlockTitle(title: "Units", paddingTop: 6)
            
            InputBlock.Toggle(
                title: "Weight",
                setValue: self.appState.updateWeightUnit as (WeightUnit) -> Void,
                first: (value: WeightUnit.kg, label: WeightUnit.kg.rawValue),
                second: (value: WeightUnit.lb, label: WeightUnit.lb.rawValue),
                selected: self.appState.weightUnit as WeightUnit?
            )
            
            InputBlock.Toggle(
                title: "Energy",
                setValue: self.appState.updateEnergyUnit as (EnergyUnit) -> Void,
                first: (value: EnergyUnit.kcal, label: EnergyUnit.kcal.rawValue),
                second: (value: EnergyUnit.kj, label: EnergyUnit.kj.rawValue),
                selected: self.appState.energyUnit as EnergyUnit?
            )
        }
    }
}

struct SetupUnitsBlock_Previews: PreviewProvider {
    
    static let appState = AppState()
    
    static var previews: some View {
        SetupUnitsBlock()
            .padding(.vertical, 8)
            .background(Color.appPrimary)
            .environmentObject(appState)
    }
}
