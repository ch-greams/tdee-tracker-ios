//
//  WelcomePage.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/25/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI

struct WelcomePage: View {
    
    @EnvironmentObject var appState: AppState
    
    @State var isSecondStep: Bool = false
    
    // MARK: - Step #1
    
    @State var isWeightUnitSelected: Bool = false
    @State var isEnergyUnitSelected: Bool = false

    @State var weightUnit: WeightUnit?
    @State var energyUnit: EnergyUnit?

    // MARK: - Step #2
    
    @State var isCurrentWeightOpen: Bool = false
    @State var isGoalWeightOpen: Bool = false
    @State var isDeltaWeightOpen: Bool = false
    
    var isCurrentWeightEntered: Bool { self.appState.weight > 0 }
    var isGoalWeightEntered: Bool { self.appState.goalWeight > 0 }
    var isDeltaWeightEntered: Bool { self.appState.goalWeeklyWeightDelta > 0 }
    
    // MARK: - Constants
    
    let WEIGHT_UNIT_HINT = "Please select measurement unit that would be used for bodyweight values"
    let ENERGY_UNIT_HINT = "And this measurement unit will be used for food and energy values"
    
    let CURRENT_WEIGHT_HINT = "For the best result always measure it at the same time in the morning"
    let GOAL_WEIGHT_HINT = "Goal weight is what you strife for"
    
    let SETTINGS_HINT = "Parameters can be changed at any time in the application settings"
    
    var deltaWeightHint: String {
        
        let onePercent = self.appState.weight / 100
        let onePercentLabel = String(format: "%.2f", onePercent)
        
        let weightUnitLabel = self.appState.weightUnit.rawValue
        
        return "Based on your current weight weekly change must not be bigger than \(onePercentLabel) \(weightUnitLabel)"
    }
    
    func getTitle(title: String, subtitle: String) -> some View {

        VStack(alignment: .center, spacing: 0) {

            Text(title)
                .font(.appWelcomeTitle)
                .foregroundColor(.white)
                .padding(.bottom, 20)
            
            Text(subtitle)
                .font(.appWelcomeSubtitle)
                .foregroundColor(.white)
                .padding(.bottom, 40)
        }
    }
    
    // MARK: - Step #1
    
