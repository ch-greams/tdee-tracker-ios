//
//  SetupUnitsBlock.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/10/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI

enum WeightUnit: String, Equatable {
    case kg = "KG"
    case lb = "LB"
}

enum EnergyUnit: String, Equatable {
    case kcal = "KCAL"
    case kj = "KJ"
}

struct ToggleButtonStyle: ButtonStyle {
    
    var isSelected: Bool
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 90, height: 40)
            .font(.appSetupToggleValue)
            .foregroundColor(!self.isSelected ? Color.appPrimary : Color.white)
            .background(self.isSelected ? Color.appPrimary : Color.white)
            .border(Color.appPrimary)
    }
}


struct SetupUnitsBlock: View {
    
    @State private var selectedWeightUnit: WeightUnit = WeightUnit.kg
    @State private var selectedEnergyUnit: EnergyUnit = EnergyUnit.kcal
    
    
    
    func getToggleBlock<T: Equatable>(
        title: String,
        setValue: @escaping (T) -> Void,
        first: (value: T, label: String),
        second: (value: T, label: String),
        selected: T
    ) -> some View {
        
        let label = Text(title.uppercased())
            .font(.appTrendsItemLabel)
            .frame(width: 128, alignment: .leading)
            .padding(.horizontal, 16)
            .foregroundColor(.appPrimary)

        let firstButton = Button(first.label, action: { setValue(first.value) })
            .buttonStyle(ToggleButtonStyle(isSelected: selected == first.value))
        
        let secondButton = Button(second.label, action: { setValue(second.value) })
            .buttonStyle(ToggleButtonStyle(isSelected: selected == second.value))

        
        return HStack(alignment: .center, spacing: 0) {

            label
            
            firstButton

            secondButton
        }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .frame(height: 74)
            .background(Color.white)
            .padding(.vertical, 1)
            .padding(.horizontal, 8)
            .clipped()
            .shadow(color: .appFade, radius: 1, x: 1, y: 1)

    }
    

    var body: some View {
        
        VStack(alignment: .center, spacing: 0) {
        
            SetupBlockTitle(title: "Units", paddingTop: 6)
            
            self.getToggleBlock(
                title: "Weight",
                setValue: { self.selectedWeightUnit = $0 },
                first: (value: WeightUnit.kg, label: WeightUnit.kg.rawValue.uppercased()),
                second: (value: WeightUnit.lb, label: WeightUnit.lb.rawValue.uppercased()),
                selected: self.selectedWeightUnit
            )
            
            self.getToggleBlock(
                title: "Energy",
                setValue: { self.selectedEnergyUnit = $0 },
                first: (value: EnergyUnit.kcal, label: EnergyUnit.kcal.rawValue.uppercased()),
                second: (value: EnergyUnit.kj, label: EnergyUnit.kj.rawValue.uppercased()),
                selected: self.selectedEnergyUnit
            )
        }
    }
}

struct SetupUnitsBlock_Previews: PreviewProvider {
    static var previews: some View {
        SetupUnitsBlock()
            .padding(.vertical, 8)
            .background(Color.appPrimary)
    }
}
