//
//  WelcomePage.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/25/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI

struct WelcomePageStyle {
    
    // MARK: - Sizes
    
    public let titleBPadding: CGFloat = 20
    public let subTitleBPadding: CGFloat = 40
    
    public let weightUnitHintHPadding: CGFloat = 28
    public let energyUnitHintHPadding: CGFloat = 24
    
    public let currentWeightHintHPadding: CGFloat = 24
    public let goalWeightHintHPadding: CGFloat = 28
    public let deltaWeightHintHPadding: CGFloat = 24
    
    public let confirmButtonBPadding: CGFloat
    public let targetDeltaVPadding: CGFloat
    
    // MARK: - Fonts
    
    public let welcomeTitle: Font = .custom(FontOswald.Medium, size: 48)
    public let welcomeSubtitle: Font = .custom(FontOswald.Light, size: 28)
    public let welcomeHint: Font = .custom(FontOswald.Light, size: 22)

    // MARK: - Init
    
    init(uiSizes: UISizes) {
    
        self.confirmButtonBPadding = uiSizes.welcomeConfirmButtonPadding
        self.targetDeltaVPadding = uiSizes.setupTargetDeltaPadding
    }
}

struct WelcomePage: View {
    
    private let style: WelcomePageStyle = WelcomePageStyle(uiSizes: UISizes.current)
    
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
    
    private var isCurrentWeightEntered: Bool { self.appState.weight > 0 }
    private var isGoalWeightEntered: Bool { self.appState.goalWeight > 0 }
    private var isDeltaWeightEntered: Bool { self.appState.goalWeeklyWeightDelta > 0 }

    
    // MARK: - Constants

    var deltaWeightHint: String {
        
        let onePercent = self.appState.weight / 100
        let weightUnitLabel = self.appState.weightUnit.localized

        return "\(Label.deltaWeightHint) \( onePercent.toString() ) \(weightUnitLabel)"
    }
    
    func getTitle(title: String, subtitle: String) -> some View {

        VStack(alignment: .center, spacing: 0) {

            Text(title)
                .font(self.style.welcomeTitle)
                .padding(.bottom, self.style.titleBPadding)
            
            Text(subtitle)
                .font(self.style.welcomeSubtitle)
                .padding(.bottom, self.style.subTitleBPadding)
        }
            .foregroundColor(self.appState.uiTheme.mainTextColor)
    }
    
    // MARK: - Step #1
    
    var unitsBlock: some View {
        
        VStack(alignment: .center, spacing: 0) {
            
            InputToggle(
                title: Label.weight,
                setValue: {
                    self.weightUnit = $0
                    self.isWeightUnitSelected = true
                },
                first: WeightUnit.kg,
                second: WeightUnit.lb,
                selected: self.weightUnit as WeightUnit?,
                backgroundColor: self.appState.uiTheme.inputBackgroundColor,
                accentColor: self.appState.uiTheme.inputAccentColor
            )
                .padding(.bottom)

            if !self.isWeightUnitSelected {
               
                Text(Label.weightUnitHint)
                    .font(self.style.welcomeHint)
                    .foregroundColor(self.appState.uiTheme.mainTextColor)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, self.style.weightUnitHintHPadding)
                    .padding(.bottom)
                
            }
            else {

                InputToggle(
                    title: Label.energy,
                    setValue: {
                        self.energyUnit = $0
                        self.isEnergyUnitSelected = true
                    },
                    first: EnergyUnit.kcal,
                    second: EnergyUnit.kj,
                    selected: self.energyUnit as EnergyUnit?,
                    backgroundColor: self.appState.uiTheme.inputBackgroundColor,
                    accentColor: self.appState.uiTheme.inputAccentColor
                )
                    .padding(.bottom)

                Text(!self.isEnergyUnitSelected ? Label.energyUnitHint : Label.settingsHint)
                    .font(self.style.welcomeHint)
                    .foregroundColor(self.appState.uiTheme.mainTextColor)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, self.style.energyUnitHintHPadding)
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
                    .padding(.bottom, self.style.confirmButtonBPadding)
            }
        }
    }
    
    // MARK: - Step #2 Inputs & Hints
    
    var currentWeightInputBlock: some View {
        
        InputNumber(
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
            backgroundColor: self.appState.uiTheme.inputBackgroundColor,
            backgroundColorName: self.appState.uiTheme.inputBackgroundColorName,
            confirmButtonColor: self.appState.uiTheme.inputConfirmButtonColor,
            accentColor: self.appState.uiTheme.inputAccentColor
        )
            .padding(.bottom)
    }
    
    var currentWeightInputHintBlock: some View {
        
        Text(Label.currentWeightHint)
            .font(self.style.welcomeHint)
            .foregroundColor(self.appState.uiTheme.mainTextColor)
            .multilineTextAlignment(.center)
            .padding(.horizontal, self.style.currentWeightHintHPadding)
            .padding(.bottom)
    }
    
    var goalWeightInputBlock: some View {
        
        InputNumber(
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
            backgroundColor: self.appState.uiTheme.inputBackgroundColor,
            backgroundColorName: self.appState.uiTheme.inputBackgroundColorName,
            confirmButtonColor: self.appState.uiTheme.inputConfirmButtonColor,
            accentColor: self.appState.uiTheme.inputAccentColor
        )
            .padding(.bottom)
    }
    
    var goalWeightInputHintBlock: some View {
        Text(Label.goalWeightHint)
            .font(self.style.welcomeHint)
            .foregroundColor(self.appState.uiTheme.mainTextColor)
            .multilineTextAlignment(.center)
            .padding(.horizontal, self.style.goalWeightHintHPadding)
            .padding(.bottom)
    }
    
    var deltaWeightInputBlock: some View {
        
        InputNumber(
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
            backgroundColor: self.appState.uiTheme.inputBackgroundColor,
            backgroundColorName: self.appState.uiTheme.inputBackgroundColorName,
            confirmButtonColor: self.appState.uiTheme.inputConfirmButtonColor,
            accentColor: self.appState.uiTheme.inputAccentColor
        )
            .padding(.bottom)
    }
    
    var deltaWeightInputHintBlock: some View {

        Text(self.deltaWeightHint)
            .font(self.style.welcomeHint)
            .foregroundColor(self.appState.uiTheme.mainTextColor)
            .multilineTextAlignment(.center)
            .padding(.horizontal, self.style.deltaWeightHintHPadding)
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
                            .padding(.vertical, self.style.targetDeltaVPadding)
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
                        .padding(.bottom, self.style.confirmButtonBPadding)
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
