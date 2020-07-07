//
//  WelcomePage.swift
//  TDEE Tracker
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

    var deltaWeightHint: String {
        
        let onePercent = self.appState.weight / 100
        let weightUnitLabel = self.appState.weightUnit.localized

        return "\(Label.deltaWeightHint) \( onePercent.toString() ) \(weightUnitLabel)"
    }
    
    func getTitle(title: String, subtitle: String) -> some View {

        VStack(alignment: .center, spacing: 0) {

            Text(title)
                .font(.appWelcomeTitle)
                .padding(.bottom, 20)
            
            Text(subtitle)
                .font(.appWelcomeSubtitle)
                .padding(.bottom, 40)
        }
            .foregroundColor(self.appState.uiTheme.mainTextColor)
    }
    
    // MARK: - Step #1
    
    var unitsBlock: some View {
        
        VStack(alignment: .center, spacing: 0) {
            
            InputBlock.Toggle(
                title: Label.weight,
                setValue: {
                    self.weightUnit = $0
                    self.isWeightUnitSelected = true
                },
                first: WeightUnit.kg,
                second: WeightUnit.lb,
                selected: self.weightUnit as WeightUnit?,
                maxHeight: self.appState.uiSizes.setupInputHeight,
                backgroundColor: self.appState.uiTheme.inputBackgroundColor,
                accentColor: self.appState.uiTheme.inputAccentColor
            )
                .padding(.bottom)

            if !self.isWeightUnitSelected {
               
                Text(Label.weightUnitHint)
                    .font(.appWelcomeHint)
                    .foregroundColor(self.appState.uiTheme.mainTextColor)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 28)
                    .padding(.bottom)
                
            }
            else {

                InputBlock.Toggle(
                    title: Label.energy,
                    setValue: {
                        self.energyUnit = $0
                        self.isEnergyUnitSelected = true
                    },
                    first: EnergyUnit.kcal,
                    second: EnergyUnit.kj,
                    selected: self.energyUnit as EnergyUnit?,
                    maxHeight: self.appState.uiSizes.setupInputHeight,
                    backgroundColor: self.appState.uiTheme.inputBackgroundColor,
                    accentColor: self.appState.uiTheme.inputAccentColor
                )
                    .padding(.bottom)

                Text(!self.isEnergyUnitSelected ? Label.energyUnitHint : Label.settingsHint)
                    .font(.appWelcomeHint)
                    .foregroundColor(self.appState.uiTheme.mainTextColor)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 28)
                    .padding(.bottom)
                    
            }
        }
    }
    
    func completeFirstStep() {
        
        self.appState.setUnits(weightUnit: self.weightUnit, energyUnit: self.energyUnit)
        
        self.isSecondStep = true
    }
    
    var firstStepBlock: some View {
        
        VStack(alignment: .center, spacing: 0) {
            
            self.getTitle(title: Label.welcome, subtitle: Label.getStarted)
            
            self.unitsBlock
            
            Spacer()
            
            if self.isWeightUnitSelected && self.isEnergyUnitSelected {
                
                Button(Label.next, action: self.completeFirstStep)
                    .buttonStyle(AppDefaultButtonStyle(
                        backgroundColor: self.appState.uiTheme.inputBackgroundColor,
                        textColor: self.appState.uiTheme.secondaryTextColor
                    ))
                    .padding(.bottom, self.appState.uiSizes.welcomeConfirmButtonPadding)
            }
        }
    }
    
    // MARK: - Step #2 Inputs & Hints
    
    var currentWeightInputBlock: some View {
        
        InputBlock.Number(
            title: Label.todaysWeight,
            unit: self.appState.weightUnit.localized,
            input: self.$appState.weightInput,
            onCommit: {
                self.appState.updateWeightFromInput()
                
                UIApplication.shared.endEditing()
                self.isCurrentWeightOpen = false
            },
            openInput: { self.isCurrentWeightOpen = true },
            isOpen: self.isCurrentWeightOpen,
            maxHeight: self.appState.uiSizes.setupInputHeight,
            backgroundColor: self.appState.uiTheme.inputBackgroundColor,
            backgroundColorName: self.appState.uiTheme.inputBackgroundColorName,
            confirmButtonColor: self.appState.uiTheme.inputConfirmButtonColor,
            accentColor: self.appState.uiTheme.inputAccentColor
        )
            .padding(.bottom)
    }
    
    var currentWeightInputHintBlock: some View {
        
        Text(Label.currentWeightHint)
            .font(.appWelcomeHint)
            .foregroundColor(self.appState.uiTheme.mainTextColor)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 24)
            .padding(.bottom)
    }
    
    var goalWeightInputBlock: some View {
        
        InputBlock.Number(
            title: Label.goalWeight,
            unit: self.appState.weightUnit.localized,
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
            .padding(.bottom)
    }
    
    var goalWeightInputHintBlock: some View {
        Text(Label.goalWeightHint)
            .font(.appWelcomeHint)
            .foregroundColor(self.appState.uiTheme.mainTextColor)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 28)
            .padding(.bottom)
    }
    
    var deltaWeightInputBlock: some View {
        
        InputBlock.Number(
            title: Label.weeklyChange,
            unit: self.appState.weightUnit.localized,
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
            .padding(.bottom)
    }
    
    var deltaWeightInputHintBlock: some View {

        Text(self.deltaWeightHint)
            .font(.appWelcomeHint)
            .foregroundColor(self.appState.uiTheme.mainTextColor)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 24)
            .padding(.bottom)
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
                            unit: self.appState.energyUnit.localized,
                            textColor: self.appState.uiTheme.mainTextColor
                        )
                            .padding(.vertical, self.appState.uiSizes.setupTargetDeltaPadding)
                    }
                    
                    self.deltaWeightInputHintBlock
                }
            }
        }
    }
    
    var secondStepBlock: some View {
        
        ZStack(alignment: .top) {
            
            VStack(alignment: .center, spacing: 0) {

                self.getTitle(title: Label.almostReady, subtitle: Label.defineGoals)

                self.settingsBlock

                Spacer()
                
                if self.isCurrentWeightEntered && self.isGoalWeightEntered && self.isDeltaWeightEntered {

                    Button(Label.done, action: self.appState.completeFirstSetup)
                        .buttonStyle(AppDefaultButtonStyle(
                            backgroundColor: self.appState.uiTheme.inputBackgroundColor,
                            textColor: self.appState.uiTheme.secondaryTextColor
                        ))
                        .padding(.bottom, self.appState.uiSizes.welcomeConfirmButtonPadding)
                }
            }
        }
    }
    
    var body: some View {
        
        !self.isSecondStep
            ? AnyView( self.firstStepBlock )
            : AnyView( self.secondStepBlock )
    }
}

struct WelcomePage_Previews: PreviewProvider {
    
    static let appState = AppState()

    static var previews: some View {
        
        ZStack(alignment: .top) {

            Self.appState.uiTheme.backgroundColor.edgesIgnoringSafeArea(.all)
            
            WelcomePage().environmentObject(appState)
        }
    }
}