    var unitsBlock: some View {
        
        VStack(alignment: .center, spacing: 0) {
            
            InputBlock.Toggle(
                title: "Weight",
                setValue: {
                    self.weightUnit = $0
                    self.isWeightUnitSelected = true
                },
                first: (value: WeightUnit.kg, label: WeightUnit.kg.rawValue.uppercased()),
                second: (value: WeightUnit.lb, label: WeightUnit.lb.rawValue.uppercased()),
                selected: self.weightUnit as WeightUnit?
            )
                .padding(.bottom, 20)

            if !self.isWeightUnitSelected {
               
                Text(self.WEIGHT_UNIT_HINT)
                    .font(.appWelcomeHint)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 28)
                    .padding(.bottom, 40)
                
            }
            else {

                InputBlock.Toggle(
                    title: "Energy",
                    setValue: {
                        self.energyUnit = $0
                        self.isEnergyUnitSelected = true
                    },
                    first: (value: EnergyUnit.kcal, label: EnergyUnit.kcal.rawValue.uppercased()),
                    second: (value: EnergyUnit.kj, label: EnergyUnit.kj.rawValue.uppercased()),
                    selected: self.energyUnit as EnergyUnit?
                )
                    .padding(.bottom, 20)

                Text(!self.isEnergyUnitSelected ? self.ENERGY_UNIT_HINT : self.SETTINGS_HINT)
                    .font(.appWelcomeHint)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 28)
                    .padding(.bottom, 40)
            }
        }
    }
    
    func completeFirstStep() {
        
        self.appState.setUnits(weightUnit: self.weightUnit, energyUnit: self.energyUnit)
        
        self.isSecondStep = true
    }
    
    var firstStepBlock: some View {
        
        VStack(alignment: .center, spacing: 0) {
            
            self.getTitle(title: "Welcome", subtitle: "Let’s get started")
            
            self.unitsBlock.frame(height: 460, alignment: .top)
            
            if self.isWeightUnitSelected && self.isEnergyUnitSelected {
                
                Button(
                    action: self.completeFirstStep,
                    label: { Text("NEXT").font(.appSetupToggleValue) }
                )
                    .buttonStyle(WelcomeActionButtonStyle())
            }
        }
    }
    
    // MARK: - Step #2 Inputs & Hints
    
    var currentWeightInputBlock: some View {
        
        InputBlock.Number(
            title: "Today’s weight",
            unit: self.appState.weightUnit.rawValue,
            input: self.$appState.weightInput,
            updateInput: self.appState.updateWeightFromInput,
            openInput: { self.isCurrentWeightOpen = true }
        )
            .padding(.bottom, 10)
    }
    
    var currentWeightInputHintBlock: some View {
        
        Text(self.CURRENT_WEIGHT_HINT)
            .font(.appWelcomeHint)
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 28)
            .padding(.bottom, 40)
    }
    
    var goalWeightInputBlock: some View {
        
        InputBlock.Number(
            title: "Goal weight",
            unit: self.appState.weightUnit.rawValue,
            input: self.$appState.goalWeightInput,
            updateInput: self.appState.saveGoalWeightFromInput,
            openInput: { self.isGoalWeightOpen = true }
        )
            .padding(.bottom, 10)
    }
    
    var goalWeightInputHintBlock: some View {
        Text(self.GOAL_WEIGHT_HINT)
            .font(.appWelcomeHint)
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 28)
            .padding(.bottom, 40)
    }
    
    var deltaWeightInputBlock: some View {
        
        InputBlock.Number(
            title: "Weekly change",
            unit: self.appState.weightUnit.rawValue,
            input: self.$appState.goalWeeklyWeightDeltaInput,
            updateInput: self.appState.saveGoalWeeklyDeltaFromInput,
            openInput: { self.isDeltaWeightOpen = true }
        )
            .padding(.bottom, 10)
    }
    
    var deltaWeightInputHintBlock: some View {

        Text(self.deltaWeightHint)
            .font(.appWelcomeHint)
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 28)
            .padding(.bottom, 40)
    }
    
    // MARK: - Step #2 General
    
    var settingsBlock: some View {

        VStack(alignment: .center, spacing: 0) {
            
            self.currentWeightInputBlock

            if !self.isCurrentWeightEntered {

                self.currentWeightInputHintBlock
            }
            else {
                
                self.goalWeightInputBlock

                if !self.isGoalWeightEntered {
                    
                    self.goalWeightInputHintBlock
                }
                else {

                    self.deltaWeightInputBlock
                    
                    if self.isDeltaWeightEntered {
                        TargetDelta(
                            value: self.appState.goalTargetFoodDelta,
                            unit: self.appState.energyUnit.rawValue
                        )
                            .padding(.bottom, 20)
                    }
                    
                    self.deltaWeightInputHintBlock
                }
            }
        }
    }
    
    var secondStepBlock: some View {
        
        VStack(alignment: .center, spacing: 0) {
            
            self.getTitle(title: "Almost Ready", subtitle: "Define your goals")

            self.settingsBlock.frame(height: 460, alignment: .top)
            
            if self.isCurrentWeightEntered && self.isGoalWeightEntered && self.isDeltaWeightEntered {
                
                Button(
                    action: self.appState.completeFirstSetup,
                    label: { Text("DONE").font(.appSetupToggleValue) }
                )
                    .buttonStyle(WelcomeActionButtonStyle())
            }
        }
    }
    
    var body: some View {
        
        ZStack(alignment: .top) {

            Color.appPrimary.edgesIgnoringSafeArea(.all)
            
            if !self.isSecondStep {
                
                self.firstStepBlock
            }
            else {

                self.secondStepBlock
            }
        }
    }
}

struct WelcomePage_Previews: PreviewProvider {
    
    static let appState = AppState()

    static var previews: some View {
        WelcomePage().environmentObject(appState)
    }
}
