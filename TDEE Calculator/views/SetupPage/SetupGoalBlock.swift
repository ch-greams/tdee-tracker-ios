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

    
    func getInputBlock(
        title: String,
        unit: String,
        input: Binding<String>,
        updateFunc: @escaping () -> Void
    ) -> some View {
        
        return HStack(alignment: .center, spacing: 0) {

            Text(title.uppercased())
                .font(.appTrendsItemLabel)
                .frame(width: 128, alignment: .leading)
                .padding(.horizontal, 16)
                .foregroundColor(.appPrimary)
            
            TextField("", text: input, onCommit: updateFunc)
                .font(.appTrendsItemValue)
                .frame(width: 140, height: 44)
                .border(Color.appPrimary)
                .foregroundColor(.appPrimary)
                .padding(.trailing, 8)
                .multilineTextAlignment(.trailing)
                .keyboardType(.numbersAndPunctuation)   // limit input to numbers
                .onTapGesture { self.isGoalOpen = true }
            
            Text(unit.uppercased())
                .font(.appTrendsItemLabel)
                .frame(width: 42, alignment: .leading)
                .foregroundColor(.appPrimary)
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
        
        let weightUnitLabel = self.appState.weightUnit.rawValue
        let energyUnitLabel = self.appState.energyUnit.rawValue
        
        return VStack(alignment: .center, spacing: 0) {
            
            SetupBlockTitle(title: "Goal")
            
            self.getInputBlock(
                title: "Goal",
                unit: weightUnitLabel,
                input: self.$appState.goalWeightInput,
                updateFunc: {
                
                    if let value = NumberFormatter().number(from: self.appState.goalWeightInput) {
                        self.appState.goalWeight = value.doubleValue
                    }
                    
                    self.appState.refreshGoalBasedValues()
                    self.appState.saveGoalWeight()
                    
                    self.appState.goalWeightInput = String(self.appState.goalWeight)
                }
            )
            
            self.getInputBlock(
                title: "Weekly Change",
                unit: weightUnitLabel,
                input: self.$appState.goalWeeklyDeltaInput,
                updateFunc: {

                    if let value = NumberFormatter().number(from: self.appState.goalWeeklyDeltaInput) {
                        self.appState.goalWeeklyDelta = value.doubleValue
                    }
                    
                    self.appState.refreshGoalBasedValues()
                    self.appState.saveGoalWeeklyDelta()

                    self.appState.goalWeeklyDeltaInput = String(self.appState.goalWeeklyDelta)
                }
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
