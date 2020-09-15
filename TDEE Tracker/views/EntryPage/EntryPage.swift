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
    
    public let confirmButtonVPadding: CGFloat = 10
    public let entryInputsTPadding: CGFloat = 10
    public let lockIconSize: CGFloat = 80

    public let entryHintBlockTPadding: CGFloat
    public let entryHintBlockBPadding: CGFloat
    
    public let entryBlockerIconTPadding: CGFloat
    
    // MARK: - Fonts
    
    public let lockIconFont: Font
    
    // MARK: - Init
    
    init(uiSizes: UISizes) {
        
        self.entryHintBlockTPadding = uiSizes.entryHintBlockPadding
        self.entryHintBlockBPadding = uiSizes.entryHintBlockPadding - 10
        
        self.entryBlockerIconTPadding = uiSizes.entryBlockerIconPadding
        
        self.lockIconFont = .system(size: self.lockIconSize)
    }
}


struct EntryPage: View {
    
    private let sizes = EntryPageSizes(uiSizes: UISizes.current)

    @EnvironmentObject var appState: AppState
    
    @State private var isWeightInputOpen: Bool = false
    @State private var isFoodInputOpen: Bool = false

    
    
    func onSubmit() {
        
        UIImpactFeedbackGenerator(style: .light).impactOccurred()

        UIApplication.shared.endEditing()
        
        if self.isWeightInputOpen {
            
            self.appState.updateWeightFromInput()
            self.isWeightInputOpen = false
        }
        
        if self.isFoodInputOpen {
            
            self.appState.updateEnergyFromInput()
            self.isFoodInputOpen = false
        }
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
                        onCommit: self.onSubmit,
                        openInput: { self.isWeightInputOpen = true },
                        isOpen: isInputOpen,
                        backgroundColor: self.appState.uiTheme.inputBackgroundColor,
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
                        onCommit: self.onSubmit,
                        openInput: { self.isFoodInputOpen = true },
                        isOpen: isInputOpen,
                        backgroundColor: self.appState.uiTheme.inputBackgroundColor,
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
