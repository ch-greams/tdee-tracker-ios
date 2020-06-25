//
//  WelcomePage.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/25/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI

struct WelcomePage: View {
    
    var isFirstStep: Bool = false
    
    let weightUnitHint = "Please select measurement unit that would be used for bodyweight values"
    let energyUnitHint = "And this measurement unit will be used for food and energy values"
    
    let curWeightHint = "For the best result always measure it at the same time in the morning"
    let goalWeightHint = "Goal weight is what you strife for"
    let deltaHint = "Based on your current weight weekly change must not be bigger than 0.72 kg"
    
    let settingsHint = "Parameters can be changed at any time later in application settings"
    
    func getFirstStepBlock(showEnergyBlock: Bool) -> some View {
        
        VStack(alignment: .center, spacing: 0) {
            
            Text("Welcome")
                .font(.appWelcomeTitle)
                .foregroundColor(.white)
                .padding(.bottom, 20)
            
            Text("Let’s get started")
                .font(.appWelcomeSubtitle)
                .foregroundColor(.white)
                .padding(.bottom, 50)
            
            InputBlock.Toggle(
                title: "Weight",
                setValue: { print($0.rawValue) }, //self.appState.updateWeightUnit as (WeightUnit) -> Void,
                first: (value: WeightUnit.kg, label: WeightUnit.kg.rawValue.uppercased()),
                second: (value: WeightUnit.lb, label: WeightUnit.lb.rawValue.uppercased()),
                selected: nil //self.appState.weightUnit as WeightUnit?
            )
                .padding(.bottom, 20)
            
            
            if showEnergyBlock {
               
                InputBlock.Toggle(
                    title: "Energy",
                    setValue: { print($0.rawValue) }, //self.appState.updateWeightUnit as (WeightUnit) -> Void,
                    first: (value: EnergyUnit.kcal, label: EnergyUnit.kcal.rawValue.uppercased()),
                    second: (value: EnergyUnit.kj, label: EnergyUnit.kj.rawValue.uppercased()),
                    selected: nil //self.appState.weightUnit as WeightUnit?
                )
                    .padding(.bottom, 20)
            }
            
            Text(showEnergyBlock ? self.energyUnitHint : self.weightUnitHint)
                .font(.appWelcomeHint)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 28)
                .padding(.bottom, 40)
            
            if showEnergyBlock {
            
                Button(action: { print("NEXT") }, label: { Text("NEXT").font(.appSetupToggleValue) })
                    .buttonStyle(WelcomeActionButtonStyle())
                    .padding(.top, 160)
            }
        }
    }
    
    func getSecondStepBlock(showGoal: Bool, showDone: Bool) -> some View {
        
        VStack(alignment: .center, spacing: 0) {
            
            Text("Almost Ready")
                .font(.appWelcomeTitle)
                .foregroundColor(.white)
                .padding(.bottom, 20)
            
            Text("Define your goals")
                .font(.appWelcomeSubtitle)
                .foregroundColor(.white)
                .padding(.bottom, 50)

            InputBlock.Number(
                title: "Today’s weight",
                unit: "kg",
                input: .constant("72.3"),
                updateInput: { print("updateInput") },
                openInput: { print("openInput") }
            )
                .padding(.bottom, 20)

            if !showGoal {

                Text(self.curWeightHint)
                    .font(.appWelcomeHint)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 28)
                    .padding(.bottom, 40)
            }
            else {
                
                InputBlock.Number(
                    title: "Goal weight",
                    unit: "kg",
                    input: .constant("76.5"),
                    updateInput: { print("updateInput") },
                    openInput: { print("openInput") }
                )
                    .padding(.bottom, 20)

                if !showDone {
                    
                    Text(self.goalWeightHint)
                        .font(.appWelcomeHint)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 28)
                        .padding(.bottom, 40)
                }
                else {

                    InputBlock.Number(
                        title: "Weekly change",
                        unit: "kg",
                        input: .constant("0.3"),
                        updateInput: { print("updateInput") },
                        openInput: { print("openInput") }
                    )
                    
                    TargetSurplus(value: 243, unit: "kg")
                
                    Button(action: { print("DONE") }, label: { Text("DONE").font(.appSetupToggleValue) })
                        .buttonStyle(WelcomeActionButtonStyle())
                        .padding(.top, 120)
                }
            }
        }
    }
    
    var body: some View {
        
        ZStack(alignment: .top) {

            Color.appPrimary.edgesIgnoringSafeArea(.all)
            
            if self.isFirstStep {
                
                self.getFirstStepBlock(showEnergyBlock: true)
            }
            else {

                self.getSecondStepBlock(showGoal: false, showDone: false)
            }
        }
    }
}

struct WelcomePage_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePage()
    }
}
