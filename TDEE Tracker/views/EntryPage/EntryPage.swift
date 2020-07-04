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
        
        let lockIconSize: CGFloat = 80
        
        return VStack(alignment: .center, spacing: 0) {

            if !self.isWeightInputOpen && !self.isFoodInputOpen {
                
                CalendarBlock(
                    selectedDay: self.appState.selectedDay,
                    isTrendsPage: false
                )
            }
            
            EntryHintBlock(
                value: self.appState.recommendedFoodAmount,
                unit: self.appState.energyUnit.rawValue,
                isEnoughData: self.appState.isEnoughDataForRecommendation
            )
                .padding(.top, self.appState.uiSizes.entryHintBlockPadding)
                .padding(.bottom, self.appState.uiSizes.entryHintBlockPadding - 10)
            
            ZStack(alignment: .top) {

                VStack(alignment: .center, spacing: 0) {

                    InputBlock.EntryNumber(
                       icon: "body-sharp",
                       unit: self.appState.weightUnit.rawValue,
                       value: self.$appState.weightInput,
                       onCommit: self.onSubmit,
                       openInput: { self.isWeightInputOpen = true },
                       padding: self.appState.uiSizes.entryInputPadding
                    )

                    InputBlock.EntryNumber(
                       icon: "fast-food-sharp",
                       unit: self.appState.energyUnit.rawValue,
                       value: self.$appState.foodInput,
                       onCommit: self.onSubmit,
                       openInput: { self.isFoodInputOpen = true },
                       padding: self.appState.uiSizes.entryInputPadding
                    )

                    if self.isWeightInputOpen || self.isFoodInputOpen {

                       Button("CONFIRM", action: self.onSubmit)
                            .buttonStyle(AppDefaultButtonStyle())
                            .padding(.vertical)
                    }
                }
                    .padding(.top, 10)
                    .blur(radius: isFutureDate ? 4 : 0)
                    .animation(.easeOut(duration: 0.16))

                if isFutureDate {

                    HStack{
                        Image(systemName: "clock.fill")
                            .frame(width: lockIconSize, height: lockIconSize)
                            .font(.system(size: lockIconSize))
                            .foregroundColor(.appPrimaryDark)
                    }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        .frame(height: self.appState.uiSizes.entryBlockerHeight)
                        .background(Color.appPrimary)
                        .opacity(0.5)
                }
            }
        }
    }
}

struct EntryPage_Previews: PreviewProvider {

    static let appState = AppState()
    
    static var previews: some View {
        
        ZStack(alignment: .top) {
            
            Color.appPrimary.edgesIgnoringSafeArea(.all)
            
            EntryPage().environmentObject(appState)
        }
    }
}
