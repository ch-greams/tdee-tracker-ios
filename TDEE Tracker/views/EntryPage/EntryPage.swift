//
//  EntryPage.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/1/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI


struct EntryPage: View {

    @EnvironmentObject var appState: AppState

    @State private var isWeightInputOpen: Bool = false
    @State private var isFoodInputOpen: Bool = false

    
    
    func onSubmit() {

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
        
        let lockIconSize: CGFloat = 80
        
        let inputPadding = (
            isInputOpen
                ? self.appState.uiSizes.entryInputPadding + self.appState.uiSizes.entryOpenInputOffset
                : self.appState.uiSizes.entryInputPadding
        )
            
        
        return VStack(alignment: .center, spacing: 0) {

            CalendarBlock(
                selectedDay: self.appState.selectedDay,
                isCollapsed: isInputOpen,
                isTrendsPage: false
            )
            
            EntryHintBlock(
                value: self.appState.recommendedFoodAmount,
                unit: self.appState.energyUnit.localized,
                textColor: self.appState.uiTheme.mainTextColor,
                isEnoughData: self.appState.isEnoughDataForRecommendation
            )
                .padding(.top, self.appState.uiSizes.entryHintBlockPadding)
                .padding(.bottom, self.appState.uiSizes.entryHintBlockPadding - 10)
            
            ZStack(alignment: .top) {

                VStack(alignment: .center, spacing: 0) {

                    InputEntryNumber(
                        icon: "body-sharp",
                        unit: self.appState.weightUnit.localized,
                        value: self.$appState.weightInput,
                        onCommit: self.onSubmit,
                        openInput: { self.isWeightInputOpen = true },
                        padding: inputPadding,
                        backgroundColor: self.appState.uiTheme.inputBackgroundColor,
                        accentColor: self.appState.uiTheme.inputAccentColor,
                        accentColorName: self.appState.uiTheme.inputAccentColorName,
                        accentAlternativeColor: self.appState.uiTheme.inputAccentAlternativeColor,
                        accentAlternativeColorName: self.appState.uiTheme.inputAccentAlternativeColorName
                    )

                    InputEntryNumber(
                        icon: "fast-food-sharp",
                        unit: self.appState.energyUnit.localized,
                        value: self.$appState.foodInput,
                        onCommit: self.onSubmit,
                        openInput: { self.isFoodInputOpen = true },
                        padding: inputPadding,
                        backgroundColor: self.appState.uiTheme.inputBackgroundColor,
                        accentColor: self.appState.uiTheme.inputAccentColor,
                        accentColorName: self.appState.uiTheme.inputAccentColorName,
                        accentAlternativeColor: self.appState.uiTheme.inputAccentAlternativeColor,
                        accentAlternativeColorName: self.appState.uiTheme.inputAccentAlternativeColorName
                    )

                    if isInputOpen {

                        Button(Label.confirm, action: self.onSubmit)
                            .buttonStyle(AppDefaultButtonStyle(
                                backgroundColor: self.appState.uiTheme.inputBackgroundColor,
                                textColor: self.appState.uiTheme.secondaryTextColor
                            ))
                            .padding(.vertical, 10)
                    }
                }
                    .padding(.top, 10)
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
                            .frame(width: lockIconSize, height: lockIconSize)
                            .font(.system(size: lockIconSize))
                    }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        .padding(.top, self.appState.uiSizes.entryBlockerIconPadding)
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
