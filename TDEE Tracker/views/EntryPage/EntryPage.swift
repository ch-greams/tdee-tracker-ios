//
//  EntryPage.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/1/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI



struct EntryPageSizes {
    
    // MARK: - Sizes
    
    public let confirmButtonVPadding: CGFloat
    public let entryInputsTPadding: CGFloat
    public let lockIconSize: CGFloat

    public let entryHintBlockTPadding: CGFloat
    public let entryHintBlockBPadding: CGFloat
    
    public let entryBlockerIconTPadding: CGFloat
    
    // MARK: - Fonts
    
    public let lockIconFont: Font
    
    // MARK: - Init
    
    init(hasNotch: Bool, scale: CGFloat) {

        self.confirmButtonVPadding = scale * 10
        self.entryInputsTPadding = scale * 10
        self.lockIconSize = scale * 80
        
        if hasNotch {
            self.entryHintBlockTPadding = scale * 16
            self.entryHintBlockBPadding = scale * 16 - 10
            
            self.entryBlockerIconTPadding = scale * 75
            
            self.lockIconFont = .system(size: self.lockIconSize)
        }
        else {
            self.entryHintBlockTPadding = scale * 4
            self.entryHintBlockBPadding = scale * 1 - 10
            
            self.entryBlockerIconTPadding = scale * 47
            
            self.lockIconFont = .system(size: self.lockIconSize)
        }
    }
}


struct EntryPage: View {
    
    private let sizes = EntryPageSizes(hasNotch: UISizes.hasNotch, scale: UISizes.scale)

    @EnvironmentObject var appState: AppState
    
    @State private var isWeightInputOpen: Bool = false
    @State private var isFoodInputOpen: Bool = false

    
    
    func onSubmit() {
        
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        
        if self.isWeightInputOpen {
            
            self.appState.updateWeightFromInput()
            self.isWeightInputOpen = false
        }
        
        if self.isFoodInputOpen {
            
            self.appState.updateEnergyFromInput()
            self.isFoodInputOpen = false
        }
        
        self.appState.currentInput = nil
    }
    
    
    var body: some View {
        
        let isFutureDate = self.appState.isFutureDate
        let isInputOpen = self.isWeightInputOpen || self.isFoodInputOpen
        
        return VStack(alignment: .center, spacing: 0) {

            CalendarBlock(
                selectedDay: self.appState.selectedDay,
                isCollapsed: isInputOpen,
                isTrendsPage: false
            )
                .blur(radius: self.appState.tutorialStep.isDoneOrEqual() ? 0 : 8)
            
            EntryHintBlock(
                value: self.appState.recommendedFoodAmount,
                unit: self.appState.energyUnit.localized,
                textColor: self.appState.uiTheme.mainTextColor,
                isEnoughData: self.appState.isEnoughDataForRecommendation
            )
                .padding(.top, self.sizes.entryHintBlockTPadding)
                .padding(.bottom, self.sizes.entryHintBlockBPadding)
                .blur(radius: self.appState.tutorialStep.isDoneOrEqual(.Fourth) ? 0 : 8)
            
            ZStack(alignment: .top) {

                VStack(alignment: .center, spacing: 0) {

                    InputEntryNumber(
                        icon: "body-sharp",
                        unit: self.appState.weightUnit.localized,
                        value: self.$appState.weightInput,
                        openInput: {
                            self.appState.currentInput = InputName.Weight
                            self.isWeightInputOpen = true
                        },
                        isSelected: self.appState.currentInput == InputName.Weight,
                        backgroundColor: self.appState.uiTheme.inputBackgroundColor,
                        backgroundSelectedColor: self.appState.uiTheme.calendarWeekHighlight,
                        accentColor: self.appState.uiTheme.inputAccentColor,
                        accentColorName: self.appState.uiTheme.inputAccentColorName,
                        accentAlternativeColor: self.appState.uiTheme.inputAccentAlternativeColor,
                        accentAlternativeColorName: self.appState.uiTheme.inputAccentAlternativeColorName
                    )
                        .blur(radius: self.appState.tutorialStep.isDoneOrEqual(.Second) ? 0 : 8)

                    InputEntryNumber(
                        icon: "fast-food-sharp",
                        unit: self.appState.energyUnit.localized,
                        value: self.$appState.foodInput,
                        openInput: {
                            self.appState.currentInput = InputName.Food
                            self.isFoodInputOpen = true
                        },
                        isSelected: self.appState.currentInput == InputName.Food,
                        backgroundColor: self.appState.uiTheme.inputBackgroundColor,
                        backgroundSelectedColor: self.appState.uiTheme.calendarWeekHighlight,
                        accentColor: self.appState.uiTheme.inputAccentColor,
                        accentColorName: self.appState.uiTheme.inputAccentColorName,
                        accentAlternativeColor: self.appState.uiTheme.inputAccentAlternativeColor,
                        accentAlternativeColorName: self.appState.uiTheme.inputAccentAlternativeColorName
                    )
                        .blur(radius: self.appState.tutorialStep.isDoneOrEqual(.Third) ? 0 : 8)

                    if isInputOpen {

                        Button(Label.confirm, action: self.onSubmit)
                            .buttonStyle(AppDefaultButtonStyle(
                                backgroundColor: self.appState.uiTheme.inputBackgroundColor,
                                textColor: self.appState.uiTheme.secondaryTextColor
                            ))
                            .padding(.vertical, self.sizes.confirmButtonVPadding)
                    }
                }
                    .padding(.top, self.sizes.entryInputsTPadding)
                    .blur(radius: isFutureDate ? 4 : 0)
                    .opacity(isFutureDate ? 0.75 : 1)
                    .animation(.easeOut(duration: 0.16))
                    .disabled(isFutureDate)

                if isFutureDate {

                    HStack {
                        CustomImage(
                            name: "time-sharp",
                            colorName: self.appState.uiTheme.mainTextColorName
                        )
                            .frame(width: self.sizes.lockIconSize, height: self.sizes.lockIconSize)
                            .font(self.sizes.lockIconFont)
                    }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        .padding(.top, self.sizes.entryBlockerIconTPadding)
                }
            }
        }
    }
}

struct EntryPage_Previews: PreviewProvider {

    static let appState = AppState()
    
    static var previews: some View {
        
        ZStack(alignment: .top) {
            
            Self.appState.uiTheme.backgroundColor.edgesIgnoringSafeArea(.all)
            
            EntryPage().environmentObject(appState)
        }
    }
}
